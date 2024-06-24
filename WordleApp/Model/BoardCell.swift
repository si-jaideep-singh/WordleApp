//
//  BoardCell.swift
//  WordleApp
//
//  Created by Jaideep Singh on 14/06/24.
//

//import Foundation
//import SwiftUI
//
//enum GuessState{
//    case inital,correct,incorrect
//}
//struct GameModel {
//    
//    
//}
//    
//    
import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Geo
        
        struct Geo: Codable {
            let lat: String
            let lng: String
        }
    }
    
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}
