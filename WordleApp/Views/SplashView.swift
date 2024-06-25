//
//  SplashView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 18/06/24.
//

import SwiftUI

struct SplashView: View {
    @State private var moveToGameView = false
    
    var body: some View {
        ZStack {
            VStack{
                Text("Splash")
                    .foregroundColor(.white)
                Image("howtoplay")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .ignoresSafeArea(.all)
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
                    moveToGameView = true
                }
            }
            .fullScreenCover(isPresented: $moveToGameView) {
                GameView(viewModelWordle: WordleGameViewModel())
            }
        }
        
    }
}

#Preview {
    SplashView()
}

