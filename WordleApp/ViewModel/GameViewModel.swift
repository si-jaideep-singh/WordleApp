//
//  GameViewModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
    @Published var rowCompleted: [Bool] = Array(repeating: false, count: 6)
    @Published var rowColors: [[Color]] = Array(repeating: Array(repeating: .gray, count: 5), count: 6)
    @Published var keyColors: [Color] = Array(repeating: .gray, count: 26)
    public let letters = "QWERTYUIOPASDFGHJKLZXCVBNM"
    let targetWord = "APPLE"
    var currentRow = 0
    var currentGuess = ""
    
    func addLetter(_ letter: String) {
        guard currentGuess.count < board[currentRow].count else { return }
        currentGuess.append(letter)
        updateBoard(letter)
        // updateKeyColor(letter)
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
                return
            }
        }
    }
    
    private func updateBoard(_ letter: String) {
        for col in 0..<board[currentRow].count {
            if board[currentRow][col].isEmpty {
                board[currentRow][col] = letter
                return
            }
        }
    }
    
    private func checkGuess() {
        guard currentGuess.count == board[currentRow].count else { return }
        let guessResult = evaluateGuess(guess: currentGuess)
        rowColors[currentRow] = guessResult.colors
        
        //        if guessResult.correctPosition == board[currentRow].count {
        //            rowCompleted[currentRow] = true
        //        }
        rowCompleted[currentRow] = true
     
        
        currentRow += 1
        currentGuess = ""
    }
    
    private func evaluateGuess(guess: String) -> (correctPosition: Int, colors: [Color]) {
        var correctPosition = 0
        var colors: [Color] = Array(repeating: .gray, count: board[currentRow].count)
        let guessArray = Array(guess)
        let targetArray = Array(targetWord)
        
        for i in 0..<board[currentRow].count {
            if guessArray[i] == targetArray[i] {
                correctPosition += 1
                colors[i] = .green
            } else if targetArray.contains(guessArray[i]) {
                colors[i] = .yellow
            } else {
                colors[i] = .gray
            }
        }
        
        return (correctPosition, colors)
    }
    
}
