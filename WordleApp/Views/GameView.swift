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
    @State private var scrollToBottom = false
    
    var body: some View {
        ZStack {
             VStack {
                AdsPresentedbyView()
                GeometryReader { geometry in
                    ScrollViewReader{ proxy in
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack {
                                Text("Word Guess Game")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                    .foregroundColor(.whiteFFFF)
                                    

                                TeamSelectionView()
                                BoardView(geometry: geometry)
                                VStack {
                                    Divider()
                                        .frame(height: 1)
                                        .background(Color.whiteFFFF.opacity(0.1))
                                        .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
                                    
                                    KeyboardView()
                                        .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 60 : 10)
                                }
                            }
                            .padding(.top, UIDevice.current.userInterfaceIdiom == .pad ? 40 : isiPhoneSE() ? 20 : 50)
                            .padding(.bottom,300)
                            
                        }
                        .disableBounces()
                        .onAppear {
                        self.viewModelWordle.initCall()
                     

                    }
                        
                        
                    }
                    .blur(radius: showHowToPlay ? 5 : 0)
                    
                    if viewModelWordle.state.gameEnded {
                        CompletionView()
                            .environmentObject(viewModelWordle)
                    }
                }
               
            }
            //.frame(alignment: .top)
            .navigationTitle("Wordle")
            .navigationBarTitleDisplayMode(.inline)
            .environmentObject(viewModelWordle)
            .onTapGesture {
                showHowToPlay = false
            }
            if showHowToPlay {
                        HowToplay(isPresented: $showHowToPlay)
                            .transition(.opacity)
                            .animation(.easeInOut)
                    }
                
            }
        .background(Color.background)
        .edgesIgnoringSafeArea(.all)
        }
    }
 struct GameView_Previews: PreviewProvider {
        static var previews: some View {
            GameView(viewModelWordle: WordleGameViewModel())
                .environmentObject(WordleGameViewModel())
        }
    }
    
    
   
    
