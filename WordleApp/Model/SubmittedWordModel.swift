//
//  SubmittedWordModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/07/24.
//
import Foundation
struct GetSubmittedWordResponse: Codable {
    let data: GetSubmittedWordData
    let meta: CFSDKSDKBaseResponseMeta
    
    enum CodingKeys: String, CodingKey {
           case data = "Data"
           case meta = "Meta"
       }
}

struct GetSubmittedWordData: Codable {
    let value: GetSubmittedWordValue?
    let feedTime: FeedTime?
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case feedTime = "FeedTime"
    }
}
struct GetSubmittedWordValue: Codable {
    let attemptNo: Int?
    let gdId: Int
    let userPoint: Int?
    let isHintuse: Bool?
    let userSubmitflag: Bool?
    let wordLength: Int?
    let mastWord: String?
    let userWord: String?
    
    enum CodingKeys: String, CodingKey {
        case attemptNo
        case gdId
        case userPoint
        case isHintuse
        case userSubmitflag
        case wordLength
        case mastWord
        case userWord
    }
}

