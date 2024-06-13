//
//  GameView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//

import SwiftUI

struct GameView: View {
    @State private var enteredText: String = ""
       @State private var board: [[String]] = Array(repeating: Array(repeating: "", count: 6), count: 6)
    var body: some View {
       
            VStack{
                BoardView(board: $board)
                    .padding(10)
                
                KeyboardView(enteredText: $enteredText, board: $board )
                
                
            }
            .padding(20)
            
            
            
        
        
    }
}

#Preview {
    GameView()
}
