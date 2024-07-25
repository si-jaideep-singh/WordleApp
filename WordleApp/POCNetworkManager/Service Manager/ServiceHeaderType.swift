//
//  ServiceHeaderType.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

// MARK: - SERVICE HEADER TYPES
enum ServiceHeaderType: String {
    case NONE
    case DEFAULT
    case Hint
    case submitWord
    case submittedWord
    case login
    
    func getServiceHeader(url: String) -> [String: String] {
        switch self {
        case .NONE:
            return [:]
        case .DEFAULT:
            if url.contains("/services") { return [:] }
            return ["Accept":"application/json, text/plain, */*",
                    "content-type":"application/json"]
        case .Hint:
            return getHintHeaders()
        case .submitWord:
            return SubmitWordHeaders()
        case .submittedWord:
            return SubmittedWordHeaders()
            
        case .login:
            return Login()
            
        }
        
    }
    
    private func getHintHeaders() -> [String:String] {
        return [
            "Accept":"application/json",
            "content-type": "application/json",
            "entity": "$@nt0rYu"
        ]
    }
    private func SubmitWordHeaders() -> [String:String] {
        return [
            "Accept":"application/json",
            "content-type": "application/json",
            "entity": "$@nt0rYu"
           
        ]
    }
    private func SubmittedWordHeaders() -> [String:String] {
        return [
            "Accept":"application/json, text/plain, */*",
            "content-type": "application/json",
            "entity": "$@nt0rYu"
            
        ]
    }
    private func Login() -> [String:String] {
        let viewModel = WordleGameViewModel()
        return [
            "Accept":"application/json, text/plain, */*",
            "content-type": "application/json",
            "entity": "$@nt0rYu",
            "Cookie": viewModel.tokens,
           "Referer" : "https://stg-gujarat-titans.sportz.io/wordle/gameplay"
        ]
    }
    
}
