//
//  MainView.swift
//  GymUp
//
//  Created by Denis Sinitsa on 08.09.2023.
//

import SwiftUI

struct MainView: View {
    // i think i should to create another view model here, not the same like in the BeTrainerAdd
    @ObservedObject var viewModel: MainViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Background()
                
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            IconButton(systemName: "message") {
                                viewModel.messageView.toggle()
                            }
                            
                            Spacer()
                            
                            IconButton(systemName: "list.bullet") {
                                viewModel.filtersView.toggle()
                            }
                        }
                        
                        if let trainers = viewModel.allTrainers {
                            ForEach(viewModel.filteredTrainers, id: \.id) { trainerInfo in
                                NavigationLink(destination: UserProfileCellDetailView(trainer: trainerInfo, addReviewVM: AddReviewViewModel())) {
                                    UserProfileCell(trainer: trainerInfo)
                                }
                            }
                          }
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(Color.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .refreshable {
                    try? await Task.sleep(nanoseconds: 1_500_000_000)
                    viewModel.loadAllTrainers()
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .task {
                viewModel.loadAllTrainers()
            }
            .navigationDestination(isPresented: $viewModel.messageView) {
                MessageView()
            }
            .sheet(isPresented: $viewModel.filtersView) {
                FiltersView()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
