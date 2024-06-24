////
////  KeyboardView.swift
////  WordleApp
////
////  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct KeyboardView: View {
    let rows: [[String]] = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Delete", "Z", "X", "C", "V", "B", "N", "M", "Enter"]
    ]
    @ObservedObject var viewModel: GameViewModel
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                ForEach(rows.indices, id: \.self) { rowIndex in
                    HStack(spacing: 2) {
                        ForEach(rows[rowIndex], id: \.self) { key in
                            KeyView(key: key, viewModel: self.viewModel, keyWidth: calculateKeyWidth(geometry: geometry, totalKeys: rows[rowIndex].count))
                        }
                    }
                }
            }
           
            }
        }
      
    }
    
    private func calculateKeyWidth(geometry: GeometryProxy, totalKeys: Int) -> CGFloat {
        let totalSpacing: CGFloat = CGFloat(totalKeys - 1) * 2
        let availableWidth = geometry.size.width - totalSpacing
        return (availableWidth) / CGFloat(totalKeys)
    }


struct KeyView: View {
    let key: String
    @ObservedObject var viewModel: GameViewModel
    let keyWidth: CGFloat
    
    var body: some View {
        Button(action: {
            if key == "Delete" {
                viewModel.handleSpecialKey(key)
            } else if key == "Enter" {
                viewModel.handleSpecialKey(key)
            } else {
                viewModel.addLetter(key)
            }
        }) {
            Text(key)
                .frame(width: keyWidth, height:50)
                .background(keyBackgroundColor(for: key))
                .foregroundColor(.white)
                .cornerRadius(5)
        }
    }
    
    private func keyBackgroundColor(for key: String) -> Color {
        if key == "Delete" || key == "Enter" {
            return .EmpyCellColor
        } else {
            guard let letter = key.first, let index = viewModel.letters.firstIndex(of: letter) else {
                return .gray
            }
            let colorIndex = viewModel.letters.distance(from: viewModel.letters.startIndex, to: index)
            return viewModel.keyColors[colorIndex]
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(viewModel: GameViewModel())
    }
}

