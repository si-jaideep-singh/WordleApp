//
//  Hintsview.swift
//  WordleApp
//
//  Created by Jaideep Singh on 11/07/24.
import SwiftUI
struct HintsView: View {
    @EnvironmentObject var viewModel: WordleGameViewModel
    @State private var hint: String = ""
    @State private var showHint: Bool = false
    private let apiService = ServiceManager()

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Button(action: {
                    Task {
                        await getHint(tourGameDayId: 94)
                    }
                }, label: {
                    if showHint {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .font(.title3)
                    } else {
                        Image(systemName: "bolt.fill")
                            .foregroundColor(.yellow)
                            .font(.title3)
                    }
                })
                .padding(8)
                .background(Color.blue)
                .cornerRadius(8)
                .padding()
                
                   if showHint {
                    VStack() {
                        Text(hint)
                            .padding()
                            .background(Color.yellow)
                            .cornerRadius(8)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal)
                }
            }
           
        }
    }

    func getHint(tourGameDayId: Int) async {
        if showHint {
            self.showHint = false
        } else {
            do {
                let pathType: PathType = .gethints(tourGameDayId: tourGameDayId)
                let hintURN = Hint(pathType: pathType)
                let hintData = try await apiService.execute(with: hintURN)
                let targetword = hintData.data.first?.word
                DispatchQueue.main.async {
                    if let firstHint = hintData.data.first {
                        hint = firstHint.finalHint
                        
                        self.showHint = true
                    }
                }
            } catch {
                print("Error fetching Hints:", error)
            }
        }
    }
}
struct HintsView_Previews: PreviewProvider {
    static var previews: some View {
        HintsView()
    }
}
