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
            VStack {
                AdsPresentedbyView()
                GeometryReader { geometry in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            Text("Word Guess Game")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                                .foregroundColor(.whiteFFFF)
                            
                            TeamSelectionView()
                            BoardView(geometry: geometry)
                                .padding(.horizontal, UIDevice.current.userInterfaceIdiom == .pad ? 100 : 20)
                                .padding(.vertical, UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20)
//                                .padding(.horizontal, 10)
//                                .padding(.vertical, 10)
//                            
                            VStack {
                                Divider()
                                    .frame(height: 1)
                                    .background(Color.whiteFFFF.opacity(0.1))
                                    .padding(.bottom, UIDevice.current.userInterfaceIdiom == .pad ? 10 : 0)
                                
                                KeyboardView()
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                }
                .onAppear {
                    self.viewModelWordle.initCall()
                }
                .blur(radius: showHowToPlay ? 5 : 0)
                
                if viewModelWordle.state.gameEnded {
                    CompletionView()
                        .environmentObject(viewModelWordle)
                }
            }
            .frame(alignment: .top)
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
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModelWordle: WordleGameViewModel())
            .environmentObject(WordleGameViewModel())
    }
}
