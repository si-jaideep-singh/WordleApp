//
//
//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel = WordleGameViewModel()
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
                    .padding(.bottom, 30)
                
                BoardView(viewModel: viewModel)
                    .padding(.horizontal, 20)
                    Spacer()
                VStack{
                    Divider()
                        .frame(height: 1)
                        .background(Color.white.opacity(0.1))
                        .padding(.bottom,20)
                    KeyboardView(viewModel: viewModel)
                        .frame(width: dynamicWidth)
                       
                    
                }
               
                
               
            }
            .padding(.horizontal,10)
            
          
            
            if viewModel.state.showMessage {
                VStack {
                    Spacer()
                    Text(viewModel.state.message)
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
        }
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
        GameView(viewModel: WordleGameViewModel())
    }
}







//import SwiftUI
//
//struct GameView: View {
//    @ObservedObject var viewModel: GameViewModel
//    @State private var dynamicWidth: CGFloat = UIScreen.main.bounds.width - 20
//    @State private var orientation = UIDeviceOrientation.unknown
//    @State private var isHelpViewPresented = false
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                VStack(spacing: 20) {
//                    Text("Word Guess Game")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.bottom, 30)
//                    
//                    BoardView(viewModel: viewModel)
//                                   .padding(.horizontal, 20)
//                               KeyboardView(viewModel: viewModel)
//                                  .frame(width: dynamicWidth, height: 200)
//                    
//                    Button(action: {
//                        isHelpViewPresented.toggle()
//                    }) {
//                      
//                    }
//                    .padding(.top, 20)
//                    
//                    Spacer()
//                }
//                .padding(.horizontal, 10)
//                
//                if viewModel.showMessage {
//                    VStack {
//                        Spacer()
//                        Text(viewModel.message)
//                            .font(.headline)
//                            .foregroundColor(.white)
//                            .padding()
//                            .background(Color.black)
//                            .cornerRadius(10)
//                    }
//                    .transition(.opacity)
//                    .animation(.easeInOut)
//                }
//            }
//            .onAppear {
//                updateDynamicWidth()
//            }
//           
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button(action: {
//                        isHelpViewPresented.toggle()
//                    }) {
//                        Image(systemName: "questionmark.circle.fill")
//                    }
//                }
//            }
//            .sheet(isPresented: $isHelpViewPresented) {
//                HelpView()
//            }
//        }
//    }
//    
//    private func updateDynamicWidth() {
//        if UIDevice.current.userInterfaceIdiom == .pad {
//            dynamicWidth = UIScreen.main.bounds.width - (orientation.isLandscape ? 0 : 40)
//        } else {
//            dynamicWidth = UIScreen.main.bounds.width - 20
//        }
//    }
//}
//
//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView(viewModel: GameViewModel())
//    }
//}
