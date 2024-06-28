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


func iPadMiniLandscape() -> Bool {
    let iPadMiniGenerations = [
        (UIScreen.screenWidth == 1024.0 && UIScreen.screenHeight == 768.0) ||
        (UIScreen.screenWidth == 768.0 && UIScreen.screenHeight == 1024.0),
        
        (UIScreen.screenWidth == 1112.0 && UIScreen.screenHeight == 834.0) ||
        (UIScreen.screenWidth == 834.0 && UIScreen.screenHeight == 1112.0),
        
        (UIScreen.screenWidth == 1133.0 && UIScreen.screenHeight == 744.0) ||
        (UIScreen.screenWidth == 744.0 && UIScreen.screenHeight == 1133.0)
    ]
    
    return iPadMiniGenerations.contains(true)
}

func isiPhoneSE() -> Bool {
    let isiPhoneSE1 = UIScreen.screenWidth == 320.0 && UIScreen.screenHeight == 568.0
    let isiPhoneSE2 = UIScreen.screenWidth == 375.0 && UIScreen.screenHeight == 667.0
    return isiPhoneSE1 || isiPhoneSE2 }

struct CFSDKRoundedCorner:Shape {

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
