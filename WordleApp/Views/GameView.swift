

//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI
struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationView{
            ZStack {
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    ScrollView{
                        VStack {
                            GeometryReader { geometry in
                                VStack(spacing: 30) {
                                    BoardView(viewModel: viewModel)
                                    
                                    // .frame(width: geometry.size.width * 0.6)
                                    //                            .frame(height: geometry.size.height * 0.6)
                                    //  .padding(10)
                                    
                                    KeyboardView(viewModel: viewModel)
                                    // .frame(width: geometry.size.width * 0.4)
                                    //                           .frame(height: geometry.size.height * 0.4)
                                    //   .padding(10)
                                }
                            }
                            .padding(10)
                        }
                    }
                } else {
                    VStack {
                        GeometryReader { geometry in
                            VStack(spacing: 30) {
                                BoardView(viewModel: viewModel)
                                //                            .frame(height: geometry.size.height * 0.6)
                                //  .padding(10)
                                
                                KeyboardView(viewModel: viewModel)
                                //                           .frame(height: geometry.size.height * 0.4)
                                //   .padding(10)
                            }
                        }
                        .padding(10)
                    }
                }
                
                if viewModel.showMessage {
                    VStack {
                        Spacer()
                        Text(viewModel.message)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.bottom, 50)
                    }
                    .transition(.opacity)
                }
            }
           
            
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}

