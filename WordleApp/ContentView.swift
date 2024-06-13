//
//  ContentView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/06/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            
            GameView()
        }
        .background(Color.backgroundColor)
        
    }
}

#Preview {
    ContentView()
}
