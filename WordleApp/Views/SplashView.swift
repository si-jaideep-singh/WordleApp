//
//  SplashView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 18/06/24.
//

import SwiftUI

struct SplashView: View {

    var body: some View {
        
        ZStack {
            Color.backgroundColor.ignoresSafeArea()
            Image("Splash")
                .resizable()
                .frame(width: 150,height: 150)
        }
    }
}
