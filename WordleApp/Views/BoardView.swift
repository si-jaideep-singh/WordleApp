//
//  BoardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.


import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        VStack {
            ForEach(0..<viewModel.board.count, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<viewModel.board[row].count, id: \.self) { col in
                        LetterView(
                            letter: viewModel.board[row][col],
                            flip: viewModel.cellFlipped[row][col],
                            color: viewModel.rowColors[row][col],
                            borderColor: viewModel.borderColors[row][col]
                        )
                        .padding(2)
                    }
                }
            }
            .padding(.zero)
        }
    }
}


struct LetterView: View {
    var letter: String
    var flip: Bool
    var color: Color
    var borderColor: Color

    var dynamicWidth: CGFloat {
        (UIScreen.main.bounds.width - 42) / 6
    }

    var body: some View {
        Text(letter)
            .font(.system(size: 20))
            .frame(width: dynamicWidth, height: dynamicWidth)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(dynamicWidth / 2)
            .overlay(
                Circle()
                    .stroke(borderColor, lineWidth: 3)
            )
            .rotation3DEffect(
                flip ? .degrees(360) : .degrees(0),
                axis: (x: 1, y: 0, z: 0)
            )
          
    }
}

#Preview {
    BoardView(viewModel: GameViewModel())
}
