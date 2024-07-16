//
//  ToastView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 16/07/24.
//

import SwiftUI

struct ToastView: View {
    var message: String
    
    var body: some View {
        Text(message)
            .foregroundColor(.red)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(10)
            .padding(.horizontal, 20)
    }
}
