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
    let meta: CFSDKSDKBaseResponseMeta

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

