//
//  EmplyeeDataView.swift
//  WordleApp
//
//  Created by Jaideep Singh on 05/07/24.
//

import SwiftUI

struct EmplyeeDataView: View {
    
        let apiService = ServiceManager()
        @State private var employees: [Datum] = []
        
        var body: some View {
            VStack {
                List(employees, id: \.id) { employee in
                    VStack(alignment: .leading) {
                        Text(employee.employeeName)
                            .font(.headline)
                        Text("Age: \(employee.employeeAge)")
                            .font(.subheadline)
                    }
                }
                .task{
                    do {
                        let employeeData = try await apiService.execute(with: Employees())
                        
                        employees = employeeData.data
                    } catch {
                        print(error)
                    }
                }
            }
            .padding()
        }
    }


#Preview {
    EmplyeeDataView()
}
