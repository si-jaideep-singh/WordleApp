//
//  FlipView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.
//

import Foundation
import SwiftUI

struct FlipView<FrontContent: View, BackContent: View>: View {
    @State private var flipped: Bool = false
    
    let frontContent: FrontContent
    let backContent: BackContent
    
    var body: some View {
        ZStack {
            if flipped {
                backContent
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0.0, y: 1.0, z: 0.0)
                    )
            } else {
                frontContent
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                flipped.toggle()
            }
        }
    }
}
