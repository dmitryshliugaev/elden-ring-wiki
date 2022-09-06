//
//  Repository.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 06/09/2022.
//

import Foundation

enum RepositoryError: Error {
    case userDefaultsGetItems
}

protocol RepositoryProtocol {
    func markItem(id: String) throws
    func isItemMarked(id: String) -> Bool
    func getAllMarkedItems() throws -> [String]
}

final class Repository: RepositoryProtocol {
    private let markItemsKey = "mark_items_key"
    
    func markItem(id: String) throws {
        var markItems = [String]()
        if let items = try? getAllMarkedItems() {
            markItems = items
        }
        markItems.append(id)
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(markItems)
        UserDefaults.standard.set(data, forKey: markItemsKey)
        UserDefaults.standard.synchronize()
    }
    
    func isItemMarked(id: String) -> Bool {
        if let items = try? getAllMarkedItems() {
            return items.contains(id)
        } else {
            return false
        }
    }
    
    func getAllMarkedItems() throws -> [String] {
        if let data = UserDefaults.standard.object(forKey: markItemsKey) as? Data {
            let decoder = JSONDecoder()
            let items = try decoder.decode([String].self, from: data)
            return items
        } else {
            throw RepositoryError.userDefaultsGetItems
        }
    }
}
