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
            
            //Jaideep
           /* "Cookie" : "_USC=RERJQzczN2FRMDNVRmM4WmpWNHN1QitFaU5GTXdsMjNhNU9GWExNOW5nR2pDWDBVQ2I0OXV4TnN4SnQrRzdmRVU1T2pjVFIwUnBBY3Jyc1dURmlaK3QzNVM4b2ZKM2tKbGMyWXJIMS9SOCtsUUdSSGFxWTNyb3RJQ3ZGK01kcFpmR3JNb3V1d1lkRnEveUJhbnhCWTRvL1pSdTF0SDVMRWlKc0pJTlVIZTFVNnNUamRWWFcyaURlc3haTnRSZ3dEMkgvTU9id2NWaUM1U2JqeDZOL1hzSUliSi82bng1aURXNDAxQlZaOUpFNkM2YzkxVHBvRUszM3NyN3Z4UlR3WEcvMTBJU2VLM09SWi9SVEE1T2hEdldoYVBPNEhaK2JBdCtpZ0NXanl5Ujl0TzlpaW5JQ3AzbHArZHNKTHo4R0ViUE1jdExGeE4ydkxsOVhObUdxQWI3RTRONE1wMDlveWdUTDFYOW0vZDRCS3pLWDRCSTY0NDNoSEZ0V2tMY3VKYnlpb01HSnlFS3ViQjRwQmlNbVVCZz09; _ga_X9XQE3S9GQ=GS1.1.1717229439.33.0.1717229446.0.0.0; _ga=GA1.1.2003405824.1711045215; _ga_123RTJTRKN=GS1.1.1713363647.7.1.1713365104.0.0.0; _ga_LB6E14JRKT=GS1.1.1715461890.3.0.1715461890.0.0.0; incompleteRedirect=1; _ga_L1GXT3N8H4=GS1.1.1720102205.1.1.1720102275.0.0.0; USER_DATA=^%^7B^%^22attributes^%^22^%^3A^%^5B^%^7B^%^22key^%^22^%^3A^%^22USER_ATTRIBUTE_UNIQUE_ID^%^22^%^2C^%^22value^%^22^%^3A^%^22918652364527^%^22^%^2C^%^22updated_at^%^22^%^3A1720102268933^%^7D^%^5D^%^2C^%^22subscribedToOldSdk^%^22^%^3Afalse^%^2C^%^22deviceUuid^%^22^%^3A^%^22a95f8d03-acd1-4aaf-be4a-cccda4b6344a^%^22^%^2C^%^22deviceAdded^%^22^%^3Atrue^%^7D; moe_uuid=a95f8d03-acd1-4aaf-be4a-cccda4b6344a; SESSION=^%^7B^%^22sessionKey^%^22^%^3A^%^22137b71d4-b139-4d83-9ebc-7f4736d249bb^%^22^%^2C^%^22sessionStartTime^%^22^%^3A^%^222024-07-04T14^%^3A10^%^3A07.804Z^%^22^%^2C^%^22sessionMaxTime^%^22^%^3A1800^%^2C^%^22customIdentifiersToTrack^%^22^%^3A^%^5B^%^5D^%^2C^%^22sessionExpiryTime^%^22^%^3A1720104077459^%^2C^%^22numberOfSessions^%^22^%^3A1^%^7D; OPT_IN_SHOWN_TIME=1720102208856; SOFT_ASK_STATUS=^%^7B^%^22actualValue^%^22^%^3A^%^22shown^%^22^%^2C^%^22MOE_DATA_TYPE^%^22^%^3A^%^22string^%^22^%^7D; ASP.NET_SessionId=f45jv4ej2xaaene2fwkvh0ox; _URC=^%^7B^%^22user_guid^%^22^%^3A^%^224ef1418a-edee-4c58-a3cc-fef368c5e549-04072024021104268^%^22^%^2C^%^22name^%^22^%^3A^%^22^%^22^%^2C^%^22first_name^%^22^%^3A^%^22ADITYA^%^22^%^2C^%^22last_name^%^22^%^3A^%^22Pandey^%^22^%^2C^%^22email_id^%^22^%^3Anull^%^2C^%^22is_first_login^%^22^%^3A^%^220^%^22^%^2C^%^22favourite_club^%^22^%^3A^%^22^%^22^%^2C^%^22edition^%^22^%^3A^%^22^%^22^%^2C^%^22status^%^22^%^3A^%^221^%^22^%^2C^%^22is_custom_image^%^22^%^3A^%^221^%^22^%^2C^%^22social_user_image^%^22^%^3A^%^22^%^22^%^2C^%^22profile_completion_percentage^%^22^%^3Anull^%^2C^%^22client_id^%^22^%^3Anull^%^2C^%^22guid^%^22^%^3A^%^224CF4EF7C19CB3B8D230413D1841DA9B67CB72F47^%^22^%^2C^%^22waf_user_guid^%^22^%^3A^%^228c9351ea-b5a2-45d8-9ef1-c628b6524578^%^22^%^7D;"*/
            
            //Aditya
//        "Cookie" :
//                "_USC=RERJQzczN2FRMDNVRmM4WmpWNHN1QitFaU5GTXdsMjNhNU9GWExNOW5nR2pDWDBVQ2I0OXV4TnN4SnQrRzdmRVU1T2pjVFIwUnBBY3Jyc1dURmlaK21na3pBa3gvL09lK1RpYmZsR2pJQ05ycktHMSs4ck1TYlpYZThTdWp2N2c5ZmROOHEzdUtlVS95M3FOOXg2bXQxa3EzNi96d255Q0RSM0JvRWlIcnN3bUFmWEx0TFh1RVlkRkZEeXdiTkdtdHN0dDc0emtndG9zUWNQWTZ2amVvTWxGeG9rMXFEdEwwY0xvWFdhTWhpNHU1K0JDeVpUVHFUbjErbEdYY0hCd1c2emp0S3RrOVpGUTE5Wnp6amNaT3NEVVM0aDlhYWpZWXJOdlBrdEp6VUpBcytVZVJ3Ui8rZ2NxZXIrVUZkVzA2WnhramxkSWIxSHRmUTNGaFJIZXBFZFJ0SkhGcjNxVzZXczVlMVlPZ2x2Sk5Cb1NvMDNNa2V1WExwVVljeUxtNDEzZkYzM0MyYTZhSzB1TEhFSHVidz09; _URC=%7B%22user_guid%22%3A%22cb9b71c2-df6d-4349-9e68-0d18dae7b3af-22072024125231974%22%2C%22name%22%3A%22%22%2C%22first_name%22%3A%22ADITYA%22%2C%22last_name%22%3A%22Pandey%22%2C%22email_id%22%3Anull%2C%22is_first_login%22%3A%220%22%2C%22favourite_club%22%3A%22%22%2C%22edition%22%3A%22%22%2C%22status%22%3A%221%22%2C%22is_custom_image%22%3A%221%22%2C%22social_user_image%22%3A%22%22%2C%22profile_completion_percentage%22%3Anull%2C%22client_id%22%3Anull%2C%22guid%22%3A%224CF4EF7C19CB3B8D230413D1841DA9B67CB72F47%22%2C%22waf_user_guid%22%3A%228c9351ea-b5a2-45d8-9ef1-c628b6524578%22%7D; spses.8229=*; spid.8229=186258ed-b240-4908-9016-aa27b9aeca75.1721652753.1.1721652753..d3ec3d75-cbd1-45ad-ab6a-886ef540cbd5..17a71320-ab67-431e-879e-fa187357932c.1721652753124.2; ",
            //Shubham
            "Cookie" :"   _ga=GA1.1.533606526.1709377985; __gads=ID=aa660bfbbca60277:T=1709551920:RT=1709551920:S=ALNI_Map_wTC4sJRTR4Xb3Me1eD3Om9tMA; __gpi=UID=00000d24de6dd9e3:T=1709551920:RT=1709551920:S=ALNI_MZHMI96fGZlD0U_SCWWSj_XYHPpdA; __eoi=ID=983ff4c4313f57a9:T=1709551920:RT=1709551920:S=AA-AfjbIwA9nphik3oiLk1RFOvBK; _ga_123RTJTRKN=GS1.1.1713162205.10.0.1713162205.0.0.0; _ga_F9NQYFL7NL=GS1.1.1717781426.4.0.1717781426.60.0.0; ASP.NET_SessionId=vojaggxlczyjypdoj3bqei5b; si-wordle-mix-api-buster=20240722143625; spses.8229=*; GTWordle_RAW=%7B%0A%20%20%22GUID%22%3A%20%22485c1408-4838-11ef-89fa-0e3f2a47a899%22%2C%0A%20%20%22WAF_GUID%22%3A%20%22C20159716A41F98DE73AE216258B2CBE909E5856%22%2C%0A%20%20%22FullName%22%3A%20%22%22%2C%0A%20%20%22ClientId%22%3A%20%221%22%2C%0A%20%20%22UserGuid%22%3A%20%22%22%2C%0A%20%20%22TeamId%22%3A%20%22%22%2C%0A%20%20%22TeamName%22%3A%20%22%22%2C%0A%20%20%22CountryId%22%3A%20%22%22%2C%0A%20%20%22CountryName%22%3A%20%22%22%2C%0A%20%20%22FavTeamId%22%3A%20%22%22%2C%0A%20%20%22FavTeamName%22%3A%20%22%22%2C%0A%20%20%22IsActiveTour%22%3A%20null%2C%0A%20%20%22IsRegister%22%3A%20%22%22%2C%0A%20%20%22SocialId%22%3A%20%22EC2DAA7B166F%22%0A%7D; GTWordle_007=B6607F90601434168F70D018687F59B37CD9D1C9341C3EB63668E8B034E183AB3CD5635CCBBFD07968579A7767665A709DA4A958229A0606CC9D6E88D56A235ADEE10BA858EB4A8D0A31881F7CE603877049B48E5AF901307F45769ED909BEBFD0B6AA889B24CD0B1B1903248EE80F5875EC370EC17A266342B4BED75120E829D379082C4AB10E776B920F92589D9BEA7AB6353B195A9DA7E7B77292577960CE6809E8DDF98AF08E92EEDDF0CAE9A10731BC9604D3067EF4E11DBC1A828E3E9960B6CC1DFE2EB7BB0ADC9E4821208F7DE181D6EEC8ECE8274D46596DFBDFE4D5C14D93F839988ECF5977763B95043115D0; spid.8229=186258ed-b240-4908-9016-aa27b9aeca75.1721652753.2.1721659240.1721652753.fef5696d-7742-4ecf-97ea-8736adad0ef0.d3ec3d75-cbd1-45ad-ab6a-886ef540cbd5.d432b155-f163-4d52-9fa6-b96e6a0bb966.1721659045831.2; moe_uuid=af205e13-60cb-4057-ae76-8cc45f70ab2d; OPT_IN_SHOWN_TIME=1721659240683; SOFT_ASK_STATUS=%7B%22actualValue%22%3A%22shown%22%2C%22MOE_DATA_TYPE%22%3A%22string%22%7D; _USC=Ry9Ea2wzazk3bU4rcUVTZFhraDA5VXNNazZobWcrWmJ5UlM5Ymg0MUZ1a3RUc09jb0w2YjBJcVFpSXRTcDdySkhzZk1EZGlrRnhwWG1BbzlOMDRqUlBDdElSVXY2UTFsdTdmZmdjc2I2NVpkR0o0TVVaQ0M4R3hhZkp3NUJFd0JsY1JqVkc4S1FhZHFMMG1HKy9TSUkyR0RRT0RabEd3UG5ydFpuYWtlZVJyQmtabDFTaUtmKzA0K203OWc1eGJkUmFuYVhTNENlYlV3QVBLNVhvcTRDai8rU1Y3ZW1zaGdoMzdJV2dROFpoZ2wyZThLL0dpZHN6eHE2UGtqbktWUk1JOTRFWWRZOUk2VlVOZDVzT0ozQlZTRDBlSmZtcHVVekVIeUg4ZWhZZTlLRFhaelhjYlM4ZU8xV25lYzhnZzE2VS9mdjl5SlBseDNRR3J2U1JvaThRdFBTVnJGNHdQZm5QZlZJMUE2TUNOeXNVaEoyV0NHbldCVTR6eE1nNFVv; incompleteRedirect=1; _URC=%7B%22user_guid%22%3A%22e0f88d61-4517-487f-b7e8-8cb179bfae85-22072024024230732%22%2C%22name%22%3A%22%22%2C%22first_name%22%3A%22%22%2C%22last_name%22%3A%22%22%2C%22email_id%22%3Anull%2C%22is_first_login%22%3A0%2C%22favourite_club%22%3A%22%22%2C%22edition%22%3A%22%22%2C%22status%22%3A%222%22%2C%22is_custom_image%22%3A%220%22%2C%22social_user_image%22%3A%22%22%2C%22profile_completion_percentage%22%3Anull%2C%22client_id%22%3Anull%2C%22guid%22%3A%222FF6484886BBC46C0F918E0B98A663AA40C32895%22%2C%22waf_user_guid%22%3A%22fbb06c13-2327-448f-a29e-84c0b0f4a2db%22%7D; USER_DATA=%7B%22attributes%22%3A%5B%7B%22key%22%3A%22USER_ATTRIBUTE_UNIQUE_ID%22%2C%22value%22%3A%22918010811570%22%2C%22updated_at%22%3A1721659355260%7D%5D%2C%22subscribedToOldSdk%22%3Afalse%2C%22deviceUuid%22%3A%22af205e13-60cb-4057-ae76-8cc45f70ab2d%22%2C%22deviceAdded%22%3Atrue%7D; SESSION=%7B%22sessionKey%22%3A%220b0d622d-efb4-4ad8-82d9-7ac47950d93a%22%2C%22sessionStartTime%22%3A%222024-07-22T14%3A40%3A39.676Z%22%2C%22sessionMaxTime%22%3A1800%2C%22customIdentifiersToTrack%22%3A%5B%5D%2C%22sessionExpiryTime%22%3A1721661155270%2C%22numberOfSessions%22%3A1%7D; _ga_L1GXT3N8H4=GS1.1.1721659050.9.1.1721659370.0.0.0 ",
                     "Referer" : "https://stg-gujarat-titans.sportz.io/wordle/gameplay"
        ]
    }
    
}
