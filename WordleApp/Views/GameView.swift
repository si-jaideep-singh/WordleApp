//
//
//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct GameView: View {
    @StateObject var viewModelWordle = WordleGameViewModel()
    @State private var dynamicWidth: CGFloat = UIScreen.main.bounds.width - 20
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack {
                Text("Word Guess Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                    .foregroundColor(.whiteFFFF)
                
                BoardView()
                    .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 20 : 40)
                ZStack{
                    VStack{
                        Divider()
                            .frame(height: 1)
                            .background(Color.whiteFFFF.opacity(0.1))
                            .padding(.bottom,20)
                        
                        KeyboardView()
                            .frame(width: dynamicWidth)
                        
                        
                    }
                }.frame(alignment: .bottom)
                
            }
            .padding(.horizontal,10)
            
            if viewModelWordle.state.showMessage {
                VStack {
                    Spacer()
                    Text(viewModelWordle.state.message)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .transition(.opacity)
                .animation(.easeInOut)
            }
        }
        .onAppear {
            updateDynamicWidth()
            self.viewModelWordle.initCall()
        }
        .environmentObject(viewModelWordle)
    }
        
    private func updateDynamicWidth() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            dynamicWidth = UIScreen.main.bounds.width - (orientation.isLandscape ? 0 : 40)
        } else {
            dynamicWidth = UIScreen.main.bounds.width - 20
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModelWordle: WordleGameViewModel())
    }
}


