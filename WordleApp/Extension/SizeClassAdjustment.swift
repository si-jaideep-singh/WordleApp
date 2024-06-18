//
//  SizeClassAdjustment.swift
//  WordleApp
//
//  Created by Jaideep Singh on 18/06/24.
//

import SwiftUI

protocol SizeClassAdjustable {
    var verticalSizeClass: UserInterfaceSizeClass? { get }
    var horizontalSizeClass: UserInterfaceSizeClass? { get }
}

extension SizeClassAdjustable {
    var isPad: Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .regular
    }
    
    var isPadLandscape: Bool {
        return isPad && UIDevice.current.orientation.isLandscape
    }
    
    var isPadPortrait: Bool {
        return isPad && UIDevice.current.orientation.isPortrait
    }
    
    var isPadOrLandscapeMax: Bool {
        return horizontalSizeClass == .regular
    }
    
    var isLandscapeMax: Bool {
        return horizontalSizeClass == .regular && verticalSizeClass == .compact
    }
    
    var isLandscape: Bool {
        return verticalSizeClass == .compact
    }
    
    var isPortrait: Bool {
        return verticalSizeClass == .regular
    }
}
