//
//  EmployeeViewModel.swift
//  POCNetworkManager
//
//  Created by Jaideep Singh on 05/07/24.
import Foundation
import SwiftUI
class EmployeeViewModel: ObservableObject {
    @Published var employees: [Datum] = []

    private let apiService = ServiceManager()

    func fetchEmployees() {
        Task {
            do {
                let employeeData = try await apiService.execute(with: Employees())
                DispatchQueue.main.async {
                    self.employees = employeeData.data
                }
            } catch {
                print("Error fetching employees:", error)
               
            }
        }
    }

    func addEmployee(name: String, salary: String, age: String) {
        guard let employeeAge = Int(age), let employeeSalary = Double(salary) else {
            print("Invalid age or salary input")
            return
        }

        let newEmployee = PostEmployee(name: name, age: employeeAge, salary: employeeSalary)
    

        Task {
            do {
                let requestbody = try newEmployee.encodeJSON()
                let createPostUrn = AddEmployeeURN(body: requestbody)
                let response = try await apiService.execute(with: createPostUrn)
                let newData = Datum(id: response.data.id, employeeName: name, employeeSalary: Int(employeeSalary), employeeAge: employeeAge, profileImage: "")
               
                self.employees.append(newData)
                
                fetchEmployees()
            } catch {
                print("Error adding employee:", error)
            
            }
            
            }
        }
    }

