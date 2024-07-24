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
    var gameWon:Bool = false
    var gameCompleted: Bool = false
    var showToast: Bool = false
    var toastMessage: String = ""
    var hint: String = ""
    let letters = "QWERTYUIOPASDFGHJKLZXCVBNM"
    
    
    let maxAttempts = 6
    var wordlength: Int?
    var currentAttempt : Int = 0
    var currentGuess = ""
    var correctPosition = 0
    var isGuessCorrect: Bool = false
    var submittedWordValue: [GetSubmittedWordValue]? = nil
    var submitWordValue: SubmitWordResponseValue?
   
    var userSubmitflag: [Int] = []
//    var attemptsLeft: Int {
//        return maxAttempts - (submittedWordValue?.attemptNo ?? 0)
//    }
//    
     
     var showHint: Bool = false
}
