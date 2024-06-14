//
//  BorderExtension.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.
//

import Foundation
import SwiftUI
extension View {
    func CFSDKcornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(CFSDKRoundedCorner(radius: radius, corners: corners) )
    }
    
    func CFSDKborder(radius: CGFloat,
                color: Color,
                width: CGFloat) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: radius)
                .stroke(color,
                        lineWidth: width)
        )
    }
}
