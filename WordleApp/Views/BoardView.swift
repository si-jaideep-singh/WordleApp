//
//  BoardView.swift
//  WordleApp
import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: WordleGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 5) {
                    ForEach(0..<viewModel.state.maxAttempts, id: \.self) { row in
                        HStack(spacing: 4) {
                            ForEach(0..<viewModel.state.wordlength, id: \.self) { col in
                                let cellSize = calculateCellSize(geometry: geometry.size, cols: viewModel.state.wordlength, maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                                
                               
                                LetterView(
                                    letter: viewModel.state.board[row][col],
                                    flip: viewModel.state.cellFlipped[row][col],
                                    color: viewModel.state.rowColors[row][col],
                                    borderColor: viewModel.state.borderColors[row][col],
                                    cellSize: cellSize,
                                    viewModel: viewModel
                                )
                                .frame(width: cellSize, height: cellSize)
                                .padding(2)
                                
                            }
                        }
                    }
                }
                
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .background(Color.clear)
//            .padding(.top,30)
        }
    }
    
    private func calculateCellSize(geometry: CGSize, cols: Int, maxWidth: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let isCompactMode = geometry.width < geometry.height
        
       if UIDevice.current.userInterfaceIdiom == .phone {
            if isCompactMode {
               let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 10
                let availableWidth = maxWidth - totalHorizontalPadding
                let cellWidth = availableWidth / CGFloat(cols)
                return min(cellWidth, maxHeight/CGFloat(viewModel.state.maxAttempts))
            } else {
              let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 6
                let availableWidth = maxWidth - totalHorizontalPadding
                let cellWidth = availableWidth / CGFloat(cols)
                return min(cellWidth, maxHeight / CGFloat(viewModel.state.maxAttempts))
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if isCompactMode {
               
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 8 
                let totalVerticalPadding: CGFloat = CGFloat(viewModel.state.maxAttempts - 1) * 8
                let availableWidth = maxWidth - totalHorizontalPadding
                let availableHeight = maxHeight - totalVerticalPadding
                let cellSize = min(availableWidth / CGFloat(cols), availableHeight / CGFloat(viewModel.state.maxAttempts))
                return cellSize
            } else {
              
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 10
                let totalVerticalPadding: CGFloat = CGFloat(viewModel.state.maxAttempts - 1) * 10
                let availableWidth = maxWidth - totalHorizontalPadding
                let availableHeight = maxHeight - totalVerticalPadding
                let cellSize = min(availableWidth / CGFloat(cols), availableHeight / CGFloat(viewModel.state.maxAttempts))
                return cellSize
            }
        }
        return 50
    }
}

struct LetterView: View {
    var letter: String
    var flip: Bool
    var color: Color
    var borderColor: Color
    var cellSize: CGFloat
    @ObservedObject var viewModel: WordleGameViewModel
    
    var body: some View {
           Text(letter)
               .font(.system(size: cellSize * 0.5))
               .frame(width: cellSize, height: cellSize)
               .foregroundColor(.white)
               .background(RoundedRectangle(cornerRadius: cellSize * 0.25)
                               .fill(color))
               .overlay(
                   RoundedRectangle(cornerRadius: cellSize * 0.25)
                       .stroke(borderColor, lineWidth: 2)
               )
               .rotation3DEffect(
                   flip ? .degrees(360) : .degrees(0),
                   axis: (x: 1, y: 0, z: 0)
               )
       }
//            .overlay(
//                Circle()
//                    .stroke(borderColor, lineWidth: 2)
//
    
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(viewModel: WordleGameViewModel())
    }
}
