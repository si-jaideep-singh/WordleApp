//
//  WordleState.swift
//  WordleApp
//
//  Created by Jaideep Singh on 24/06/24.
//

import Foundation
import SwiftUI

struct WordleState : Equatable {
    var board: [[String]] = []
    var rowCompleted: [Bool] = []
    var rowColors: [[Color]] = []
    var keyColors: [Color] = []
    var cellFlipped: [[Bool]] = []
    var borderColors: [[Color]] = []
    var gameEnded: Bool = false
    var gameWon:Bool = false
    var gameCompleted: Bool = false
    var showToast: Bool = false
    var toastMessage: String = ""
    
    let letters = "QWERTYUIOPASDFGHJKLZXCVBNM"
    
    let targetWord = "APPLE".uppercased()
    let maxAttempts = 5
    var wordlength: Int = 0
    var currentRow = 0
    var currentGuess = ""
    var correctPosition = 0
    var isGuessCorrect: Bool = false
    var attemptsLeft: Int {
        return maxAttempts - currentRow
    }
}
