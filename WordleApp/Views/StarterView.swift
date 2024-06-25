//
//  StarterView.swift
//  WordleApp
//
//  Created by Vishal on 25/06/24.
//

import SwiftUI

struct StarterView: View {
    @State private var moveToGameView = false
    init() {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .navigationbar
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().tintColor = .white // This sets the tint color for the navigation items
        }
    var body: some View {
        
        NavigationView{
            ZStack{
                if moveToGameView{
                    HomeViewList()
                }else{
                    SplashView()
                }
            }.onAppear {
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                    moveToGameView = true
                }
            }
        }
    }
    
}

#Preview {
    StarterView()
}
