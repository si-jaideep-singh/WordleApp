//
//  ToastView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 16/07/24.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .font(.body)
            .padding()
            .background(Color.black.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
           // .transition(.slide)
            .animation(.easeInOut)
    }
}
#Preview{
    ToastView(message: "jaideep")
}
