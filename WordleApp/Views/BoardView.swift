//
//  BoardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.


import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var flipped = false

    var body: some View {
        VStack {
            ForEach(0..<viewModel.board.count, id: \.self) { row in
                HStack(spacing: 2) {
                    ForEach(0..<viewModel.board[row].count, id: \.self) { col in
                        LetterView(letter: viewModel.board[row][col], flip: viewModel.rowCompleted[row])
                            .padding(2)
                    }
                }
            }
        }
        .padding()
    }
}

struct LetterView: View {
    var letter: String
    var flip: Bool
    var dynamicWidth: CGFloat = (UIScreen.main.bounds.width - 42) / 6

    var body: some View {
        Text(letter)
            .font(.system(size: 20))
            .frame(width: dynamicWidth, height: dynamicWidth)
            .background(flip ? Color.green : Color.BorderColor)
            .cornerRadius(dynamicWidth / 2)
            .foregroundColor(.white)
            .rotation3DEffect(
                flip ? .degrees(360) : .degrees(0),
                axis: (x: 0, y: 1, z: 0)
            )
            .animation(.easeInOut(duration: 1),value: flip)
         }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(viewModel: GameViewModel())
    }
}
