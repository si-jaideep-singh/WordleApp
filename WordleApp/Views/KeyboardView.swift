//
//  KeyboardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//

import SwiftUI

struct KeyboardView: View {
    let rows: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    let specialKeys: [String] = ["Delete", "Enter"]

    @Binding var enteredText: String
    @Binding var board: [[String]]
   // @ObservedObject var viewModel : GameViewModel

    var body: some View {
        VStack(spacing: 10) {
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 2) {
                    if row == "ZXCVBNM" {
                        OtherKeys(specialLetter: specialKeys[0], enteredText: $enteredText, board: $board)
                    }
                    ForEach(Array(row), id: \.self) { letter in
                        SingleKey(letter: String(letter), enteredText: $enteredText, board: $board, viewModel: GameViewModel())
                    }
                    if row == "ZXCVBNM" {
                        OtherKeys(specialLetter: specialKeys[1], enteredText: $enteredText, board: $board)
                    }
                       
                }
                
            }
        }
        .padding(.zero)

    }
}

struct SingleKey: View {
    let letter: String
    @Binding var enteredText: String
    @Binding var board: [[String]]
    @ObservedObject var viewModel : GameViewModel

    var body: some View {
        Button(action: {
         //   viewModel.addLetter(self.letter)
           
            self.enteredText.append(self.letter)
             self.updateBoard(letter: self.letter)
        }) {
            Text(letter)
                .font(.system(size: 20))
                .frame(width: 30, height: 50)
                .background(Color.BorderColor)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
        .frame(maxWidth:.infinity)
    }

    private func updateBoard(letter: String) {
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

struct OtherKeys: View {
    let specialLetter: String
    @Binding var enteredText: String
    @Binding var board: [[String]]

    var body: some View {
        Button(action: {
            self.handleSpecialKey()
        }) {
            Text(specialLetter)
                .font(.system(size: 20))
                .frame(width: specialLetter == "Delete" ? 100 : 80, height: 50)
                .background(Color.BorderColor)
                .foregroundColor(.white)
                .cornerRadius(5)
        }
    }

    private func handleSpecialKey() {
        switch specialLetter {
        case "Delete":
          enteredText.removeLast()
           for row in (0..<board.count).reversed() {
                for col in (0..<board[row].count).reversed() {
                    if !board[row][col].isEmpty {
                        board[row][col] = ""
                        return
                    }
                }
            }
        case "Enter":
          
            print("Entered text: \(enteredText)")
        default:
            break
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    @State static var previewEnteredText: String = ""
    @State static var previewBoard: [[String]] = Array(repeating: Array(repeating: "", count: 6), count: 6)

    static var previews: some View {
        KeyboardView(enteredText: $previewEnteredText, board: $previewBoard)
    }
}
