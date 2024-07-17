//
//  WordleBaseModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 15/07/24.
//

import Foundation

struct CFSDKBaseResponse: Codable {
    let data: CFSDKBaseResponseData?
    let meta: CFSDKSDKBaseResponseMeta?
    
    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
}

struct CFSDKBaseResponseData: Codable {
   let feedTime: CFSDKBaseFeedTime?
    
    enum CodingKeys: String, CodingKey {
       case feedTime = "FeedTime"
    }
}

struct CFSDKSDKBaseResponseMeta: Codable {
    let message: String?
    let retVal: Int? 
    let success: Bool?
    let statusCode: Int?
    let maintenance: String?
    let timestamp: CFSDKBaseFeedTime?
    
    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case retVal = "RetVal"
        case success = "Success"
        case statusCode = "StatusCode"
        case maintenance = "Maintenance"
        case timestamp = "Timestamp"
    }
}

// MARK: - F1SDKFeedTime
struct CFSDKBaseFeedTime: Codable {
    let utcTime, istTime, cestTime: String?
    
    enum CodingKeys: String, CodingKey {
        case utcTime = "UTCTime"
        case istTime = "ISTTime"
        case cestTime = "CESTTime"
    }
}


struct CFSDKSDKBaseTeamValue: Codable {
    let retval: Int?
}

