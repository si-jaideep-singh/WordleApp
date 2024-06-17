//
//  KeyboardView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//
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
                        }
                        if row == "ZXCVBNM" {
                            OtherKeys(specialLetter: specialKeys[1], viewModel: self.viewModel, keyWidth: self.calculateKeyWidth(geometry: geometry, totalKeys: row.count + 2))
                        }
                    }
                }
            }
            .padding(.zero)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    private func calculateKeyWidth(geometry: GeometryProxy, totalKeys: Int) -> CGFloat {
        let totalSpacing: CGFloat = CGFloat(totalKeys - 1) * 2
        let keyWidth: CGFloat = (geometry.size.width - totalSpacing) / CGFloat(totalKeys)
        return keyWidth
    }
}

struct SingleKey: View {
    let letter: String
    @ObservedObject var viewModel: GameViewModel
    var keyWidth: CGFloat

    var body: some View {
        Button(action: {
            self.viewModel.addLetter(self.letter)
        }) {
            Text(letter)
                .font(.system(size: 12))
                .frame(width: keyWidth, height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }

}
struct OtherKeys: View {
    let specialLetter: String
    @ObservedObject var viewModel: GameViewModel
    var keyWidth: CGFloat
    
    var body: some View {
        Button(action: {
            self.viewModel.handleSpecialKey(self.specialLetter)
        }) {
            Text(specialLetter)
                .font(.system(size: 12))
                .frame(width: keyWidth, height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView(viewModel: GameViewModel())
    }
}
