//
//  ServiceHeaderType.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

// MARK: - SERVICE HEADER TYPES
enum ServiceHeaderType: String {
    case NONE
    case DEFAULT
    case Hint
    case submitWord
    case submittedWord
    case login
    
    func getServiceHeader(url: String) -> [String: String] {
        switch self {
        case .NONE:
            return [:]
        case .DEFAULT:
            if url.contains("/services") { return [:] }
            return ["Accept":"application/json, text/plain, */*",
                    "content-type":"application/json"]
        case .Hint:
            return getHintHeaders()
        case .submitWord:
            return SubmitWordHeaders()
        case .submittedWord:
            return SubmittedWordHeaders()
            
        case .login:
            return Login()
            
        }
        
    }
    
    private func getHintHeaders() -> [String:String] {
        return [
            "Accept":"application/json",
            "content-type": "application/json",
            "entity": "$@nt0rYu"
        ]
    }
    private func SubmitWordHeaders() -> [String:String] {
        return [
            "Accept":"application/json",
            "content-type": "application/json",
            "entity": "$@nt0rYu"
           
        ]
    }
    private func SubmittedWordHeaders() -> [String:String] {
        return [
            "Accept":"application/json, text/plain, */*",
            "content-type": "application/json",
            "entity": "$@nt0rYu"
            
        ]
    }
    private func Login() -> [String:String] {
        return [
            "Accept":"application/json, text/plain, */*",
            "content-type": "application/json",
            "entity": "$@nt0rYu",
            "Cookie" : "_USC=OHlzWTBrYk1WUStqY3dzYTl0U0xsdW5wR1AySGU5bitOdGw5RTdLejhWeDhnemgyQ25KWjE2cUNDY255dE9NaHdUejdydEtjQVB4S29JdDJFeWdDUi9PRHVKR1YzWk16Ym5qQlBJN3hiNFk0WFNUdXBEc2xLd2RLTmgwWGFibys4aENtbnkyaWk4UTI0bU1NVVdKbHM4cGdYUE9lczUrM1RBS3kvQ1l5ZjY4ZndQSG51SGRMMlpjblFhUTQ0RjZQUHZUUGlLa0NFTFpJZ1BKbTA3WGhOZ1F2OWRKVjV2Ykw3bDRmbzBhcHpFek1ZaFlid3o1UitzWHdqSkJFeEpJVFQyQkpDSFFoNXd3RXE3RWVCcE0xS0J3b2cxdEZJamlTWUM4anFwWXpSUGFKSUsyWFoxZ2s3MStHOWRNdlFyb1B6WmpKR2pwVmVrZERkdC9NNms0SXBpYjBKNXFxSlA3MEh0RlM1bEs4ZjNOMXlGMUJTalFTem5ZcmJKYnFoNnh0T3BFL2JTcHJYUTJZOWdlUndNVE50Zz09;             _URC=%7B%22user_guid%22%3A%224ae4bdb7-063f-429f-9e42-f9f74564ddad-19072024114936860%22%2C%22name%22%3A%22%22%2C%22first_name%22%3A%22Yogita%22%2C%22last_name%22%3A%22Kadam%22%2C%22email_id%22%3Anull%2C%22is_first_login%22%3A%220%22%2C%22favourite_club%22%3A%22%22%2C%22edition%22%3A%22%22%2C%22status%22%3A%221%22%2C%22is_custom_image%22%3A%220%22%2C%22social_user_image%22%3A%22%22%2C%22profile_completion_percentage%22%3Anull%2C%22client_id%22%3Anull%2C%22guid%22%3A%22DD2D047907DCACAFC29B42C5EB232BC30F701E93%22%2C%22waf_user_guid%22%3A%22330406b7-5a3c-408f-9556-e51e1689a780%22%7D; spid.89cd=339f054c-444b-4dba-812f-1338aa83a2bd.1721148402.17.1721389780.1721387562.c6dbadff-76f2-4fd5-a9f4-f075d9dfd5d3.aa062798-463b-41f3-84f3-160f9ca0aa75.335560b5-7319-48e5-95af-a9d9a29d3073.1721389612418.27; ",
//            "Cookie" : "_USC=RERJQzczN2FRMDNVRmM4WmpWNHN1QitFaU5GTXdsMjNhNU9GWExNOW5nR2pDWDBVQ2I0OXV4TnN4SnQrRzdmRVU1T2pjVFIwUnBBY3Jyc1dURmlaK3QzNVM4b2ZKM2tKbGMyWXJIMS9SOCtsUUdSSGFxWTNyb3RJQ3ZGK01kcFpmR3JNb3V1d1lkRnEveUJhbnhCWTRvL1pSdTF0SDVMRWlKc0pJTlVIZTFVNnNUamRWWFcyaURlc3haTnRSZ3dEMkgvTU9id2NWaUM1U2JqeDZOL1hzSUliSi82bng1aURXNDAxQlZaOUpFNkM2YzkxVHBvRUszM3NyN3Z4UlR3WEcvMTBJU2VLM09SWi9SVEE1T2hEdldoYVBPNEhaK2JBdCtpZ0NXanl5Ujl0TzlpaW5JQ3AzbHArZHNKTHo4R0ViUE1jdExGeE4ydkxsOVhObUdxQWI3RTRONE1wMDlveWdUTDFYOW0vZDRCS3pLWDRCSTY0NDNoSEZ0V2tMY3VKYnlpb01HSnlFS3ViQjRwQmlNbVVCZz09; _ga_X9XQE3S9GQ=GS1.1.1717229439.33.0.1717229446.0.0.0; _ga=GA1.1.2003405824.1711045215; _ga_123RTJTRKN=GS1.1.1713363647.7.1.1713365104.0.0.0; _ga_LB6E14JRKT=GS1.1.1715461890.3.0.1715461890.0.0.0; incompleteRedirect=1; _ga_L1GXT3N8H4=GS1.1.1720102205.1.1.1720102275.0.0.0; USER_DATA=^%^7B^%^22attributes^%^22^%^3A^%^5B^%^7B^%^22key^%^22^%^3A^%^22USER_ATTRIBUTE_UNIQUE_ID^%^22^%^2C^%^22value^%^22^%^3A^%^22918652364527^%^22^%^2C^%^22updated_at^%^22^%^3A1720102268933^%^7D^%^5D^%^2C^%^22subscribedToOldSdk^%^22^%^3Afalse^%^2C^%^22deviceUuid^%^22^%^3A^%^22a95f8d03-acd1-4aaf-be4a-cccda4b6344a^%^22^%^2C^%^22deviceAdded^%^22^%^3Atrue^%^7D; moe_uuid=a95f8d03-acd1-4aaf-be4a-cccda4b6344a; SESSION=^%^7B^%^22sessionKey^%^22^%^3A^%^22137b71d4-b139-4d83-9ebc-7f4736d249bb^%^22^%^2C^%^22sessionStartTime^%^22^%^3A^%^222024-07-04T14^%^3A10^%^3A07.804Z^%^22^%^2C^%^22sessionMaxTime^%^22^%^3A1800^%^2C^%^22customIdentifiersToTrack^%^22^%^3A^%^5B^%^5D^%^2C^%^22sessionExpiryTime^%^22^%^3A1720104077459^%^2C^%^22numberOfSessions^%^22^%^3A1^%^7D; OPT_IN_SHOWN_TIME=1720102208856; SOFT_ASK_STATUS=^%^7B^%^22actualValue^%^22^%^3A^%^22shown^%^22^%^2C^%^22MOE_DATA_TYPE^%^22^%^3A^%^22string^%^22^%^7D; ASP.NET_SessionId=f45jv4ej2xaaene2fwkvh0ox; _URC=^%^7B^%^22user_guid^%^22^%^3A^%^224ef1418a-edee-4c58-a3cc-fef368c5e549-04072024021104268^%^22^%^2C^%^22name^%^22^%^3A^%^22^%^22^%^2C^%^22first_name^%^22^%^3A^%^22ADITYA^%^22^%^2C^%^22last_name^%^22^%^3A^%^22Pandey^%^22^%^2C^%^22email_id^%^22^%^3Anull^%^2C^%^22is_first_login^%^22^%^3A^%^220^%^22^%^2C^%^22favourite_club^%^22^%^3A^%^22^%^22^%^2C^%^22edition^%^22^%^3A^%^22^%^22^%^2C^%^22status^%^22^%^3A^%^221^%^22^%^2C^%^22is_custom_image^%^22^%^3A^%^221^%^22^%^2C^%^22social_user_image^%^22^%^3A^%^22^%^22^%^2C^%^22profile_completion_percentage^%^22^%^3Anull^%^2C^%^22client_id^%^22^%^3Anull^%^2C^%^22guid^%^22^%^3A^%^224CF4EF7C19CB3B8D230413D1841DA9B67CB72F47^%^22^%^2C^%^22waf_user_guid^%^22^%^3A^%^228c9351ea-b5a2-45d8-9ef1-c628b6524578^%^22^%^7D;",
            
              "Referer" : "https://stg-gujarat-titans.sportz.io/wordle/gameplay"
        ]
    }
    
}
