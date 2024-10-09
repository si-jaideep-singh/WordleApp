//////////
//////////  GameViewModel.swift
//////////  WordleApp


import SwiftUI

final class WordleGameViewModel: ObservableObject {
    @Published private(set) var state: WordleState = WordleState()
    private let apiService = ServiceManager()
    var tokens: String = ""

    var isCurrentWordComplete: Bool {
        return state.currentGuess.count == state.submittedWordValue?.wordLength
    }

    func initCall() {
        Task {
            await self.login()
            await self.getSubmittedWord(userguid: "")
        }
    }

    func setupGame() {
        DispatchQueue.main.async {
            let wordLength = self.state.submittedWordValue?.wordLength ?? 1
            let maxAttempts = self.state.maxAttempts
            let currentAttempt = (self.state.submittedWordValue?.attemptNo ?? 1) - 1

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
                userID: 111,
                tourID: 1,
                tourGamedayId: self.state.submittedWordValue?.gdId ?? -1,
                langCode: "en",
                platformId: 3,
                attemptNo: self.state.currentAttempt + 1,
                userWord: self.state.currentGuess,
                userHint: 1
            )
        }
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

    private func deleteLastLetter() {
        guard !state.currentGuess.isEmpty else { return }
        state.currentGuess.removeLast()
        updateBoardAfterDeletion()
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
        DispatchQueue.main.async { [self] in
            guard let submitFlag = self.state.submitWordValue?.userSubmitflag else {
                print("No submitFlag found")
                return
            }
            let (guessResult, keyColorMap) = self.evaluateGuess(submitFlag: submitFlag)
            
            self.flipCellsInRowSequentially(self.state.currentAttempt, colors: guessResult) {
                self.updateKeyColors(with: keyColorMap)
                self.checkGameEndCondition()
                if !self.state.gameEnded {
                               self.state.currentAttempt += 1
                               self.state.currentGuess = ""
                           }
                
            }
        }
           
    }

    private func evaluateGuess(submitFlag: [Int]) -> ([Color], [Character: Color]) {
        var colors: [Color] = Array(repeating: .emptyCell, count: state.board[state.currentAttempt].count)
        state.currentGuess = self.state.submitWordValue?.userWord ?? ""
        var keyColorMap: [Character: Color] = [:]

        let minCount = submitFlag.count

        for i in 0..<minCount {
            let color: Color
            switch submitFlag[i] {
            case 0:
                color = .wrong
            case 1:
                color = .correct
            case 2:
                color = .misplaced
            default:
                color = .emptyCell
            }
            colors[i] = color

            let letter = state.currentGuess[state.currentGuess.index(state.currentGuess.startIndex, offsetBy: i)].uppercased().first ?? " "
            keyColorMap[letter] = color
        }

        return (colors, keyColorMap)
    }

    private func flipCellsInRowSequentially(_ row: Int, colors: [Color], completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            guard row >= 0 && row < self.state.board.count else { return }
            self.flipCellInRow(row, at: 0, colors: colors) {
                self.state.rowCompleted[row] = true

                if row + 1 < self.state.rowCompleted.count {
                    self.state.rowCompleted[row + 1] = false
                    self.state.borderColors[row + 1][0] = .border
                }

                completion()
            }
        }
    }

    private func flipCellInRow(_ row: Int, at index: Int, colors: [Color], completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            guard row >= 0 && row < self.state.board.count && index < self.state.board[row].count else {
                completion()
                return
            }

            withAnimation(.easeInOut(duration: 0.8)) {
                self.state.cellFlipped[row][index] = true
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.state.rowColors[row][index] = colors[index]
                self.state.borderColors[row][index] = .clear

                if index + 1 < self.state.board[row].count {
                    self.flipCellInRow(row, at: index + 1, colors: colors, completion: completion)
                } else {
                    completion()
                }
            }
        }
    }

    private func updateKeyColors(with keyColorMap: [Character: Color]) {
        for (letter, color) in keyColorMap {
            let uppercaseLetter = letter.uppercased()
            if let asciiValue = uppercaseLetter.first?.asciiValue, asciiValue >= 65 && asciiValue <= 90 {
                let colorIndex = Int(asciiValue - 65)
                if colorIndex < state.keyColors.count {
                    state.keyColors[colorIndex] = color
                }
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

    func resetGame() {
        state = WordleState()
        state.gameCompleted = false
        initCall()
    }

    private func checkGameEndCondition() {
       if state.submitWordValue?.userSubmitflag?.allSatisfy({ $0 == 1 }) == true {
            state.gameEnded = true
            state.gameWon = true
           // showToast(message: "Congratulations! You've guessed the word!")
        }
        // Then, check if the maximum number of attempts has been reached
        else if state.currentAttempt >= state.maxAttempts - 1 {
            state.gameEnded = true
           // showToast(message: "Game Over! You've reached the maximum number of attempts.")
        }
    }
    func submitWord(userID: Int, tourID: Int, tourGamedayId: Int, langCode: String?, platformId: Int, attemptNo: Int, userWord: String?, userHint: Int) async {
        do {
            let pathType: PathType = .submitWord(userguid: "42dba320-c59f-11ee-9dd4-0a2e0486673f")
            let requestBody = SubmitWordPayload(userId: userID, tourId: tourID, tourGamedayId: tourGamedayId, langCode: langCode, platformId: platformId, attemptNo: attemptNo, userWord: userWord, userHint: userHint)
            
            let jsonData = try requestBody.encodeJSON()
            
            let submitWordURN = SubmitWordURN(pathType: pathType, body: jsonData)
            let submitWordResponse = try await apiService.execute(with: submitWordURN)
            
            DispatchQueue.main.async {
                if submitWordResponse.meta?.retVal == -90 {
                    // Word not in the list, prevent row update
                    self.showToast(message: "Word not in the list")
                    //                        self.state.currentGuess = ""
                } else if submitWordResponse.meta?.retVal == 1 {
                    // Word is valid, update row and game state
                    if let responseValue = submitWordResponse.data?.value {
                        switch responseValue {
                        case .responseValue(let response):
                            self.state.submitWordValue = response
                            self.state.userSubmitflag = response.userSubmitflag ?? []
                            self.checkGuess()
                           
                            
                        case .integerValue(let intValue):
                            print("Unexpected integer value: \(intValue)")
                        }
                    }
                } else {
                    self.showToast(message: "Something went wrong")
                }
            }
        } catch {
            DispatchQueue.main.async {
                print("Error submitting word:", error)
                self.showToast(message: "Error submitting word")
            }
        }
    }

    func login() async {
                  do {
                      let cookies = tokens
                      let pathType: PathType = .login(waf_guid: "")
                      let requestBody = ""
                      let loginURN = LoginURN(cookie: cookies, pathType: pathType, body: requestBody.data(using: .utf8))
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

