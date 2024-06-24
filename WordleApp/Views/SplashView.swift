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
            Image("Splash")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(.all)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                moveToGameView = true
            }
        }
        .fullScreenCover(isPresented: $moveToGameView) {
            GameView(viewModel: WordleGameViewModel())
         }
        }
}

#Preview {
    SplashView()
}
