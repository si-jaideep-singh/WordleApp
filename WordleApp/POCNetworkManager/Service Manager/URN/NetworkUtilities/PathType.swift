//
//  PathType.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

enum PathType {
    case config
    case translation
    case employees
    case createEmployess
    case gethints(tourGameDayId: Int)
    case submitWord(userguid: String)
    case getSummitttedWord(userguid: String)
    case login(waf_guid : String?)
    
    
    private var endPoint: String {
        switch self {
        case .config:
            return  String()
        case .translation:
            return String()
        case .employees:
            return "employees"
        case .createEmployess:
            return "create"
        case .gethints(let tourGameDayId):
            let getHintsURL = "wordle/services/api/feeds/gethints?tourGamedayId={{TOURGAMEDAY_ID}}"
                .replacingOccurrences(of: CFSDKURLParamKeys.tourGamedayID,
                                      with: tourGameDayId.description)
            return getHintsURL
        case .submitWord(let userguid):
                    return "wordle/services/api/gameplay/user/\(userguid)/submitword"
        case .getSummitttedWord(userguid: let userguid):
            return "wordle/services/api/gameplay/user/{userguid}/getsubmittedword"
        case .login(waf_guid: let waf_guid):
            return "wordle/services/api/session/user/login"
        }
    }
    
    var rawValue: String {
        var url: String = endPoint
        switch self {
        case .config:
            url = url.replacingOccurrences(of: URLParamKeys.buster, with: BusterHelper.shared.getBusterFor(type: getBusterType ?? .particularCase))
            return url
        case .translation,.employees,.createEmployess:
            return url
        case .gethints(tourGameDayId: _):
            return url
        
        case .submitWord(userguid: _):
            return url
        case .getSummitttedWord(userguid: let userguid):
            return url
        case .login(waf_guid: let waf_guid):
            return url
        }
    }
    
    var getBusterType: BusterHelper.BusterType? {
        if endPoint.contains("/team") || endPoint.contains("/gamedays") || endPoint.contains("/game-card")  {
            return .normal
        } else if endPoint.contains("/private") || endPoint.contains("/public") ||
                    endPoint.contains("create") || endPoint.contains("disjoin") || endPoint.contains("join")   {
            return .particularCase
        } else {
            return .normal
        }
    }
}
