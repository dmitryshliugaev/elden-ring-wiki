//
//  ListItemsViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Foundation

@MainActor
class ListItemsViewModel: ObservableObject {
    let type: ListType
    
    @Published var items: [ListItemsModel] = []
    
    var itemsPage = 0
    var listIsFull = false
    
    init(type: ListType) {
        self.type = type
    }
    
    func load() async {
        do {
            var newItems: [ListItemsModel] = []
            let service = Dependencies.shared.networkService
            
            switch type {
            case .weapons:
                let weapons: Weapons = try await service.load(endpoint: .weapons(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = weapons.data.map { ListItemsModel(response: $0) }
            case .armors:
                let armors: Armors = try await service.load(endpoint: .armors(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = armors.data.map { ListItemsModel(response: $0) }
            case .shields:
                let shields: Shields = try await service.load(endpoint: .shields(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = shields.data.map { ListItemsModel(response: $0) }
            case .ammos:
                let ammos: Ammos = try await service.load(endpoint: .ammos(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = ammos.data.map { ListItemsModel(response: $0) }
            case .items:
                break
            case .talismans:
                break
            case .sorcery:
                break
            case .spirits:
                break
            case .incantations:
                break
            case .ashes:
                break
            case .bosses:
                break
            case .npcs:
                break
            case .creatures:
                break
            case .locations:
                break
            case .classes:
                break
            }
            
            items.append(contentsOf: newItems)
            itemsPage += 1
            if newItems.count < Constants.API.pageLimit {
                listIsFull = true
            }
        } catch {
            print(error)
        }
    }
}
