//
//  AppBarView.swift
//  LivingHealthy
//
//  Created by Rachael Hanson on 21/04/2022.
//

import SwiftUI

struct AppBarView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @State var showSearchBar = false
    @Binding var inputText: String
    @Binding var selectedLevel: Level
    @Binding var selectedExercise: Exercise
    
    
    var SearchBarView: some View {
        VStack {
            TextField("Search something...", text: $inputText)
                .padding(5)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
               // Image(systemName: "ellipsis")
               // Spacer()
                
                if showSearchBar {
                    SearchBarView
                        .transition(.move(edge: .top))
                } else {
               //     Text("Workouts list")
               //         .bold()
                }
                 
                Spacer()
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSearchBar.toggle()
                            inputText = ""
                        }
                    }
            }
            .font(.system(size: 25))
            .frame(height: 50)
            
            //horizontal scroll to allow for many different filter and sort options
            ScrollView(.horizontal) {
                HStack(spacing: 10) {
                    Text(viewModel.nameSort.rawValue)
                        .encapulate(borderColor: .gray)
                        .onTapGesture {
                            if (viewModel.nameSort == .nameASC){
                                viewModel.nameSort = .nameDESC
                            } else {
                                viewModel.nameSort = .nameASC
                            }
                            viewModel.sortList(by: viewModel.nameSort)
                        }
                    Text(viewModel.timeSort.rawValue)
                        .encapulate(borderColor: .gray)
                        .onTapGesture {
                            if (viewModel.timeSort == .timeASC){
                                viewModel.timeSort = .timeDESC
                            } else {
                                viewModel.timeSort = .timeASC
                            }
                            viewModel.sortList(by: viewModel.timeSort)
                        }
                    
                    Picker(selectedLevel.rawValue,
                           selection: $selectedLevel) {
                        ForEach(Level.allCases, id: \.self) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                   .colorMultiply(.black)
                   .pickerStyle(.menu)
                   .padding(.vertical, -5)
                   .encapulate(borderColor: .gray)
                    
                    Picker(selectedExercise.rawValue,
                           selection: $selectedExercise) {
                        ForEach(Exercise.allCases, id: \.self) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                    .colorMultiply(.black)
                    .pickerStyle(.menu)
                    .padding(.vertical, -5)
                    .encapulate(borderColor: .gray)
 
                }
                .padding(.vertical, 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width-30, height: 100)
    }
}
