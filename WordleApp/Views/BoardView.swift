//
//  BoardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
import SwiftUI
struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var orientation = UIDeviceOrientation.unknown
    var dynamicWidth : CGFloat
    var body: some View {
      
//        ScrollView(.vertical) {
            VStack {
                ForEach(0..<viewModel.maxAttempts, id: \.self) { row in
                    HStack(spacing: 2) {
                        ForEach(0..<viewModel.wordlength, id: \.self) { col in
                           
                            
                            LetterView(letter: viewModel.board[row][col], flip: viewModel.cellFlipped[row][col], color: viewModel.rowColors[row][col], borderColor: viewModel.borderColors[row][col],
                                dynamicWidth: dynamicWidth,
                                viewModel: viewModel)
                            
                            .padding(2)
                        }
                    }
                }
        

        }
    }
}

struct LetterView: View {
    var letter: String
    var flip: Bool
    var color: Color
    var borderColor: Color
    var dynamicWidth : CGFloat
    @State private var orientation = UIDeviceOrientation.unknown
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
 
        return Text(letter)
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
            .onRotate { orientation in
                self.orientation = orientation
            }
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {        BoardView(viewModel: GameViewModel(), dynamicWidth: 220)
    }
}
