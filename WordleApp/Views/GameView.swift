//
//
////  GameView.swift
////  WordleApp
////
////  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var isLandscape: Bool = false
    @State private var orientation = UIDeviceOrientation.unknown
    
  
    
    var body: some View {
        let dynamicWidth: CGFloat = {
                  
            if UIDevice.current.userInterfaceIdiom == .pad {
                return orientation.isLandscape ? UIScreen.main.bounds.width
                   :UIScreen.main.bounds.width - 40
} else {
                return UIScreen.main.bounds.width - 20
            }
        }()
        ZStack {
            VStack(spacing: 10) {
                Text("Word Guess Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom,50)
               BoardView(viewModel: viewModel)
                // .background(Color.green)
                 .padding(.horizontal,20)
            
                
              KeyboardView(viewModel: viewModel)
               // .background(Color.green)
                .frame( width: dynamicWidth,height:200)
 
                
                
                
            }
            .padding(.zero)
            
            
            
            if viewModel.showMessage {
                VStack {
                    Spacer()
                    Text(viewModel.message)
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
    }
    
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel())
    }
}



