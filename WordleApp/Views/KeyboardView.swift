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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
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
                     HStack(spacing: 10) {
                         VStack(spacing: 0) {
                             Button(action: {}, label: {
                                 VStack {
                                     Image(systemName: "bolt.fill")
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .foregroundColor(.white)
                                         .frame(width: isiPhoneSE() ? 4 : 6, height: isiPhoneSE() ? 4 : 6)
                                         .padding(.top, 3)
                                     Text("Booster")
                                         .foregroundColor(Color.white)
                                         .font(.system(size: 16))
                                 }
                                 .padding(.vertical, isiPhoneSE() ? 1 : 4)
                                 .padding(.horizontal, isiPhoneSE() ? 1 : 4)
                                 .lineLimit(1)
                                 .CFSDKborder(radius: 8, color: Color.white.opacity(0.6), width: 1.5)
                             })
                         }
                         
                         VStack {
                             Button(action: {}, label: {
                                 VStack {
                                     Image(systemName: "bolt.fill")
                                         .resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .foregroundColor(.white)
                                         .frame(width: isiPhoneSE() ? 4 : 6, height: isiPhoneSE() ? 4 : 6)
                                         .padding(.top, 3)
                                     Text("Booster")
                                         .foregroundColor(Color.white)
                                         .font(.system(size: 16))
                                 }
                                 .padding(.vertical, isiPhoneSE() ? 1 : 4)
                                 .padding(.horizontal, isiPhoneSE() ? 1 : 4)
                                 .lineLimit(1)
                                 .CFSDKborder(radius: 8, color: Color.white.opacity(0.6), width: 1.5)
                             })
                         }
                     }

                    HStack {
                        Button(action: {
                            viewModelWordle.handleSpecialKey("Enter")
                        }, label: {
                            Text("Submit")
                                .frame(width:  geometry.size.width/2)
                                .foregroundColor(Color.black)
                                .font(Font.headline.weight(.medium))
                                .padding(.vertical,isiPhoneSE() ? 8 : 16)
                             
                        })
                        
                        .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? geometry.size.width/4 : geometry.size.width/2)
                        
                        .disabled(!viewModelWordle.isCurrentWordComplete)

                    }
                        .background(viewModelWordle.isCurrentWordComplete ? Color.primarybtn : Color.primarybtn.opacity(0.5))
                        .CFSDKcornerRadius(13, corners: .allCorners)
                }
                
                
            }
//            .padding(.bottom,20)
            .frame(maxWidth: geometry.size.width ,alignment: .center)
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
       @State private var orientation = UIDeviceOrientation.unknown
     
    var body: some View {
       
        let adjustedWidth: CGFloat
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                if UIDevice.current.orientation.isPortrait {
                    adjustedWidth = keyWidth - 10
                } else {
                    adjustedWidth = keyWidth - 60
                }
            } else {
                adjustedWidth = keyWidth - (isiPhoneSE() ? 2 : 0)
            }
           return
        Button(action: {
            if key == "Delete" {
                if viewModelWordle.state.isGuessCorrect {
                
                } else {
                    viewModelWordle.handleSpecialKey(key)
                }
            } else {
                viewModelWordle.addLetter(key)
            }        })
         {
            if key == "Delete" {
                Image(systemName: "delete.left.fill")
                    .frame(width:  keyWidth - (isiPhoneSE() ?  2 : (UIDevice().userInterfaceIdiom == .pad ? (orientation.isLandscape ? 50 : 20) : 0)),height: isiPhoneSE() ? 42 :  50)
                  // .frame(width: adjustedWidth,
                        // height:  (isiPhoneSE() ? 42 : 50))
//                    .frame(width:  keyWidth - (isiPhoneSE() ?  2 : (UIDevice().userInterfaceIdiom == .pad) ? 40 : 0),height: isiPhoneSE() ? 42 :  50)
                    .background(keyBackgroundColor(for: key))
                    .foregroundColor(.white.opacity(0.6))
                    .font(.system(size: 14))
                    .font(Font.headline.weight(.bold))
                    .cornerRadius(12)
                    .CFSDKborder(radius: 12, color: keyBackgroundColor(for: key) != .clear ? .clear : .whiteFFFF.opacity(0.8), width: 1)
            } else {
                Text(key)
                   // .frame(width: adjustedWidth,
                      //  height: (isiPhoneSE() ? 42 : 50))
                    .frame(
                      width: keyWidth - (isiPhoneSE() ? 2 : (UIDevice().userInterfaceIdiom == .pad ? (orientation.isLandscape ? 50 : 20) : 0)),
                      height: isiPhoneSE() ? 42 : 50
                    )

          //  .frame(width:  keyWidth - (isiPhoneSE() ?  2 : 0),height: isiPhoneSE() ? 42 :  50)
                    .background(keyBackgroundColor(for: key))
                    .foregroundColor(.white)
                    .font(.system(size: 14))
                    .font(Font.headline.weight(.bold))
                    .cornerRadius(12)
                    .CFSDKborder(radius: 12, color: keyBackgroundColor(for: key) != .clear ? .clear : .whiteFFFF.opacity(0.8), width: 1)
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
            .environmentObject(WordleGameViewModel())
    }
}

