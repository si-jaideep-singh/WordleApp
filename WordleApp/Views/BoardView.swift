//
//  BoardView.swift
//  WordleApp
import SwiftUI

struct BoardView: View {
    @EnvironmentObject var viewModelWordle: WordleGameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical,showsIndicators: false) {
                VStack(spacing: 5) {
                    ForEach(0..<viewModelWordle.state.maxAttempts, id: \.self) { row in
                        HStack(spacing: 4) {
                            ForEach(0..<viewModelWordle.state.wordlength, id: \.self) { col in
                                let cellSize = calculateCellSize(geometry: geometry.size, cols: viewModelWordle.state.wordlength, maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                                
                                LetterView(
                                    letter: viewModelWordle.state.board[row][col],
                                    flip: viewModelWordle.state.cellFlipped[row][col],
                                    color: viewModelWordle.state.rowColors[row][col],
                                    borderColor: viewModelWordle.state.borderColors[row][col],
                                    cellSize: cellSize,
                                    viewModel: viewModelWordle
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

        }
    }
    
    private func calculateCellSize(geometry: CGSize, cols: Int, maxWidth: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let isCompactMode = geometry.width < geometry.height
        
       if UIDevice.current.userInterfaceIdiom == .phone {
            if isCompactMode {
               let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 10
                let availableWidth = maxWidth - totalHorizontalPadding
                let cellWidth = availableWidth / CGFloat(cols)
                return min(cellWidth, maxHeight/CGFloat(viewModelWordle.state.maxAttempts))
            } else {
              let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 6
                let availableWidth = maxWidth - totalHorizontalPadding
                let cellWidth = availableWidth / CGFloat(cols)
                return min(cellWidth, maxHeight / CGFloat(viewModelWordle.state.maxAttempts))
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if isCompactMode {
               
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 8 
                let totalVerticalPadding: CGFloat = CGFloat(viewModelWordle.state.maxAttempts - 1) * 8
                let availableWidth = maxWidth - totalHorizontalPadding
                let availableHeight = maxHeight - totalVerticalPadding
                let cellSize = min(availableWidth / CGFloat(cols), availableHeight / CGFloat(viewModelWordle.state.maxAttempts))
                return cellSize
            } else {
              
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 10
                let totalVerticalPadding: CGFloat = CGFloat(viewModelWordle.state.maxAttempts - 1) * 10
                let availableWidth = maxWidth - totalHorizontalPadding
                let availableHeight = maxHeight - totalVerticalPadding
                let cellSize = min(availableWidth / CGFloat(cols), availableHeight / CGFloat(viewModelWordle.state.maxAttempts))
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
            .font(.system(size: cellSize * 0.6))
               .frame(width: cellSize, height: cellSize)
               .foregroundColor(.white)
               .background(RoundedRectangle(cornerRadius: cellSize * 0.25)
                .fill(color))
               .overlay(
                   RoundedRectangle(cornerRadius: cellSize * 0.25)
                       .stroke(borderColor, lineWidth: 2)
               )
        
               .rotation3DEffect(
                   flip ? Angle(degrees: 360) : .zero,
                   axis: (x: 0.0, y: 1.0, z: 0.0)
               )
              
       }

}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView()
            .environmentObject(WordleGameViewModel())
    }
}
