//
//  WordleState.swift
//  WordleApp
//
//  Created by Jaideep Singh on 24/06/24.
//

import Foundation
import SwiftUI

struct WordleState {
    var board: [[String]] = []
    var rowCompleted: [Bool] = []
    var rowColors: [[Color]] = []
    var keyColors: [Color] = []
    var cellFlipped: [[Bool]] = []
    var borderColors: [[Color]] = []
    var gameEnded: Bool = false
    
   
    var message: String = ""
    var showMessage: Bool = false
     
    let letters = "QWERTYUIOPASDFGHJKLZXCVBNM"
    
    let targetWord = "Apple".uppercased()
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
