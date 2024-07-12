//
//  HintsModel.swift
//  WordleApp
//
//  Created by Jaideep Singh on 11/07/24.
//


import Foundation

// MARK: - Hints
struct Hints: Codable {
    let data: [HintsData]
    let meta: Meta

    enum CodingKeys: String, CodingKey {
        case data = "Data"
        case meta = "Meta"
    }
}

// MARK: - Datum
struct HintsData: Codable {
    let finalHint, word: String
    let tourGamedayID, wordLength: Int

    enum CodingKeys: String, CodingKey {
        case finalHint, word
        case tourGamedayID = "tourGamedayId"
        case wordLength
    }
}

// MARK: - Meta
struct Meta: Codable {
    let message: String
    let retVal: Int
    let success: Bool
    let timestamp: Timestamp

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case retVal = "RetVal"
        case success = "Success"
        case timestamp = "Timestamp"
    }
}

// MARK: - Timestamp
struct Timestamp: Codable {
    let utcTime, istTime, cestTime: String

    enum CodingKeys: String, CodingKey {
        case utcTime = "UTCTime"
        case istTime = "ISTTime"
        case cestTime = "CESTTime"
    }
}
