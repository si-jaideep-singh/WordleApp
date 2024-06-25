//
//  CompletionView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 25/06/24.
//

import SwiftUI

struct CompletionView: View {
    @EnvironmentObject var viewModelWordle: WordleGameViewModel
    @State private var navigateToHome = false
    
    var body: some View {
        VStack {
            Text(viewModelWordle.state.gameWon ? "Congratulations! You've guessed the word!" : "Game Over! The correct word was \(viewModelWordle.state.targetWord).")
                .font(.title)
                .padding()
            
            HStack {
                Button(action: {
                    navigateToHome = true
                }) {
                    Text("Back")
                        .font(.title3)
                        .frame(width: 120)
                        .padding(.all, 10)
                        .background(Color.background)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                
                Button(action: {
                    viewModelWordle.resetGame()
                }) {
                    Text("Play Again")
                        .font(.title3)
                        .frame(width: 120)
                        .padding(.all, 10)
                        .background(Color.background)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            .frame(height: 50)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.4).edgesIgnoringSafeArea(.all))
        .background(
            NavigationLink(destination: HomeViewList(), isActive: $navigateToHome) {
                EmptyView()
            }
        )
    }
}

struct CompletionView_Previews: PreviewProvider {
    static var previews: some View {
        CompletionView()
            .environmentObject(WordleGameViewModel())
    }
}
