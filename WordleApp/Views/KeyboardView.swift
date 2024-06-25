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
        ["Z", "X", "C", "V", "B", "N", "M","Delete"]
    ]
    @EnvironmentObject var viewModelWordle: WordleGameViewModel
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                ForEach(rows.indices, id: \.self) { rowIndex in
                    HStack(spacing: 2) {
                        ForEach(rows[rowIndex], id: \.self) { key in
                            KeyView(key: key, keyWidth: calculateKeyWidth(geometry: geometry, totalKeys: rows[rowIndex].count, key: key, row: rowIndex))
                        }
                    }
                }
                
                HStack {
                    HStack(spacing:10){
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Booster")
                                .padding(.vertical,14.5)
                                .padding(.horizontal,12)
                                .lineLimit(1)
                                .background(Color.yellow)
                                .CFSDKcornerRadius(10, corners: .allCorners)
                            
                        })
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Booster")
                                .padding(.vertical,14.5)
                                .padding(.horizontal,12)
                                .lineLimit(1)
                                .background(Color.yellow)
                                .CFSDKcornerRadius(10, corners: .allCorners)
                            
                        })
                    }
                    HStack {
                        Button(action: {
                            viewModelWordle.handleSpecialKey("Enter")
                        }, label: {
                            Text("Submit")
                                .padding(.vertical, 14.5)
                                .foregroundColor(.backgroundColor)
                        }).frame(width: geometry.size.width/2)
                    }
                        .background(Color.primarybtn)
                        .CFSDKcornerRadius(10, corners: .allCorners)
                }
                
            }
            .padding(.zero)
            
        }
    }
    
}
    
private func calculateKeyWidth(geometry: GeometryProxy, totalKeys: Int,key:String,row:Int) -> CGFloat {
    let totalSpacing: CGFloat = CGFloat(totalKeys - 1) * 5.5
    let availableWidth = geometry.size.width - totalSpacing
    return key == "Delete" ? ((availableWidth) / CGFloat(totalKeys - 2) + 8) : (availableWidth) / CGFloat( row == 1 ?  (totalKeys + 1)  :  row == 2 ? (totalKeys + 2) :  totalKeys)
    }


struct KeyView: View {
    let key: String
    @EnvironmentObject var viewModelWordle: WordleGameViewModel
    let keyWidth: CGFloat
    
    var body: some View {
        Button(action: {
            if key == "Delete" {
                viewModelWordle.handleSpecialKey(key)
            } else {
                viewModelWordle.addLetter(key)
            }
        }) {
            
            Text(key == "Delete" ? "X" : key)
            
                .frame(width: keyWidth, height: 43)
                
                .background(keyBackgroundColor(for: key))
                .foregroundColor(.white)
                .font(Font.headline.weight(.bold))
                .cornerRadius(12)
                .CFSDKborder(radius: 12, color:  keyBackgroundColor(for: key) != .clear ? .clear : .whiteFFFF.opacity(0.5), width: 1)
                
        }
        .padding(.all,1.5)
    }
    
    private func keyBackgroundColor(for key: String) -> Color {
        if key == "Delete"  {
            return .red
        } else {
            guard let letter = key.first, let index = viewModelWordle.state.letters.firstIndex(of: letter) else {
                return .gray
            }
            let colorIndex = viewModelWordle.state.letters.distance(from: viewModelWordle.state.letters.startIndex, to: index)
            return viewModelWordle.state.keyColors.count != 0 ?  viewModelWordle.state.keyColors[colorIndex] : .clear
        }
    }
}

struct KeyboardView_Previews: PreviewProvider {
    static var previews: some View {
        KeyboardView()
    }
}

