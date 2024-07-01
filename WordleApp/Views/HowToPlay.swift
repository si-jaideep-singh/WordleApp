//
//  HelpView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 24/06/24.
import SwiftUI

struct HowToplay: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isPresented = false
                    }
                
                VStack(spacing: 0) {
                    Text("How to Play")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                       
                    Image("howtoplay")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(geometry.size.width * 0.8, 600))
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                }
              
                .cornerRadius(20)
                .shadow(radius: 10)
               
               // .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .transition(.opacity)
            .animation(.easeInOut)
        }
    }
}
