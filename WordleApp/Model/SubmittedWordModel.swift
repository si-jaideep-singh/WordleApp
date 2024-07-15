//
//  SubmittedWordModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 12/07/24.
//
import Foundation
struct GetSubmittedWordResponse: Codable {
    let data: CFSDKBaseResponseData
    let meta: CFSDKSDKBaseResponseMeta
    
    struct DataClass: Codable {
        let value: Value?
        let feedTime: FeedTime?
        
        struct Value: Codable {
            let attemptNo: Int?
            let gdId: Int
            let userPoint: Int?
            let isHintuse: Bool?
            let userSubmitflag: Bool?
            let wordLength: Int
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
        
        enum CodingKeys: String, CodingKey {
            case value = "Value"
            case feedTime = "FeedTime"
        }
    }
    
    struct Meta: Codable {
        let message: String
        let retVal: Int
        let success: Bool
        let timestamp: Timestamp
        
        struct Timestamp: Codable {
            let utcTime: String
            let istTime: String
            let cestTime: String
            
            enum CodingKeys: String, CodingKey {
                case utcTime = "UTCTime"
                case istTime = "ISTTime"
                case cestTime = "CESTTime"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case message = "Message"
            case retVal = "RetVal"
            case success = "Success"
            case timestamp = "Timestamp"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
}
