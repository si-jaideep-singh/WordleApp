//
//  LoginModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 15/07/24.
//

import Foundation

// MARK: - Login
struct Login: Codable {
    let data: CFSDKBaseResponseData?
    let meta: CFSDKSDKBaseResponseMeta?

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let value: Value?
    let feedTime: FeedTime?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case feedTime = "FeedTime"
    }
}

// MARK: - FeedTime
//struct FeedTime: Codable {
//    let utcTime, istTime, cestTime: String?
//
//    enum CodingKeys: String, CodingKey {
//        case utcTime = "UTCTime"
//        case istTime = "ISTTime"
//        case cestTime = "CESTTime"
//    }
//}

// MARK: - Value
struct Value: Codable {
    let guid, wafGUID, fullName, clientID: String?
    let userGUID, teamID, teamName, countryID: String?
    let countryName, favTeamID, favTeamName, isActiveTour: String?
    let isRegister, socialID: String?

    enum CodingKeys: String, CodingKey {
        case guid = "GUID"
        case wafGUID = "WAF_GUID"
        case fullName = "FullName"
        case clientID = "ClientId"
        case userGUID = "UserGuid"
        case teamID = "TeamId"
        case teamName = "TeamName"
        case countryID = "CountryId"
        case countryName = "CountryName"
        case favTeamID = "FavTeamId"
        case favTeamName = "FavTeamName"
        case isActiveTour = "IsActiveTour"
        case isRegister = "IsRegister"
        case socialID = "SocialId"
    }
}
