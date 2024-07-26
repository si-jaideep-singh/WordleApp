//
//  GetSubmittedWordModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/07/24.


import Foundation

// MARK: - GetSubmitted
struct GetSubmittedWordResponse: Codable {
    let data: GetSubmittedWordData?
    let meta: CFSDKSDKBaseResponseMeta?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
}


// MARK: - DataClass
struct GetSubmittedWordData: Codable {
    let value: GetSubmittedWordValue?
    let feedTime: Feedtime?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case feedTime = "FeedTime"
    }
}
// MARK: - Value
struct GetSubmittedWordValue: Codable {
    var attemptNo: Int?
    let gdId: Int?
    let userPoint: Int?
    let isHintuse: Int?
    let userSubmitflag: [Int]?
    let wordLength: Int?
    let mastWord: String?
    let userWord: String?
//
//    enum CodingKeys: String, CodingKey {
//        case attemptNo = "attemptno"
//        case gdId = "gdid"
//        case userPoint = "userpoint"
//        case isHintuse = "ishintuse"
//        case userSubmitflag = "usersubmitflag"
//        case wordLength = "wordLength"
//        case mastWord = "mastword"
//        case userWord = "userword"
//    }
}


struct Feedtime: Codable {
    let cestTime: String
    let istTime: String
    let utcTime: String

    enum CodingKeys: String, CodingKey {
        case cestTime = "CESTTime"
        case istTime = "ISTTime"
        case utcTime = "UTCTime"
    }
}
