//
//  SubmitWordModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/07/24.
//


//import Foundation
//
//// MARK: - SubmitWordResponse
//struct SubmitWordResponse: Codable {
//    let data: SubmitWordData
//    let meta: CFSDKSDKBaseResponseMeta
//}
//
//// MARK: - SubmitWordData
//struct SubmitWordData: Codable {
//    let value: SubmitWordValue
//    let feedTime: FeedTime
//}
//
//// MARK: - SubmitWordValue
//struct SubmitWordValue:Codable {
//    let attemptNo, gdID, userPoint, userAttemptNo: Int?
//    let userSubmitflag: [Int]?
//    let wordLength, isHintuse: Int?
//    let userWord, mastWord: String?
//    let gtFlag: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case attemptNo
//        case gdID = "gdId"
//        case userPoint
//        case userAttemptNo = "UserAttemptNo"
//        case userSubmitflag, wordLength, isHintuse, userWord, mastWord, gtFlag
//    }
//}
//// MARK: - FeedTime
//struct FeedTime: Codable {
//    let utcTime, istTime, cestTime: String
//
//    enum CodingKeys: String, CodingKey {
//        case utcTime = "UTCTime"
//        case istTime = "ISTTime"
//        case cestTime = "CESTTime"
//    }
//}
//
//
//// MARK: - SubmitWordPayload
//struct SubmitWordPayload: Codable {
//    let userdId :Int
//    let tourId : Int
//    let tourGamedayId: Int
//    let langCode: String?
//    let platformId: Int
//    let attemptNo: Int
//    let userWord: String?
//    let userHint: Int
//
//}
//
//
//
import Foundation
struct SubmitWordResponseData: Codable {
    let value: SubmitWordResponseValue
    let feedTime: FeedTime
}

struct SubmitWordResponseValue: Codable {
    let attemptNo: Int?
    let gdId: Int
    let userPoint: Int
    let userAttemptNo: Int
    let userSubmitflag: [Int]?
    let wordLength: Int
    let isHintuse: Int
    let userWord: String
    let mastWord: String? // Assuming mastWord can be null/optional
    let gtFlag: Int
}

struct FeedTime: Codable {
    let utcTime: String
    let istTime: String
    let cestTime: String
}

struct SubmitWordResponseMeta: Codable {
    let message: String
    let retVal: Int
    let success: Bool
    let timestamp: FeedTime
}

struct SubmitWordResponse: Codable {
    let data: SubmitWordResponseData
    let meta: SubmitWordResponseMeta
}
struct SubmitWordPayload: Codable {
    let userId: Int
    let tourId: Int
    let tourGamedayId: Int
    let langCode: String?
    let platformId: Int
    let attemptNo: Int
    let userWord: String? 
    let userHint: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "userdId"
        case tourId
        case tourGamedayId
        case langCode
        case platformId
        case attemptNo
        case userWord
        case userHint
    }
}

