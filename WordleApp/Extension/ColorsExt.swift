//
//  ColorsExt.swift
//  WordleApp
//
//  Created by Jaideep Singh on 13/06/24.
//

import Foundation
import SwiftUI

extension Color{
    static var Correct: Color{
        Color(UIColor(named : "Correct")!)
    }
    static var Wrong: Color{
        Color(UIColor(named : "Wrong")!)
    }
    static var Misplaced : Color{
        Color(UIColor(named : "Misplaced")!)
    }
    static var backgroundColor: Color{
        Color(UIColor(named : "backgroundColor")!)
    }
    static var BorderColor: Color{
        Color(UIColor(named : "BorderColor")!)
    }
    static var EmptyCellColor: Color{
        Color(UIColor(named : "EmptyCellColor")!)
    }
}
