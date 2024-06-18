//
//  KeyboardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.


import SwiftUI

struct KeyboardView: View {
    let rows: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    let specialKeys: [String] = ["Delete", "Enter"]
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                ForEach(rows, id: \.self) { row in
                    HStack(spacing: 2) {
                        if row == "ZXCVBNM" {
                            OtherKeys(specialLetter: specialKeys[0], viewModel: self.viewModel, keyWidth: self.calculateKeyWidth(geometry: geometry, totalKeys: row.count + 2))
                        }
                        ForEach(Array(row), id: \.self) { letter in
                            SingleKey(letter: String(letter), viewModel: self.viewModel, keyWidth: self.calculateKeyWidth(geometry: geometry, totalKeys: row.count + 2))
                                .background(self.keyBackgroundColor(for: letter))
                        }
                        if row == "ZXCVBNM" {
                            OtherKeys(specialLetter: specialKeys[1], viewModel: self.viewModel, keyWidth: self.calculateKeyWidth(geometry: geometry, totalKeys: row.count + 2))
                        
                    
                        }
                    }
                }
            }
            .padding(.zero)
        }
    }

    private func calculateKeyWidth(geometry: GeometryProxy, totalKeys: Int) -> CGFloat {
        let totalSpacing: CGFloat = CGFloat(totalKeys - 1) * 2
        let keyWidth: CGFloat = (geometry.size.width - totalSpacing) / CGFloat(totalKeys)
        return keyWidth
    }

    private func keyBackgroundColor(for letter: Character) -> Color {
        guard let index = viewModel.letters.firstIndex(of: letter) else {
            return .gray
        }
        let colorIndex = viewModel.letters.distance(from: viewModel.letters.startIndex, to: index)
        return viewModel.keyColors[colorIndex]
    }
}

struct SingleKey: View {
    let letter: String
    @ObservedObject var viewModel: GameViewModel
    let keyWidth: CGFloat

    var body: some View {
        Button(action: {
            viewModel.addLetter(letter)
        }) {
            Text(letter)
                .frame(width: keyWidth, height: 50)
                .background(viewModel.keyColors[viewModel.letters.distance(from: viewModel.letters.startIndex, to: viewModel.letters.firstIndex(of: Character(letter))!)])
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
        }
//        .buttonStyle(PlainButtonStyle())
//        .cornerRadius(10)
        
    }
}

struct OtherKeys: View {
    let specialLetter: String
    @ObservedObject var viewModel: GameViewModel
    let keyWidth: CGFloat

    var body: some View {
        Button(action: {
            viewModel.handleSpecialKey(specialLetter)
        }) {
            Text(specialLetter)
                .frame(width: keyWidth, height: 50)
                .background(Color.EmpyCellColor)
               // .cornerRadius(5)
                .foregroundColor(.white)
        }
        .buttonStyle(PlainButtonStyle())
       // .cornerRadius(5)
    }
}
#Preview{
    KeyboardView(viewModel: GameViewModel())
}
