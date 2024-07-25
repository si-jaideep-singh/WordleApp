//
//  HomeViewList.swift
//  WordleApp
//
//  Created by Vishal on 25/06/24.
//
//
//import SwiftUI
//
//struct HomeViewList: View {
//    @State var card1:Bool =  false
//    @State var card2:Bool =  false
//    var body: some View {
//        ZStack{
//            Color.background.ignoresSafeArea()
//            ScrollView{
//                AdsPresentedbyView()
//                VStack(spacing:10){
//                    ForEach(0..<2, id: \.self) { index in
//                        Button {
//                            if index ==  0 {
//                                card1 = true
//                            } else if index ==  0 {
//                                card2 = true
//                            }
//                        } label: {
//                            cardview
//                        }
//                    }
//                }
//            }
//            NavigationLink("", destination: GameView(), isActive: $card1)
//            NavigationLink("", destination: GameView(), isActive: $card2)
//        }.navigationBarHidden(false)
//            .navigationBarItems(leading: NavigationLink(destination: LoginView()) {
//                            Text("Back")
//                        })
//            .navigationBarTitle("Wordle", displayMode: .large)
//        .frame(alignment: .top)
//    }
//    
//    
//    var cardview:some View{
//        VStack{
//            Image("card1 image")
//                .resizable()
//                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 180)
//                .cornerRadius(10)
//                .padding(.horizontal,15)
//                
//            
//        }
//    }
//}
//
//#Preview {
//    HomeViewList()
//}

import SwiftUI

struct HomeViewList: View {
    @State private var card1: Bool = false
    @State private var card2: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background.ignoresSafeArea()
                
                ScrollView {
                    AdsPresentedbyView()
                    
                    VStack(spacing: 10) {
                        ForEach(0..<2, id: \.self) { index in
                            Button {
                                if index == 0 {
                                    card1 = true
                                } else if index == 1 {
                                    card2 = true
                                }
                            } label: {
                                cardview
                            }
                        }
                    }
                }
                
                NavigationLink("", destination: GameView(), isActive: $card1)
                NavigationLink("", destination: GameView(), isActive: $card2)
            }
            .navigationBarTitle("Wordle", displayMode: .large)
            .navigationBarItems(leading: NavigationLink(destination: LoginView()) {
                Text("Back")
            })
        }
    }
    
    var cardview: some View {
        VStack {
            Image("card1 image")
                .resizable()
                .frame(height: UIDevice.current.userInterfaceIdiom == .pad ? 300 : 180)
                .cornerRadius(10)
                .padding(.horizontal, 15)
        }
    }
}

#Preview {
    HomeViewList()
}
