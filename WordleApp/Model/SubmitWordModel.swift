//
//  SubmitWordModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/07/24.
//


import Foundation

// MARK: - SubmitWordResponse
struct SubmitWordResponse: Codable {
    let data: CFSDKBaseResponseData
    let meta: CFSDKSDKBaseResponseMeta
}

// MARK: - SubmitWordData
struct SubmitWordData: Codable {
    let value: SubmitWordValue
    let feedTime: FeedTime
}

// MARK: - SubmitWordValue
struct SubmitWordValue:Codable {
    let attemptNo, gdID, userPoint, userAttemptNo: Int?
    let userSubmitflag: [Int]?
    let wordLength, isHintuse: Int?
    let userWord, mastWord: String?
    let gtFlag: Int?

    enum CodingKeys: String, CodingKey {
        case attemptNo
        case gdID = "gdId"
        case userPoint
        case userAttemptNo = "UserAttemptNo"
        case userSubmitflag, wordLength, isHintuse, userWord, mastWord, gtFlag
    }
}
// MARK: - FeedTime
struct FeedTime: Codable {
    let utcTime, istTime, cestTime: String

    enum CodingKeys: String, CodingKey {
        case utcTime = "UTCTime"
        case istTime = "ISTTime"
        case cestTime = "CESTTime"
    }
}

// MARK: - SubmitWordMeta
struct SubmitWordMeta: Codable {
    let message: String
    let retVal: Int
    let success: Bool
    let timestamp: FeedTime

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case retVal = "RetVal"
        case success = "Success"
        case timestamp = "Timestamp"
    }
}

// MARK: - SubmitWordPayload
struct SubmitWordPayload: Codable {
    let userdId :Int
    let tourId : Int
    let tourGamedayId: Int
    let langCode: String?
    let platformId: Int
    let attemptNo: Int
    let userWord: String?
    let userHint: Int
    
}



