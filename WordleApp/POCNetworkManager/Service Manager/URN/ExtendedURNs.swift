//
//  ExtendedURNs.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

struct ConfigURN: CommonGetURN {
    var headers: ServiceHeaderType?
    
    typealias Derived = String
    
    var baseURLType: BaseURLType {
        .base
    }
    
    var pathType: PathType {
        .config
    }
}

struct TranslationURN: CommonGetURN {
    var headers: ServiceHeaderType?
    
    typealias Derived = [String:String]
    
    var baseURLType: BaseURLType {
        .base
    }
    
    var pathType: PathType {
        .translation
    }
}
struct Employees : CommonGetURN {
    var headers: ServiceHeaderType?
    
    typealias Derived = Employee
    
    var baseURLType: BaseURLType {
        return .base
    }
    var pathType: PathType {
        return .employees
    }
     
}
struct Hint : CommonGetURN{
//    var headers: ServiceHeaderType?
    
    typealias Derived = Hints
    
    
    
    var baseURLType: BaseURLType{
        return .base
    }
    
    var pathType: PathType
    var headers: ServiceHeaderType?{
        .Hint
    }
 }

struct SubmittedWord: CommonGetURN{
//    var headers: ServiceHeaderType?
    
    typealias Derived = GetSubmittedWordResponse
    
    
    
    var baseURLType: BaseURLType{
        return .base
    }
    
    var pathType: PathType
    var headers: ServiceHeaderType?{
        .submittedWord
    }
 }

// MARK: - POST URN
struct AddEmployeeURN: CommonPostURN {
    var headers: ServiceHeaderType?
    
    typealias Derived = AddEmployeeResponse
    
    var baseURLType: BaseURLType {
        return .base
    }
    
    var pathType: PathType {
        return .createEmployess
    }
    
    var body: Data?
    
    }

struct SubmitWordURN: CommonPostURN {
    var headers: ServiceHeaderType?{
        .submitWord
    }
     typealias Derived = SubmitWordResponse
    
    var baseURLType: BaseURLType {
        return .base
    }
    
    var pathType: PathType 
     
    
    var body: Data?
    
   }

struct LoginURN: CommonPostURN {
    var headers: ServiceHeaderType?{
        .login
    }
     typealias Derived = Login
    var baseURLType: BaseURLType {
        return .base
    }
    
    var pathType: PathType
     
    
    var body: Data?
    
   }


