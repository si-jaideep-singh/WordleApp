//
//  HelpView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 24/06/24.
//
import SwiftUI

struct HowToplay: View {
    @State private var moveToGameView = false
    
    var body: some View {
            
        VStack(alignment: .center) {
                
                 ZStack(alignment:.topTrailing) {
                    Image("howtoplay")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(10)
                        .CFSDKcornerRadius(10, corners: .allCorners)
                    

                    Button(action: {
                        moveToGameView = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .padding(20)
                    }
                    
                    //.frame(alignment: .topTrailing)

                    /*.opacity(moveToGameView ? 0 : 1)*/ // Hide when moveToGameView is true
                    
                }
               // .frame(height: UIScreen.main.bounds.height/2)
               
                .fullScreenCover(isPresented: $moveToGameView) {
                    GameView(viewModelWordle: WordleGameViewModel())
            }
            
            }
        
        
        
    }
}
#Preview {
    HowToplay()
}
