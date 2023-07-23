//
//  ViewModel.swift
//  UnitTestingSwiftUI
//
//  Created by sss on 23.07.2023.
//

import SwiftUI 

//File/New target/Unit test 
class ViewModel: ObservableObject {
    
    @Published var isPremium: Bool
    @Published var dataArray: [String] = []
    @Published var selectedItem: String? = nil
    
    init(isPremium: Bool) {
        self.isPremium = isPremium
    }
    
    func addItem(item: String) {
        guard !item.isEmpty else {return}
        self.dataArray.append(item)
    }
    
    func selectItem(item: String) {
        if let x = dataArray.first(where: { $0 == item }) {
            selectedItem = x
        } else {
            selectedItem = nil 
        }
    }
    
    func saveItem(item: String) throws {
        guard !item.isEmpty else {
            throw DataError.noData
        }
        if let x = dataArray.first(where: { $0 == item }) {
            print("Save item here! \(x)")
        } else {
            throw DataError.itemNotFound
        }
    }
}


enum DataError: LocalizedError {
    case noData
    case itemNotFound
}
