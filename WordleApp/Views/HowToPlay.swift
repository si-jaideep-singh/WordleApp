//
//  HelpView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 24/06/24.
//
//import SwiftUI
//
//struct HowToplay: View {
//    @Binding var isPresented: Bool
//    
//    var body: some View {
//        ZStack {
//            VStack {
//                Text("How to Play")
//                    .foregroundColor(Color.white)
//                    .font(Font.headline.weight(.bold))
//                    .font(.title3)
//                    
//                Image("howtoplay")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    //.padding(20)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .frame(width: UIScreen.main.bounds.width * 0.9)
//                    .background(Color.white)
//                    .cornerRadius(20)
//                   // .shadow(radius: 10)
//                
//               
//            }
//        
//        }
//        .onTapGesture {
//            isPresented = false
//        }
//        .transition(.opacity)
//        .animation(.easeInOut)
//    }
//}

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
                
                VStack(spacing:0) {
                    Text("How to Play")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.bold)
                       
                    
                    Image("howtoplay")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: min(geometry.size.width * 0.9, 600))
                        .background(Color.white)
                        .cornerRadius(20)
                        .padding()
                }
                .frame(width: min(geometry.size.width * 0.9, 600))
                .background(Color.clear)
                .cornerRadius(20)
                .shadow(radius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(.easeInOut)
            }
            .transition(.opacity)
            .animation(.easeInOut)
        }
    }
}
