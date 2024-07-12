//
//  EmployeeModel.swift
//  POCNetworkManager
//
//  Created by Jaideep Singh on 04/07/24.
//

import Foundation


// MARK: - Employees
struct Employee: Codable {
    let status: String
    let data: [Datum]
    let message: String
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let employeeName: String
    let employeeSalary, employeeAge: Int
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
struct AddEmployeeResponse: Codable {
    let status: String
    let data: EmployeeData
    let message: String
}

struct EmployeeData: Codable {
    let id: Int
}
struct PostEmployee: Codable {
    let name: String
    let age: Int
    let salary: Double
}

