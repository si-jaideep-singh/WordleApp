////
////  BoardView.swift
////  WordleApp
import SwiftUI

struct BoardView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(spacing: 5) {
                    ForEach(0..<viewModel.maxAttempts, id: \.self) { row in
                        HStack(spacing: 4) {
                            ForEach(0..<viewModel.wordlength, id: \.self) { col in
                                let cellSize = calculateCellSize(geometry: geometry.size, cols: viewModel.wordlength, maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                                LetterView(
                                    letter: viewModel.board[row][col],
                                    flip: viewModel.cellFlipped[row][col],
                                    color: viewModel.rowColors[row][col],
                                    borderColor: viewModel.borderColors[row][col],
                                    cellSize: cellSize,
                                    viewModel: viewModel
                                )
                                .frame(width: cellSize, height: cellSize) // Ensure each LetterView has fixed size
                                .padding(2)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    private func calculateCellSize(geometry: CGSize, cols: Int, maxWidth: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let isCompactMode = geometry.width < geometry.height
        
        // Define your cell size logic based on the device and mode
        if UIDevice.current.userInterfaceIdiom == .phone {
            if isCompactMode {
                // Portrait mode on iPhone
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 10 // Adjust spacing for iPhone SE portrait mode
                let availableWidth = maxWidth - totalHorizontalPadding
                let cellWidth = availableWidth / CGFloat(cols)
                return min(cellWidth, maxHeight / CGFloat(viewModel.maxAttempts)) // Ensure cell fits within available height
            } else {
                // Landscape mode on iPhone
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 6 // Adjust spacing for iPhone SE landscape mode
                let availableWidth = maxWidth - totalHorizontalPadding
                let cellWidth = availableWidth / CGFloat(cols)
                return min(cellWidth, maxHeight / CGFloat(viewModel.maxAttempts)) // Ensure cell fits within available height
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            if isCompactMode {
                // Portrait mode on iPad
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 8 // Adjust spacing for portrait mode on iPad
                let totalVerticalPadding: CGFloat = CGFloat(viewModel.maxAttempts - 1) * 8 // Adjust vertical spacing for iPad
                let availableWidth = maxWidth - totalHorizontalPadding
                let availableHeight = maxHeight - totalVerticalPadding
                let cellSize = min(availableWidth / CGFloat(cols), availableHeight / CGFloat(viewModel.maxAttempts))
                return cellSize
            } else {
                // Landscape mode on iPad
                let totalHorizontalPadding: CGFloat = CGFloat(cols - 1) * 10 // Adjust spacing for landscape mode on iPad
                let totalVerticalPadding: CGFloat = CGFloat(viewModel.maxAttempts - 1) * 10 // Adjust vertical spacing for iPad
                let availableWidth = maxWidth - totalHorizontalPadding
                let availableHeight = maxHeight - totalVerticalPadding
                let cellSize = min(availableWidth / CGFloat(cols), availableHeight / CGFloat(viewModel.maxAttempts))
                return cellSize
            }
        }
        
        // Default case
        return 50 // Default cell size
    }
}

struct LetterView: View {
    var letter: String
    var flip: Bool
    var color: Color
    var borderColor: Color
    var cellSize: CGFloat
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        Text(letter)
            .font(.system(size: cellSize * 0.5)) // Adjust font size as per cell size
            .frame(width: cellSize, height: cellSize)
            .foregroundColor(.white)
            .background(color)
            .cornerRadius(cellSize / 2)
            .overlay(
                Circle()
                    .stroke(borderColor, lineWidth: 2)
            )
            .rotation3DEffect(
                flip ? .degrees(360) : .degrees(0),
                axis: (x: 1, y: 0, z: 0)
            )
    }
}

struct BoardView_Previews: PreviewProvider {
    static var previews: some View {
        BoardView(viewModel: GameViewModel())
    }
}
