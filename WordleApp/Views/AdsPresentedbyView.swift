//
//  AdsView.swift
//  Wordle
//
//  Created by Vishal Vijayvargiya on 25/06/24.
//

import SwiftUI

struct AdsPresentedbyView: View {

    var body: some View {
        ZStack{
            Color.addBg.ignoresSafeArea()
            HStack{
                Text("Presented by")
                    .font(.subheadline)
                    .foregroundColor(.whiteFFFF).padding(.leading,-90)
                PlaceHolder
            }
        }.frame(maxHeight: 50)
      
    }
    var PlaceHolder:some View{
        Image("ps5banner")
            .resizable()
        .frame(width: 70, height: 40)
        .padding(.vertical,5)
        .scaledToFit()
    }
}



