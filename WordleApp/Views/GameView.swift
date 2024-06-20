

//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI
struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State var isLandscape : Bool = false
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Text("Word Guess Game")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 10)
                    
                    Spacer()
                    BoardView(viewModel: viewModel)
                    KeyboardView(viewModel: viewModel)
                    
                    
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
                .padding(10)
                
                
            }
            
            
        }
       
    }
}
            
//        }
//    }

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}

