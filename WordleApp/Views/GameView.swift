

//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @State private var isLandscape: Bool = false
    @State private var orientation = UIDeviceOrientation.unknown
    
    var body: some View {
        let dynamicWidth: CGFloat = {
            let totalSpacing: CGFloat = CGFloat(viewModel.wordlength - 1) * 2

            if UIDevice.current.userInterfaceIdiom == .pad {
                return orientation.isLandscape ?
                    (UIScreen.main.bounds.height - totalSpacing) / CGFloat(viewModel.wordlength ) :
                (UIScreen.main.bounds.width - totalSpacing) / CGFloat(viewModel.wordlength)
            } else {
                return (UIScreen.main.bounds.width - totalSpacing) / CGFloat(viewModel.wordlength )
            }
        }()
        ZStack {
           VStack(spacing: 20) {
                Text("Word Guess Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
               
               BoardView(viewModel: viewModel, dynamicWidth: dynamicWidth )
                  
                KeyboardView(viewModel: viewModel)
                    .frame(height:200)
            }
            .padding(20)
            .edgesIgnoringSafeArea(.bottom)
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
