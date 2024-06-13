//
//  UIScreen.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//
//
import Foundation
import UIKit
import SwiftUI
extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}


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


struct CFSDKRoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        return Path(path.cgPath)
    }
}
