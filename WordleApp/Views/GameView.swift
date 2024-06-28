//
//
//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct GameView: View {
    @StateObject var viewModelWordle = WordleGameViewModel()
    @State private var orientation = UIDeviceOrientation.unknown
    @State private var showHowToPlay = true
    var body: some View {
        
        ZStack {
            Color.background
                .ignoresSafeArea()
            VStack{
                AdsPresentedbyView()
                VStack{
                    Text("Word Guess Game")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        .foregroundColor(.whiteFFFF)
                    VStack {
                        TeamSelectionView()
                        BoardView()
                            .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 20 : isiPhoneSE() ? 50 : 40)
                        
                   }
                   
                        ZStack {
                            VStack{
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.whiteFFFF.opacity(0.1))
                                    .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
                                VStack {
                                    KeyboardView()
                                    Spacer(minLength: 20)
                                    SponsorView()
                                }
                                
                            }
                            Spacer()
                        }
                       // .frame(alignment: .bottom)
                   
                 }
                .padding(.horizontal,20)
             }
            .onAppear {
                self.viewModelWordle.initCall()
                    
            }
            .onRotate{_ in
                orientation
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
        
        
        .environmentObject(viewModelWordle)
        .onTapGesture {
            showHowToPlay = false
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModelWordle: WordleGameViewModel())
            .environmentObject(WordleGameViewModel())
    }
}


