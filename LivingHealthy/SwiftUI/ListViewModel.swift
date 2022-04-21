//
//  ListViewModel.swift
//  LivingHealthy
//
//  Created by Rachael Hanson on 21/04/2022.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var workouts = [Workout]()
    @Published var nameSort = SortBy.nameASC
    @Published var timeSort = SortBy.timeASC
    
    init() {
        print("SSS")
        workouts = loadJsonFile()
    }
    
    private func loadJsonFile() -> [Workout]{
        var dbData = [Workout]()
        do {
            if let filePath  = Bundle.main.url(forResource: "DBdata", withExtension: "json") {
                
                let jsonData = try Data(contentsOf: filePath)
                let decodedData = try JSONDecoder().decode([Workout].self, from: jsonData)
                print("Decoded: \(decodedData)")
                dbData = decodedData
            } else {
                return [Workout]()
            }
        } catch let error {
            print("[System] Error while fetching: \(error)")
        }
        return dbData
    }
    
    func sortList(by sortType: SortBy) {
        switch sortType {
        case .nameASC:
            workouts.sort {
                $0.name.lowercased() < $1.name.lowercased()
            }
        case .nameDESC:
            workouts.sort {
                $0.name.lowercased() > $1.name.lowercased()
            }
        case .timeASC:
            workouts.sort {
                $0.time < $1.time
            }
        case .timeDESC:
            workouts.sort {
                $0.time > $1.time
            }
        }
    }
    
    enum SortBy: String {
        case nameASC = "Name △"
        case nameDESC = "Name ▽"
        case timeASC = "Time △"
        case timeDESC = "Time ▽"
    }
}
