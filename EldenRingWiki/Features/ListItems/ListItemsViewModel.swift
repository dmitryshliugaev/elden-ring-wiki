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
                let items: Items = try await service.load(endpoint: .items(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = items.data.map { ListItemsModel(response: $0) }
            case .talismans:
                let talismans: Talismans = try await service.load(endpoint: .talismans(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = talismans.data.map { ListItemsModel(response: $0) }
            case .sorceries:
                let sorceries: Sorceries = try await service.load(endpoint: .sorceries(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = sorceries.data.map { ListItemsModel(response: $0) }
            case .spirits:
                let spirits: Spirits = try await service.load(endpoint: .spirits(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = spirits.data.map { ListItemsModel(response: $0) }
            case .incantations:
                let incantations: Incantations = try await service.load(endpoint: .incantations(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = incantations.data.map { ListItemsModel(response: $0) }
            case .ashes:
                let ashes: Ashes = try await service.load(endpoint: .ashes(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = ashes.data.map { ListItemsModel(response: $0) }
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
