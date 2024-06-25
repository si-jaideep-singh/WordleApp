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
                        VStack{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "bolt.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(.white)
                                        .frame(width: 10, height: 10)
                                    Text("Booster")
                                        .foregroundColor(Color.white)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .lineLimit(1)
                                .CFSDKborder(radius: 12, color: Color.white.opacity(0.6), width: 2)
                            })
                        }
                        VStack {
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "bolt.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .foregroundColor(.white)
                                        .frame(width: 10, height: 10)
                                        
                                    Text("Booster")
                                        .foregroundColor(Color.white)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 10)
                                .lineLimit(1)
                                .CFSDKborder(radius: 12, color: Color.white.opacity(0.6), width: 2)
                            })
                        }
                    }
                    HStack {
                        Button(action: {
                            viewModelWordle.handleSpecialKey("Enter")
                        }, label: {
                            Text("Submit")
                                .foregroundColor(Color.black)
                                .font(Font.headline.weight(.medium))
                                .padding(.vertical, 14.5)
//                                .background(Color.primarybtn)
                                //.background(viewModelWordle.isCurrentWordComplete ? Color.primarybtn : Color.primarybtn.opacity(0.3))
                        })
                        .frame(width: geometry.size.width/2)
                            .disabled(!viewModelWordle.isCurrentWordComplete)

                    }
//                        .background(Color.primarybtn)
                    .background(viewModelWordle.isCurrentWordComplete ? Color.primarybtn : Color.primarybtn.opacity(0.5))
                        .CFSDKcornerRadius(13, corners: .allCorners)
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
                if viewModelWordle.state.isGuessCorrect {
                    
                              } else {
                               viewModelWordle.handleSpecialKey(key)
                           }
                       } else {
                           viewModelWordle.addLetter(key)
                       }        }) {
               if key == "Delete" {
                           Image(systemName: "delete.left.fill")
                               .frame(width: keyWidth, height: 55)
                               .background(keyBackgroundColor(for: key))
                               .foregroundColor(.white.opacity(0.6))
                               .font(.system(size: 30))
                               .font(Font.headline.weight(.bold))
                               .cornerRadius(12)
                               .CFSDKborder(radius: 12, color: keyBackgroundColor(for: key) != .clear ? .clear : .whiteFFFF.opacity(0.8), width: 0.3)
                       } else {
                           Text(key)
                               .frame(width: keyWidth, height: 55)
                               .background(keyBackgroundColor(for: key))
                               .foregroundColor(.white)
                               .font(.system(size: 30))
                               .font(Font.headline.weight(.bold))
                               .cornerRadius(12)
                               .CFSDKborder(radius: 12, color: keyBackgroundColor(for: key) != .clear ? .clear : .whiteFFFF.opacity(0.8), width: 0.3)
                       }
                   }
                   .padding(.all, 1.5)
    }
    
    private func keyBackgroundColor(for key: String) -> Color {
        if key == "Delete"  {
            return .clear
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

