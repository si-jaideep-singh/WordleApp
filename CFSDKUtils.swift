//
//  CFSDKUtils.swift
//  WordleApp
//
//  Created by Jaideep Singh on 11/07/24.
//

import Foundation

// MARK: - UTILS FOR OVERALL FANTASY - COMMON
final class CFSDKUtils: ObservableObject {
    static let shared = CFSDKUtils()
    
   // @Published var configData: CFSDKConfig?
  //  @Published var translationData: [String: String]?
   // @Published var mixedApiData: CFSDKMixedAPI?
    
   // var currentSelectedGameType: GameSelector?
    var currentSelectedGameLanguage: String = "en"
    var previousMixedAPIVersioningValue: String?
}
