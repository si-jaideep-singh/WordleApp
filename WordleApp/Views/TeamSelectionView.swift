//
//  TeamSelectionView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 27/06/24.
//

import SwiftUI

struct TeamSelectionView: View {
    var body: some View {
        HStack(spacing: 10) {
            TeamButton(imageName: "star.fill")
            TeamButton(imageName: "heart.fill")
         }
       
    }
}
struct TeamButton: View {
    let imageName: String
    
    var body: some View {
        Button(action: {
           
        }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20, height: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20)
                .foregroundColor(.white)
                .padding(15)
                .background(Color.blue)
                .clipShape(Circle())
//                .overlay(
//                    Circle()
//                        .stroke(Color.white, lineWidth: 2)
//                )
        }
    }
}

struct TeamSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TeamSelectionView()
    }
}
