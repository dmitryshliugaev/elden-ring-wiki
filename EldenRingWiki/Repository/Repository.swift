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

protocol MarkRepositoryProtocol {
    func markItem(id: String) throws
    func unmarkItem(id: String) throws
    func isItemMarked(id: String) -> Bool
    func getAllMarkedItems() -> [String]
}

protocol DeathRepositoryProtocol {
    func saveDeathCount(_ count: Int)
    func getDeathCount() -> Int
}

final class Repository: MarkRepositoryProtocol, DeathRepositoryProtocol {
    private let markItemsKey = "mark_items_key"
    private let deathCountKey = "death_count_key"
    
    // MARK: - MarkRepositoryProtocol
    
    func markItem(id: String) throws {
        var markItems = getAllMarkedItems()
        markItems.append(id)
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(markItems)
        UserDefaults.standard.set(data, forKey: markItemsKey)
        UserDefaults.standard.synchronize()
    }
    
    func unmarkItem(id: String) throws {
        let items = getAllMarkedItems().filter { $0 != id }
        let encoder = JSONEncoder()
        
        let data = try encoder.encode(items)
        UserDefaults.standard.set(data, forKey: markItemsKey)
        UserDefaults.standard.synchronize()
    }
    
    func isItemMarked(id: String) -> Bool {
        return getAllMarkedItems().contains(id)
    }
    
    func getAllMarkedItems() -> [String] {
        let decoder = JSONDecoder()
        
        if let data = UserDefaults.standard.object(forKey: markItemsKey) as? Data,
           let items = try? decoder.decode([String].self, from: data) {
            return items
        } else {
            return []
        }
    }
    
    // MARK: - DeathRepositoryProtocol
    
    func saveDeathCount(_ count: Int) {
        UserDefaults.standard.set(count, forKey: deathCountKey)
        UserDefaults.standard.synchronize()
    }
    
    func getDeathCount() -> Int {
        return UserDefaults.standard.integer(forKey: deathCountKey)
    }
}
