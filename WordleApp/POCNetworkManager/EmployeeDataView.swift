//
//  EmployeeDataView.swift
//  POCNetworkManager
//
//  Created by Jaideep Singh on 05/07/24.
//

import SwiftUI

struct EmployeeDataView: View {
    @StateObject private var viewModel = EmployeeViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.employees, id: \.id) { employee in
                VStack(alignment: .leading) {
                    Text(employee.employeeName)
                        .font(.headline)
                    Text("Age: \(employee.employeeAge)")
                        .font(.subheadline)
                }
            }
            .onAppear(){
                viewModel.fetchEmployees()
            }
           
        }
        .padding()
    }}

#Preview {
    EmployeeDataView()
}
