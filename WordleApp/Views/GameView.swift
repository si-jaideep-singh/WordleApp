//
//
//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct GameView: View {
    @StateObject var viewModelWordle = WordleGameViewModel()
    @State private var dynamicWidth: CGFloat = 0
    @State private var StaticHeight: CGFloat = 0
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var showHowToPlay = true
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack{
                AdsPresentedbyView()
                    .padding(.bottom,10)
                VStack {
                       BoardView()
                        .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20)
                       
                    ZStack{
                         VStack{
                             Divider()
                                .frame(height: 1)
                                .background(Color.whiteFFFF.opacity(0.1))
                                .padding(.bottom,10)
                                 KeyboardView()
//                                 .frame(maxWidth: .infinity)
                                 .frame(height: UIDevice.current.userInterfaceIdiom == .phone || orientation.isPortrait ? 250 : 250 )
//
                              }
                       }
                 }
                .padding(.horizontal,20)
               
            }
            .blur(radius: showHowToPlay ? 5 : 0)
            if viewModelWordle.state.showToast {
                VStack {
                    Spacer()
                    Text(viewModelWordle.state.toastMessage)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .transition(.opacity)
                .animation(.easeInOut)
            }
            
            if viewModelWordle.state.gameEnded {
                CompletionView()
                    .environmentObject(viewModelWordle)
            }
            if showHowToPlay {
                HowToplay(isPresented: $showHowToPlay)
                    .transition(.opacity)
                    .animation(.easeInOut)
            }
            
        }
        
        .navigationTitle("Wordle")
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
           // updateDynamicWidth()
            self.viewModelWordle.initCall()
        }
        .environmentObject(viewModelWordle)
        .onTapGesture {
            showHowToPlay = false
        }
    }
     private func updateDynamicWidth() {
         if UIDevice.current.userInterfaceIdiom == .pad {
            dynamicWidth = UIScreen.main.bounds.width - (orientation.isLandscape ? 0 : 40)
        } else {
            dynamicWidth = UIScreen.main.bounds.width - 20
        }
    }
    
    private func staticHeight() {
        if UIDevice.current.userInterfaceIdiom == .phone{
           StaticHeight = 200
       }
   }

    
    private func Onrotation(){
        orientation = UIDevice.current.orientation
    }
    
}
struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModelWordle: WordleGameViewModel())
            .environmentObject(WordleGameViewModel())
    }
}


