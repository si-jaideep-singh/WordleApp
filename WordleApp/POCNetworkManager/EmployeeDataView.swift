//
//  EmployeeDataView.swift
//  POCNetworkManager
//
//  Created by Jaideep Singh on 05/07/24.
//

import SwiftUI

struct EmployeeDataView: View {
    @StateObject private var viewModel = EmployeeViewModel()
    @State private var newEmployeeName = ""
    @State private var newEmployeeSalary = ""
    @State private var newEmployeeAge = ""

    var body: some View {
        VStack {
            List(viewModel.employees, id: \.id) { employee in
                VStack(alignment: .leading) {
                    Text(employee.employeeName)
                        .font(.headline)
                    Text("Age: \(employee.employeeAge)")
                        .font(.subheadline)
                    Text("Salary: \(employee.employeeSalary)")
                        .font(.subheadline)
                    
                    
                }
            }
            .onAppear {
                viewModel.fetchEmployees()
            }
            
            VStack {
                HStack {
                    TextField("Name", text: $newEmployeeName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Salary", text: $newEmployeeSalary)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                    TextField("Age", text: $newEmployeeAge)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad) // Use .numberPad for whole numbers
                }
                .padding()

                Button("Add Employee") {
                    viewModel.addEmployee(name: newEmployeeName, salary: newEmployeeSalary, age: newEmployeeAge)
                    newEmployeeName = ""
                    newEmployeeSalary = ""
                    newEmployeeAge = ""
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
            }
            .padding()
        }
        .padding()
    }
}

struct EmployeeDataView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeeDataView()
    }
}
