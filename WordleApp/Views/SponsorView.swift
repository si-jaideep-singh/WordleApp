//
//  SponsorView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 27/06/24.
//

import SwiftUI

struct SponsorView: View {
    var body: some View {
        VStack {
            Text("Sponsor")
                .frame(width:  240,height:isiPhoneSE() ? 25 : 42)
            .background(Color.red)
        }
       
            
    }
}

#Preview {
    SponsorView()
}
