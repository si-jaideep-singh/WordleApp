//
//  ExtendedURNs.swift
//  POCNetworkManager
//
//  Created by Vidyasagar Kodunuri on 24/06/24.
//

import Foundation

struct ConfigURN: CommonGetURN {
    typealias Derived = String
    
    var baseURLType: BaseURLType {
        .base
    }
    
    var pathType: PathType {
        .config
    }
}

struct TranslationURN: CommonGetURN {
    typealias Derived = [String:String]
    
    var baseURLType: BaseURLType {
        .base
    }
    
    var pathType: PathType {
        .translation
    }
}
struct Employees : CommonGetURN {
    typealias Derived = Employee
    
    var baseURLType: BaseURLType{
        return .base
    }
    var pathType: PathType{
        return .employees
    }
     
}

// MARK: - POST URN
struct AddEmployeeURN: CommonPostURN {
    typealias Derived =  AddEmployeeResponse
    
    var baseURLType: BaseURLType{
        return .base
    }
    
    var pathType: PathType{
        return .createEmployess
    }
    
    var body: Data?
    
    }
