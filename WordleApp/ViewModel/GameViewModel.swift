//
//  GameViewModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.
//
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var board: [[String]]
    @Published var rowCompleted: [Bool]
    @Published var rowColors: [[Color]]
    @Published var keyColors: [Color]
    @Published var cellFlipped: [[Bool]]
    @Published var borderColors: [[Color]]
    @Published var gameEnded: Bool = false
    @Published var message: String = ""
    @Published var showMessage: Bool = false
    
    let letters = "QWERTYUIOPASDFGHJKLZXCVBNM"
    
    let targetWord = "APPLEAPPLE"
    let maxAttempts = 6
    let wordlength: Int
    var currentRow = 0
    var currentGuess = ""
    
    var attemptsLeft: Int {
        return maxAttempts - currentRow
    }
    
    init() {
        self.wordlength = targetWord.count
        self.board = Array(repeating: Array(repeating: "", count: wordlength), count: maxAttempts)
        self.rowCompleted = Array(repeating: false, count: maxAttempts)
        self.rowColors = Array(repeating: Array(repeating: .EmpyCellColor, count: wordlength), count: maxAttempts)
        self.keyColors = Array(repeating: .EmpyCellColor, count: 26)
        self.cellFlipped = Array(repeating: Array(repeating: false, count: wordlength), count: maxAttempts)
        self.borderColors = Array(repeating: Array(repeating: .gray, count: wordlength), count: maxAttempts)
    }
    
    func addLetter(_ letter: String) {
        guard currentGuess.count < board[currentRow].count else { return }
        currentGuess.append(letter)
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
        guard !currentGuess.isEmpty else { return }
        currentGuess.removeLast()
    }
    
    private func clearLastNonEmptyCell() {
        for col in (0..<board[currentRow].count).reversed() {
            if !board[currentRow][col].isEmpty {
                board[currentRow][col] = ""
                borderColors[currentRow][col] = .gray 
                return
            }
        }
    }
    
    private func updateBoard(_ letter: String) {
        for col in 0..<board[currentRow].count {
            if board[currentRow][col].isEmpty {
                board[currentRow][col] = letter
                borderColors[currentRow][col] = .red
                return
            }
        }
    }
    
    private func checkGuess() {
        guard currentGuess.count == board[currentRow].count else { return }
        let guessResult = evaluateGuess(guess: currentGuess)
        updateKeyColors(guess: currentGuess, colors: guessResult.colors)
        flipCellsInRowSequentially(currentRow, colors: guessResult.colors)
    }
    
    private func evaluateGuess(guess: String) -> (correctPosition: Int, colors: [Color], guessedLetters: [Character]) {
        var correctPosition = 0
        var colors: [Color] = Array(repeating: .gray, count: board[currentRow].count)
        let guessArray = Array(guess)
        let targetArray = Array(targetWord)
        var guessedLetters = [Character]()
        
        for i in 0..<board[currentRow].count {
            guessedLetters.append(guessArray[i])
            if guessArray[i] == targetArray[i] {
                correctPosition += 1
                colors[i] = .green
            } else if targetArray.contains(guessArray[i]) {
                colors[i] = .yellow
            } else {
                colors[i] = .gray
            }
        }
        
        return (correctPosition, colors, guessedLetters)
    }
    
    private func flipCellsInRowSequentially(_ row: Int, colors: [Color]) {
        guard row < board.count else { return }
        flipCellInRow(row, at: 0, colors: colors) {
            // This closure is called when the flipping of the entire row is complete.
            self.showCompletionToast()
        }
    }
    
    private func flipCellInRow(_ row: Int, at index: Int, colors: [Color], completion: @escaping () -> Void) {
        guard row < board.count && index < board[row].count else {
            completion()
            return
        }
        
        withAnimation(.easeInOut(duration: 0.8)) {
            self.cellFlipped[row][index] = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.rowColors[row][index] = colors[index]
            self.borderColors[row][index] = .clear
            if index + 1 < self.board[row].count {
                self.flipCellInRow(row, at: index + 1, colors: colors, completion: completion)
            } else {
                completion()
            }
        }
    }
    
    private func showCompletionToast() {
        if evaluateGuess(guess: currentGuess).correctPosition == targetWord.count {
            gameEnded = true // Player wins
            showToast(message: "Congratulations! You've guessed the word!")
        } else {
            currentRow += 1
            if currentRow >= maxAttempts {
                gameEnded = true
                showToast(message: "Game Over! The correct word was \(targetWord).")
            } else {
                showToast(message: "Attempts left: \(attemptsLeft)")
            }
        }
        currentGuess = ""
    }
    
    private func updateKeyColors(guess: String, colors: [Color]) {
        for (index, letter) in guess.enumerated() {
            if let letterIndex = letters.firstIndex(of: letter) {
                let colorIndex = letters.distance(from: letters.startIndex, to: letterIndex)
                keyColors[colorIndex] = colors[index]
            }
        }
    }
    
    private func showToast(message: String) {
        self.message = message
        self.showMessage = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showMessage = false
            }
        }
    }
}
