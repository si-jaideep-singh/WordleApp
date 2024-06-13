//
//  BoardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.


import SwiftUI

struct BoardView: View {
    @Binding var board: [[String]]
    
    var body: some View {
        
        VStack {
            ForEach(0..<board.count, id: \.self) { row in
                HStack(spacing : 2) {
                    ForEach(0..<board[row].count, id: \.self) { col in
                        LetterView(letter: self.board[row][col])
                            .padding(2)
                        }
                }
            }
        }
        
        
    }
    
    
}
struct LetterView: View {
    var letter: String
    var dynmaicwidth : CGFloat = (UIScreen.screenWidth - 42)/6
    var body: some View {
        Text(letter)
            .font(.system(size: 20))
            .frame(width: dynmaicwidth, height: dynmaicwidth)
            .background(Color.EmpyCellColor)
            .CFSDKcornerRadius(dynmaicwidth/2, corners: .allCorners)
            .foregroundColor(Color.white)
    }
}

struct BoardView_Previews: PreviewProvider {
    @State static var previewBoard: [[String]] = Array(repeating: Array(repeating: "", count: 6), count: 6)
    static var previews: some View {
        BoardView(board: $previewBoard)
    }
}
