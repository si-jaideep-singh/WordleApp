////
////  GameViewModel.swift
////  WordleApp

import SwiftUI

final class WordleGameViewModel: ObservableObject {
    @Published private(set) var state: WordleState = WordleState()
    
    
    private let apiService = ServiceManager()
    var isCurrentWordComplete: Bool {
        return state.currentGuess.count == state.wordlength
    }
    
    func initCall() {
        
        self.state.wordlength = state.targetWord.count
        self.state.board = Array(repeating: Array(repeating: "", count: state.wordlength), count: state.maxAttempts)
        self.state.rowCompleted = Array(repeating: false, count: state.maxAttempts)
        self.state.rowColors = Array(repeating: Array(repeating: .emptyCell, count: state.wordlength), count: state.maxAttempts)
        self.state.keyColors = Array(repeating: .clear, count: 26)
        self.state.cellFlipped = Array(repeating: Array(repeating: false, count: state.wordlength), count: state.maxAttempts)
        self.state.borderColors = Array(repeating: Array(repeating: .clear, count: state.wordlength), count: state.maxAttempts)
        self.state.borderColors[state.currentRow][0] = .border
        
        Task {
            await self.login()
            await self.getSubmittedWord(userguid: "")
           
             }
    }
    
    func addLetter(_ letter: String) {
        guard state.currentGuess.count < state.board[state.currentRow].count else { return }
        state.currentGuess.append(letter)
        updateBoard(letter)
    }
    
    func handleSpecialKey(_ specialKey: String) {
        switch specialKey {
        case "Delete":
            if !state.rowCompleted[state.currentRow] {
                deleteLastLetter()
            }
        case "Enter":
            checkGuess()
           
        default:
            break
        }
    }
    
    private func deleteLastLetter() {
        guard !state.currentGuess.isEmpty else { return }
        state.currentGuess.removeLast()
        updateBoardAfterDeletion()
    }
    
    private func updateBoard(_ letter: String) {
        for col in 0..<state.board[state.currentRow].count {
            if state.board[state.currentRow][col].isEmpty {
                state.board[state.currentRow][col] = letter
                state.borderColors[state.currentRow][col] = .clear
                
                if col + 1 < state.board[state.currentRow].count {
                    state.borderColors[state.currentRow][col + 1] = .border
                }
                return
            }
        }
    }
    
    private func updateBoardAfterDeletion() {
        for col in (0..<state.board[state.currentRow].count).reversed() {
            if !state.board[state.currentRow][col].isEmpty {
                state.board[state.currentRow][col] = ""
                state.borderColors[state.currentRow][col] = .border
                
                if col + 1 < state.board[state.currentRow].count {
                    state.borderColors[state.currentRow][col + 1] = .clear
                }
                return
            }
        }
        state.borderColors[state.currentRow][0] = .border
    }
    
    private func checkGuess() {
        guard state.currentGuess.count == state.board[state.currentRow].count else { return }
        let guessResult = evaluateGuess(guess: state.currentGuess)
        
        flipCellsInRowSequentially(state.currentRow, colors: guessResult.colors) {
            self.updateKeyColors(guess: self.state.currentGuess, colors: guessResult.colors)
            Task {
                await self.submitWord(
                    userID: 0,
                    tourID:1,
                    tourGamedayId: self.state.gdId ?? -1,
                    langCode: "en",
                    platformId: 3,
                    attemptNo: self.state.currentRow + 1,
                    userWord: self.state.currentGuess,
                    userHint: 1
                )
             }
            self.showCompletionToast()
            
           
        }
    }

    private func evaluateGuess(guess: String) -> (correctPosition: Int, colors: [Color], guessedLetters: [Character]) {
        var correctPosition = 0
        var colors: [Color] = Array(repeating: .EmptyCellColor, count: state.board[state.currentRow].count)
        let guessArray = Array(guess)
        let targetArray = Array(state.targetWord)
        var guessedLetters = [Character]()
        
        for i in 0..<state.board[state.currentRow].count {
            guessedLetters.append(guessArray[i])
            if guessArray[i] == targetArray[i] {
                correctPosition += 1
                colors[i] = .correct
            } else if targetArray.contains(guessArray[i]) {
                colors[i] = .misplaced
            } else {
                colors[i] = .wrong
            }
        }
        
        return (correctPosition, colors, guessedLetters)
    }
    
    private func flipCellsInRowSequentially(_ row: Int, colors: [Color], completion: @escaping () -> Void) {
        guard row < state.board.count else { return }
        flipCellInRow(row, at: 0, colors: colors, completion: completion)
    }
    
    private func flipCellInRow(_ row: Int, at index: Int, colors: [Color], completion: @escaping () -> Void) {
        guard row < state.board.count && index < state.board[row].count else {
            completion()
            return
        }
        
        withAnimation(.easeInOut(duration: 0.8)) {
            self.state.cellFlipped[row][index] = true
            self.state.rowCompleted[self.state.currentRow] = true
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
    
    private func showCompletionToast() {
        let correctPosition = evaluateGuess(guess: state.currentGuess).correctPosition
        
        if correctPosition == state.targetWord.count {
            state.gameEnded = true
            state.gameWon = true
            state.gameCompleted = true
        } else {
            state.currentRow += 1
            
            if state.currentRow >= state.maxAttempts {
                state.gameEnded = true
                state.gameWon = false
                state.gameCompleted = true
            } else {
                state.borderColors[state.currentRow][0] = .border
                
                let attemptsLeft = state.maxAttempts - state.currentRow
                showToast(message: "\(attemptsLeft) attempts left")
            }
        }
        
        state.currentGuess = ""
    }
    
    private func showToast(message: String) {
        state.showToast = true
        state.toastMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.state.showToast = false
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
            
            print("Submit Word Response:", submitWordResponse)
        } catch 
            {
             print("Error submitting word:", error)
            }
    }
    
    func  login() async {
        
        do {
            let pathType: PathType = .login(waf_guid: "")
            let requestBody = ""
            
            let jsonData = try requestBody.encodeJSON()
            let loginURN = LoginURN(pathType: pathType,body: jsonData)
            let loginResponse = try await apiService.execute(with: loginURN)
           // print("Submit Word Response:", loginResponse)
        } catch
            {
             print("Error login:", error)
            }
    }
    
    
     func getSubmittedWord(userguid: String) async {
        do {
                let pathType: PathType = .getSummitttedWord(userguid: userguid)
                let submittedURN = SubmittedWord(pathType: pathType)
                let SubmittedWordData = try await apiService.execute(with: submittedURN)
            
                 if let gdId = SubmittedWordData.data?.value?.gdId {
                          self.state.gdId = gdId
                    }
            
                if let wordLength = SubmittedWordData.data?.value?.wordLength {
                           self.state.wordlength = wordLength
                   }
                if let userFlags = SubmittedWordData.data?.value?.userSubmitflag {
//                        self.state.usersubmitflag = userFlags
                    }
                 let userWord =  state.currentGuess
            //   let gdID = SubmittedWordData.data?.value?.gdId
                 
                print("User's submitted word:",userWord)
            } 
             catch
            {
                print("Error fetching Word:", error)
            }
        }
    
    
    }
    




