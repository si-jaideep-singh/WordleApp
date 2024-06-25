//
//  GameViewModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.
import SwiftUI

final class WordleGameViewModel: ObservableObject {
    @Published private(set) var state : WordleState = WordleState()
    @Published var gameCompleted: Bool = false
    var isCurrentWordComplete: Bool {
           return state.currentGuess.count == state.wordlength
       }

    func initCall(){
        self.state.wordlength = state.targetWord.count
        self.state.board = Array(repeating: Array(repeating: "", count: state.wordlength), count: state.maxAttempts)
        self.state.rowCompleted = Array(repeating: false, count: state.maxAttempts)
        self.state.rowColors = Array(repeating: Array(repeating: .empyCell, count: state.wordlength), count: state.maxAttempts)
        self.state.keyColors = Array(repeating: .clear, count: 26)
        self.state.cellFlipped = Array(repeating: Array(repeating: false, count: state.wordlength), count: state.maxAttempts)
        self.state.borderColors = Array(repeating: Array(repeating: .clear, count: state.wordlength), count: state.maxAttempts)
                
    }
    
    func addLetter(_ letter: String) {
        guard state.currentGuess.count < state.board[state.currentRow].count else { return }
        state.currentGuess.append(letter)
        updateBoard(letter)
    }
    
    func handleSpecialKey(_ specialKey: String) {
        switch specialKey {
        case "Delete":
         deleteLastLetter()
        clearLastNonEmptyCell()
        case "Enter":
            checkGuess()
        default:
            break
        }
    }
    
    private func deleteLastLetter() {
        guard !state.currentGuess.isEmpty else { return }
        
        if state.rowCompleted[state.currentRow] || state.isGuessCorrect {
            return
        }
         state.currentGuess.removeLast()
    }
   
    private func clearLastNonEmptyCell() {
        for col in (0..<state.board[state.currentRow].count).reversed() {
            if !state.board[state.currentRow][col].isEmpty {
                state.board[state.currentRow][col] = ""
                state.borderColors[state.currentRow][col] = .clear
                return
            }
        }
    }
    
    private func updateBoard(_ letter: String) {
        for col in 0..<state.board[state.currentRow].count {
            if state.board[state.currentRow][col].isEmpty {
                state.board[state.currentRow][col] = letter
                state.borderColors[state.currentRow][col] = .border
                return
            }
        }
    }
    
    private func checkGuess() {
        guard state.currentGuess.count == state.board[state.currentRow].count else { return }
        let guessResult = evaluateGuess(guess: state.currentGuess)
        updateKeyColors(guess: state.currentGuess, colors: guessResult.colors)
        flipCellsInRowSequentially(state.currentRow, colors: guessResult.colors)
    }
    
    private func evaluateGuess(guess: String) -> (correctPosition: Int, colors: [Color], guessedLetters: [Character]) {
        var correctPosition = 0
        var colors: [Color] = Array(repeating: .empyCell, count: state.board[state.currentRow].count)
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
    
        private func flipCellsInRowSequentially(_ row: Int, colors: [Color]) {
            guard row < state.board.count else { return }
            flipCellInRow(row, at: 0, colors: colors) {
    
                self.showCompletionToast()
            }
        }
    
        private func flipCellInRow(_ row: Int, at index: Int, colors: [Color], completion: @escaping () -> Void) {
            guard row < state.board.count && index < state.board[row].count else {
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
    
    private func showCompletionToast() {
          if evaluateGuess(guess: state.currentGuess).correctPosition == state.targetWord.count {
              state.gameEnded = true
              gameCompleted = true
          } else {
              state.currentRow += 1
              if state.currentRow >= state.maxAttempts {
                  state.gameEnded = true
                  gameCompleted = true 
              }
          }
          state.currentGuess = ""
      }
    
//        private func showCompletionToast() {
//            if evaluateGuess(guess: state.currentGuess).correctPosition == state.targetWord.count {
//              // Player wins
//                showToast(message: "Congratulations! You've guessed the word!")
//                state.gameEnded = true 
//                state.rowCompleted[state.currentRow] = true
//                    state.isGuessCorrect = true
//            } else {
//                state.currentRow += 1
//                if state.currentRow >= state.maxAttempts {
//                    state.gameEnded = true
//                    showToast(message: "Game Over! The correct word was \(state.targetWord).")
//                } else {
//                    showToast(message: "Attempts left: \(state.attemptsLeft)")
//                }
//            }
//            state.currentGuess = ""
//        }
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
         private func showToast(message: String) {
            self.state.message = message
            self.state.showMessage = true
    
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    self.state.showMessage = false
                }
            }
        }
    
    func resetGame() {
            state = WordleState()
            gameCompleted = false
            initCall()
       }
    }
   
