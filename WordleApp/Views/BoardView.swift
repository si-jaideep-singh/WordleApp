//
//  BoardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.


//import SwiftUI
//
//struct BoardView: View {
//    @ObservedObject var viewModel: GameViewModel
//
//    var body: some View {
//        VStack {
//            ForEach(0..<viewModel.board.count, id: \.self) { row in
//                HStack(spacing: 2) {
//                    ForEach(0..<viewModel.board[row].count, id: \.self) { col in
//                        LetterView(
//                            letter: viewModel.board[row][col],
//                            flip: viewModel.cellFlipped[row][col],
//                            color: viewModel.rowColors[row][col],
//                            borderColor: viewModel.borderColors[row][col]
//                        )
//                        .padding(2)
//                    }
//                }
//            }
//            .padding(.zero)
//        }
//    }
//}
//
//
//struct LetterView: View {
//    var letter: String
//    var flip: Bool
//    var color: Color
//    var borderColor: Color
//    @State var isLandscape : Bool = false
//    @State private var orientation = UIDeviceOrientation.unknown
//
//
//    var dynamicWidth: CGFloat {
//        (UIScreen.main.bounds.width - 42) / 6
//    }
//
//    var body: some View {
//        Text(letter)
//            .font(.system(size: 20))
//            .frame(width: dynamicWidth, height: dynamicWidth)
//            .foregroundColor(.white)
//            .background(color)
//            .cornerRadius(dynamicWidth / 2)
//            .overlay(
//                Circle()
//                    .stroke(borderColor, lineWidth: 3)
//            )
//            .rotation3DEffect(
//                flip ? .degrees(360) : .degrees(0),
//                axis: (x: 1, y: 0, z: 0)
//            )
//        
//    }
//}
//
//#Preview {
//    BoardView(viewModel: GameViewModel())
//}

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
    @State private var orientation = UIDeviceOrientation.unknown
   
    var body: some View {
       let dynamicWidth: CGFloat = {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return orientation.isLandscape ? (UIScreen.main.bounds.height - 42) / 10 : (UIScreen.main.bounds.width - 42) / 6
            } else {
                return (UIScreen.main.bounds.width - 42) / 6
            }
        }()
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
        
            .onRotate { Orientation in
                self.orientation = Orientation
                
            }
    }
}
    
struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(viewModel: GameViewModel())
    }
}
