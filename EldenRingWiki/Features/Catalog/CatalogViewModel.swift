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
            .debounce(for: .seconds(0.7), scheduler: RunLoop.main)
            .sink { [weak self] search in
                guard let self = self else { return }
                if !search.isEmpty {
                    self.state = .loading
                    
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
        markedList = repository.getAllMarkedItems()
    }
    
    func showDetailView(with item: ListItemsModel) {
        selectedItem = item
        isShowDetailView = true
    }
    
    func fetchSearchItem(query: String) async {
        do {
            var searchItems: [ListItemsModel] = []
            let service = Dependencies.shared.networkService
            
            let weaponTask = Task<Weapons, Error> {
                try await service.load(endpoint: .weapons(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await weaponTask.value.data.map { ListItemsModel($0) }
            
            let armorsTask = Task<Armors, Error> {
                try await service.load(endpoint: .armors(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await armorsTask.value.data.map { ListItemsModel($0) }
            
            let shieldsTask = Task<Shields, Error> {
                try await service.load(endpoint: .shields(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await shieldsTask.value.data.map { ListItemsModel($0) }
            
            let ammosTask = Task<Ammos, Error> {
                try await service.load(endpoint: .ammos(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await ammosTask.value.data.map { ListItemsModel($0) }
            
            let itemsTask = Task<Items, Error> {
                try await service.load(endpoint: .items(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await itemsTask.value.data.map { ListItemsModel($0) }
            
            let talismansTask = Task<Talismans, Error> {
                try await service.load(endpoint: .talismans(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await talismansTask.value.data.map { ListItemsModel($0) }
            
            let sorceriesTask = Task<Sorceries, Error> {
                try await service.load(endpoint: .sorceries(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await sorceriesTask.value.data.map { ListItemsModel($0) }
            
            let spiritsTask = Task<Spirits, Error> {
                try await service.load(endpoint: .spirits(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await spiritsTask.value.data.map { ListItemsModel($0) }
            
            let incantationsTask = Task<Incantations, Error> {
                try await service.load(endpoint: .incantations(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await incantationsTask.value.data.map { ListItemsModel($0) }
            
            let ashesTask = Task<Ashes, Error> {
                try await service.load(endpoint: .ashes(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await ashesTask.value.data.map { ListItemsModel($0) }
            
            let bossesTask = Task<Bosses, Error> {
                try await service.load(endpoint: .bosses(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await bossesTask.value.data.map { ListItemsModel($0) }
            
            let npcsTask = Task<NPCs, Error> {
                try await service.load(endpoint: .npcs(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await npcsTask.value.data.map { ListItemsModel($0) }
            
            let creaturesTask = Task<Creatures, Error> {
                try await service.load(endpoint: .creatures(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await creaturesTask.value.data.map { ListItemsModel($0) }
            
            let locationsTask = Task<Locations, Error> {
                try await service.load(endpoint: .locations(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await locationsTask.value.data.map { ListItemsModel($0) }
            
            let characterClassesTask = Task<CharacterClasses, Error> {
                try await service.load(endpoint: .characterClasses(page: 0, limit: Constants.API.pageLimit, name: query))
            }
            searchItems += try await characterClassesTask.value.data.map { ListItemsModel($0) }
            
            state = .searchData(items: searchItems)
        } catch {
            print(error)
            state = .error
        }
    }
}
