//
//  CatalogViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI
import Combine

@MainActor
class CatalogViewModel: ObservableObject {
    enum State {
        case catalog, loading, searchData(items: [ListItemsModel]), error
    }
    
    private let repository: RepositoryProtocol
    
    @Published var state: State = .catalog
    @Published var searchText: String = ""
    @Published var isShowDetailView = false
    @Published var markedList: [String] = []
    
    var selectedItem: ListItemsModel?
    
    private var cancellableSet: Set<AnyCancellable> = Set()
    
    init(repository: RepositoryProtocol) {
        self.repository = repository
        
        _searchText
            .projectedValue
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] search in
                guard let self = self else { return }
                if !search.isEmpty {
                    Task {
                        await self.fetchSearchItem(query: search)
                    }
                } else {
                    self.state = .catalog
                }
            }
            .store(in: &cancellableSet)
    }
    
    func getMarkedList() {
        do {
            markedList = try repository.getAllMarkedItems()
        } catch {
            print(error)
        }
    }
    
    func showDetailView(with item: ListItemsModel) {
        selectedItem = item
        isShowDetailView = true
    }
    
    func fetchSearchItem(query: String) async {
        state = .loading
        
        do {
            var searchItems: [ListItemsModel] = []
            let service = Dependencies.shared.networkService
            
            let weapons: Weapons = try await service.load(endpoint: .weapons(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += weapons.data.map { ListItemsModel($0) }
            
            let armors: Armors = try await service.load(endpoint: .armors(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += armors.data.map { ListItemsModel($0) }
            
            let shields: Shields = try await service.load(endpoint: .shields(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += shields.data.map { ListItemsModel($0) }
            
            let ammos: Ammos = try await service.load(endpoint: .ammos(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += ammos.data.map { ListItemsModel($0) }
            
            let items: Items = try await service.load(endpoint: .items(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += items.data.map { ListItemsModel($0) }
            
            let talismans: Talismans = try await service.load(endpoint: .talismans(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += talismans.data.map { ListItemsModel($0) }
            
            let sorceries: Sorceries = try await service.load(endpoint: .sorceries(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += sorceries.data.map { ListItemsModel($0) }
            
            let spirits: Spirits = try await service.load(endpoint: .spirits(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += spirits.data.map { ListItemsModel($0) }
            
            let incantations: Incantations = try await service.load(endpoint: .incantations(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += incantations.data.map { ListItemsModel($0) }
            
            let ashes: Ashes = try await service.load(endpoint: .ashes(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += ashes.data.map { ListItemsModel($0) }
            
            let bosses: Bosses = try await service.load(endpoint: .bosses(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += bosses.data.map { ListItemsModel($0) }
            
            let npcs: NPCs = try await service.load(endpoint: .npcs(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += npcs.data.map { ListItemsModel($0) }
            
            let creatures: Creatures = try await service.load(endpoint: .creatures(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += creatures.data.map { ListItemsModel($0) }
            
            let locations: Locations = try await service.load(endpoint: .locations(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += locations.data.map { ListItemsModel($0) }
            
            let characterClasses: CharacterClasses = try await service.load(endpoint: .characterClasses(page: 0, limit: Constants.API.pageLimit, name: query))
            searchItems += characterClasses.data.map { ListItemsModel($0) }
            
            state = .searchData(items: searchItems)
        } catch {
            state = .error
        }
    }
}
