//
//  GameViewModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.

import SwiftUI
import Combine

class GameViewModel: ObservableObject {
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
    @Published var enteredText: String = ""
    @Published var rowCompleted: [Bool] = Array(repeating: false, count: 6)
    
    
      let targetWord = "APPLE"
      var currentRow = 0
      var currentGuess = ""

    func addLetter(_ letter: String) {
        guard !isCurrentRowCompleted() else { return }
        enteredText.append(letter)
        updateBoard(letter)
        checkRowCompletion()
    }
    
    func handleSpecialKey(_ specialLetter: String) {
        switch specialLetter {
        case "Delete":
            guard !isCurrentRowCompleted() else { return }
            deleteLastLetter()
            clearLastNonEmptyCell()
        case "Enter":
            checkRowCompletion()
        default:
            break
        }
    }
    
    private func deleteLastLetter() {
        if !enteredText.isEmpty {
            enteredText.removeLast()
        }
    }
    
    private func clearLastNonEmptyCell() {
        for row in (0..<board.count).reversed() {
            if rowCompleted[row] {
                continue
            }
            for col in (0..<board[row].count).reversed() {
                if !board[row][col].isEmpty {
                    board[row][col] = ""
                    return
                }
            }
        }
    }
    
    private func updateBoard(_ letter: String) {
        for row in 0..<board.count {
            if rowCompleted[row] {
                continue
            }
            for col in 0..<board[row].count {
                if board[row][col].isEmpty {
                    board[row][col] = letter
                    return
                }
            }
        }
    }

    private func checkRowCompletion() {
        for row in 0..<board.count {
            var rowCompleted = true
            for col in 0..<board[row].count {
                if board[row][col].isEmpty {
                    rowCompleted = false
                    break
                }
            }
            if rowCompleted {
                markRowCompleted(row: row)
            }
        }
    }
    
    
    private func markRowCompleted(row: Int) {
        rowCompleted[row] = true
    }

    private func isCurrentRowCompleted() -> Bool {
        for row in 0..<board.count {
            if !rowCompleted[row] {
                return false
            }
        }
        return true
    }
}
