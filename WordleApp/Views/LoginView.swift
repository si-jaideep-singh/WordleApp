//
//  loginView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 25/07/24.
//

import SwiftUI

struct LoginView: View {
    @State private var combinedToken: String = ""
    @EnvironmentObject var viewModel: WordleGameViewModel
    @State private var navigateToStarterView = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter URC and USC tokens", text: $combinedToken)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    if !combinedToken.isEmpty {
                        viewModel.tokens = combinedToken
                        navigateToStarterView = true
                    }
                }) {
                    Text("Login")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(combinedToken.isEmpty)
                
                NavigationLink(destination: StarterView(), isActive: $navigateToStarterView) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
            .navigationBarTitle("Login")
           
        }
    }
}
