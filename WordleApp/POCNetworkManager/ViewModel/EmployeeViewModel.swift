//
//  EmployeeViewModel.swift
//  POCNetworkManager
//
//  Created by Jaideep Singh on 05/07/24.
//

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
                print(error)
            }
        }
    }
}
