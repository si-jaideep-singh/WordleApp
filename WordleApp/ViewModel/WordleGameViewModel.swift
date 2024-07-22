////
////  GameViewModel.swift
////  WordleApp
import SwiftUI

final class WordleGameViewModel: ObservableObject {
    @Published private(set) var state: WordleState = WordleState()
    private let apiService = ServiceManager()
    
    var isCurrentWordComplete: Bool {
        return state.currentGuess.count == state.submittedWordValue?.last?.wordLength
    }
    
    func initCall() {
        Task {
            await self.login()
            await self.getSubmittedWord(userguid: "")
        }
    }
    
    func setupGame() {
        DispatchQueue.main.async {
            let wordLength = self.state.submittedWordValue?.last?.wordLength ?? 1
            let maxAttempts = self.state.maxAttempts
            let currentAttempt = (self.state.submittedWordValue?.last?.attemptNo ?? 1)
            
            self.state.board = Array(repeating: Array(repeating: "", count: wordLength), count: maxAttempts)
            self.state.rowCompleted = Array(repeating: false, count: maxAttempts)
            self.state.rowColors = Array(repeating: Array(repeating: .emptyCell, count: wordLength), count: maxAttempts)
            self.state.keyColors = Array(repeating: .clear, count: 26)
            self.state.cellFlipped = Array(repeating: Array(repeating: false, count: wordLength), count: maxAttempts)
            self.state.borderColors = Array(repeating: Array(repeating: .clear, count: wordLength), count: maxAttempts)
            self.state.currentAttempt = currentAttempt
            
            if currentAttempt < maxAttempts {
                self.state.borderColors[currentAttempt][0] = .border
            }
            
        }
        
    }
    
    func addLetter(_ letter: String) {
        guard state.currentGuess.count < state.board[state.currentAttempt].count else { return }
        state.currentGuess.append(letter)
        updateBoard(letter)
    }
    
    func handleSpecialKey(_ specialKey: String) {
        switch specialKey {
        case "Delete":
            if !state.rowCompleted[state.currentAttempt] {
                deleteLastLetter()
            }
        case "Enter":
            submitGuess()
        default:
            break
        }
    }
    
    private func submitGuess() {
        guard state.currentGuess.count == state.board[state.currentAttempt].count else { return }
        
        Task {
            await self.submitWord(
                userID: 0,
                tourID: 1,
                tourGamedayId: self.state.submittedWordValue?.last?.gdId ?? -1,
                langCode: "en",
                platformId: 3,
                attemptNo: self.state.currentAttempt + 1,
                userWord: self.state.currentGuess,
                userHint: 1
            )
        }
       
      
    }
    
    private func deleteLastLetter() {
        guard !state.currentGuess.isEmpty else { return }
        state.currentGuess.removeLast()
        updateBoardAfterDeletion()
    }
    
    private func updateBoard(_ letter: String) {
        for col in 0..<state.board[state.currentAttempt].count {
            if state.board[state.currentAttempt][col].isEmpty {
                state.board[state.currentAttempt][col] = letter
                state.borderColors[state.currentAttempt][col] = .clear
                
                if col + 1 < state.board[state.currentAttempt].count {
                    state.borderColors[state.currentAttempt][col + 1] = .border
                }
                return
            }
        }
    }
    
    private func updateBoardAfterDeletion() {
        for col in (0..<state.board[state.currentAttempt].count).reversed() {
            if !state.board[state.currentAttempt][col].isEmpty {
                state.board[state.currentAttempt][col] = ""
                state.borderColors[state.currentAttempt][col] = .border
                
                if col + 1 < state.board[state.currentAttempt].count {
                    state.borderColors[state.currentAttempt][col + 1] = .clear
                }
                return
            }
        }
        state.borderColors[state.currentAttempt][0] = .border
    }
    
    private func checkGuess() {
        DispatchQueue.main.async {
            guard let submitFlag = self.state.submitWordValue?.userSubmitflag else {
                print("No submitFlag found")
                return
            }
            print("submitFlag: \(submitFlag)")
            let guessResult = self.evaluateGuess(submitFlag: submitFlag)
            print("guessResult: \(guessResult)")
            
            self.flipCellsInRowSequentially(self.state.currentAttempt, colors: guessResult) {
                self.updateKeyColors(guess: self.state.currentGuess, colors: guessResult)
            }
        }
    }
    private func evaluateGuess(submitFlag: [Int]) -> [Color] {
        var colors: [Color] = Array(repeating: .emptyCell, count: state.board[state.currentAttempt].count)
            
            for i in 0..<submitFlag.count {
                switch submitFlag[i] {
                case 0:
                    colors[i] = .wrong
                case 1:
                    colors[i] = .misplaced
                case 2:
                    colors[i] = .correct
                default:
                    colors[i] = .emptyCell
                }
            }
        print("Evaluated Colors: \(colors)")
            return colors
        }
    
    
    private func flipCellsInRowSequentially(_ row: Int, colors: [Color], completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            guard row < self.state.board.count else { return }
            self.flipCellInRow(row, at: 0, colors: colors, completion: completion)
        }
    }
    
    private func flipCellInRow(_ row: Int, at index: Int, colors: [Color], completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            guard row < self.state.board.count && index < self.state.board[row].count else {
                print("Flipping completed for row: \(row)")
                completion()
                return
            }
        }
        
        withAnimation(.easeInOut(duration: 0.8)) {
            self.state.cellFlipped[row][index] = true
            self.state.rowCompleted[self.state.currentAttempt] = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.state.rowColors[row][index] = colors[index]
            self.state.borderColors[row][index] = .clear
            
            if index + 1 < self.state.board[row].count {
                print("Flipping cell at row: \(row), index: \(index + 1)")
                self.flipCellInRow(row, at: index + 1, colors: colors, completion: completion)
            } else {
                print("Completed flipping row: \(row)")
                completion()
            }
        }
    }
    
    private func showToast(message: String) {
        DispatchQueue.main.async {
            self.state.showToast = true
            self.state.toastMessage = message
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.state.showToast = false
            }
        }
    }
    
    private func updateKeyColors(guess: String, colors: [Color]) {
        for (index, letter) in guess.enumerated() {
            if let letterIndex = state.letters.firstIndex(of: letter) {
                let colorIndex = state.letters.distance(from: state.letters.startIndex, to: letterIndex)
                if state.keyColors[colorIndex] != .correct {
                    state.keyColors[colorIndex] = colors[index]
                }
            }
        }
    }
    
    func resetGame() {
        state = WordleState()
        state.gameCompleted = false
        initCall()
    }
    
    func submitWord(userID: Int, tourID: Int, tourGamedayId: Int, langCode: String?, platformId: Int, attemptNo: Int, userWord: String?, userHint: Int) async {
        do {
            let pathType: PathType = .submitWord(userguid: "42dba320-c59f-11ee-9dd4-0a2e0486673f")
            let requestBody = SubmitWordPayload(userId: userID, tourId: tourID, tourGamedayId: tourGamedayId, langCode: langCode, platformId: platformId, attemptNo: attemptNo, userWord: userWord, userHint: userHint)
            
            let jsonData = try requestBody.encodeJSON()
            
            let submitWordURN = SubmitWordURN(pathType: pathType, body: jsonData)
            let submitWordResponse = try await apiService.execute(with: submitWordURN)
            
            if submitWordResponse.meta?.retVal == -90 {
                showToast(message: "Word not in the list")
            } else if submitWordResponse.meta?.retVal == 1 {
                
                if let responseValue = submitWordResponse.data?.value {
                    switch responseValue {
                    case .responseValue(let response):
                        self.state.submitWordValue = response
                        self.state.userSubmitflag = response.userSubmitflag ?? []
                         checkGuess()
                       // print("submitWordValue: \(response)")
                    case .integerValue(let intValue):
                        print("Unexpected integer value: \(intValue)")
                    }
                }

                state.currentAttempt += 1
                
                if state.currentAttempt >= state.maxAttempts {
                    state.gameEnded = true
                    state.gameWon = false
                    state.gameCompleted = true
                } else {
                    state.borderColors[state.currentAttempt][0] = .border
                    state.currentGuess = ""
                }
            } else {
                showToast(message: "Something went wrong")
            }
        } catch {
            print("Error submitting word:", error)
        }
    }
    
    func login() async {
        do {
            let pathType: PathType = .login(waf_guid: "")
            let requestBody = ""
            let loginURN = LoginURN(pathType: pathType, body: requestBody.data(using: .utf8))
            _ = try await apiService.execute(with: loginURN)
        } catch {
            print("Error logging in:", error)
        }
    }
    
    func getSubmittedWord(userguid: String) async {
        do {
            let pathType: PathType = .getSummitttedWord(userguid: userguid)
            let submittedURN = SubmittedWord(pathType: pathType)
            let submittedWordData = try await apiService.execute(with: submittedURN)
           
            if let value = submittedWordData.data?.value {
                self.state.submittedWordValue = value
                    self.setupGame()
             } else {
                DispatchQueue.main.async { [weak self] in
                    self?.showToast(message: "No value found in the response")
                }
            }
        } catch DecodingError.typeMismatch(let type, let context) {
            DispatchQueue.main.async { [weak self] in
                self?.showToast(message: "Something went wrong: \(context.debugDescription)")
            }
        } catch {
            DispatchQueue.main.async { [weak self] in
                self?.showToast(message: "Failed to fetch submitted word")
            }
            print("Error fetching Word:", error)
        }
    }
}



