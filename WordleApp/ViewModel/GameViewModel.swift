//
//  GameViewModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var board: [[String]] = Array(repeating: Array(repeating: "", count: 6), count: 6)
    @Published var enteredText: String = ""
    
    func addLetter(_ letter: String) {
        enteredText.append(letter)
        updateBoard(with: letter)
    }
    
    func deleteLastLetter() {
        guard !enteredText.isEmpty else { return }
        enteredText.removeLast()
        
       
        for row in (0..<board.count).reversed() {
            for col in (0..<board[row].count).reversed() {
                if !board[row][col].isEmpty {
                    board[row][col] = ""
                    return
                }
            }
        }
    }
    
    private func updateBoard(with letter: String) {
        for row in 0..<board.count {
            for col in 0..<board[row].count {
                if board[row][col].isEmpty {
                    board[row][col] = letter
                    return
                }
            }
        }
    }
}

