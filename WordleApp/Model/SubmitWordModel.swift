//
//  SubmitWordModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/07/24.
//



import Foundation


enum SubmitWordResponseValueEnum: Codable {
    case responseValue(SubmitWordResponseValue)
    case integerValue(Int)
    
   enum CodingKeys: String, CodingKey {
        case responseValue, integerValue
       
      }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self = .integerValue(intValue)
        }
        else if let objectValue = try? container.decode(SubmitWordResponseValue.self) {
            self = .responseValue(objectValue)
        } else {
            throw DecodingError.typeMismatch(SubmitWordResponseValueEnum.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid type for Value")) }
    }
    
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integerValue(let intValue):
            try container.encode(intValue)
        case .responseValue(let objectValue):
            try container.encode(objectValue)
        }
    }
}

struct SubmitWordResponseData: Codable {
    let value: SubmitWordResponseValueEnum?
    let feedTime: FeedTime?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case feedTime = "FeedTime"
    }
}

struct SubmitWordResponseValue: Codable {
    let attemptNo: Int?
    let gdId: Int?
    let userPoint: Int?
    let userAttemptNo: Int?
    let userSubmitflag: [Int]?
    let wordLength: Int?
    let isHintuse: Int?
    let userWord: String?
    let mastWord: String? 
    let gtFlag: Int
    
    enum CodingKeys: String, CodingKey {
           case attemptNo
           case gdId
           case userPoint
           case userAttemptNo = "UserAttemptNo"
           case userSubmitflag, wordLength, isHintuse, userWord, mastWord, gtFlag
       }
}

struct FeedTime: Codable {
    let utcTime: String
    let istTime: String
    let cestTime: String
    
    enum CodingKeys: String, CodingKey {
            case utcTime = "UTCTime"
            case istTime = "ISTTime"
            case cestTime = "CESTTime"
        }
}

struct SubmitWordResponseMeta: Codable {
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

struct SubmitWordResponse: Codable {
    let data: SubmitWordResponseData?
    let meta: SubmitWordResponseMeta?
    
    enum CodingKeys: String, CodingKey {
           case data = "Data"
           case meta = "Meta"
       }
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


