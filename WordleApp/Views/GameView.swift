//
//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewmodel:GameViewModel
  
    var body: some View {
        ScrollView(.vertical){
            ViewThatFits{
                VStack(spacing:30){
                    BoardView(viewModel:viewmodel)
                        .padding(10)
                    KeyboardView(viewModel: viewmodel)
                    
                }
                .padding(.all,10)
                Spacer()
            }
        }
    }
}

#Preview {
    GameView(viewmodel: GameViewModel())
}
