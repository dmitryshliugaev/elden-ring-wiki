//
//  ListItemsViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Combine

@MainActor
class ListItemsViewModel: ObservableObject {
    private let repository: MarkRepositoryProtocol
    private var items: [ListItemsModel] = []
    
    let type: ListType
    
    @Published var filteredItems: [ListItemsModel] = []
    @Published var isShowDetailView = false
    @Published var filterType: FilterType = .all
    @Published var markedList: [String] = []
    @Published var isShowError = false
    
    var itemsPage = 0
    var listIsFull = false
    var selectedItem: ListItemsModel?
    var errorDescription: String = ""
    
    private var cancellable: AnyCancellable?
    
    init(type: ListType,
         repository: MarkRepositoryProtocol) {
        self.type = type
        self.repository = repository
        
        cancellable = $filterType
            .sink(receiveValue: { [unowned self] filterType in
                self.applyFilter(type: filterType)
            })
    }
    
    func getMarkedList() {
        markedList = repository.getAllMarkedItems()
    }
    
    func applyFilter(type: FilterType) {
        switch type {
        case .all:
            filteredItems = items
        case .checked:
            filteredItems = items.filter { markedList.contains($0.id) }
        case .unchecked:
            filteredItems = items.filter { !markedList.contains($0.id) }
        }
    }
    
    func showDetailView(with item: ListItemsModel) {
        selectedItem = item
        isShowDetailView = true
    }
    
    func load() async {
        do {
            var newItems: [ListItemsModel] = []
            let service = Dependencies.shared.networkService
            
            switch type {
            case .weapons:
                let weapons: Weapons = try await service.load(endpoint: .weapons(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = weapons.data.map { ListItemsModel($0) }
            case .armors:
                let armors: Armors = try await service.load(endpoint: .armors(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = armors.data.map { ListItemsModel($0) }
            case .shields:
                let shields: Shields = try await service.load(endpoint: .shields(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = shields.data.map { ListItemsModel($0) }
            case .ammos:
                let ammos: Ammos = try await service.load(endpoint: .ammos(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = ammos.data.map { ListItemsModel($0) }
            case .items:
                let items: Items = try await service.load(endpoint: .items(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = items.data.map { ListItemsModel($0) }
            case .talismans:
                let talismans: Talismans = try await service.load(endpoint: .talismans(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = talismans.data.map { ListItemsModel($0) }
            case .sorceries:
                let sorceries: Sorceries = try await service.load(endpoint: .sorceries(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = sorceries.data.map { ListItemsModel($0) }
            case .spirits:
                let spirits: Spirits = try await service.load(endpoint: .spirits(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = spirits.data.map { ListItemsModel($0) }
            case .incantations:
                let incantations: Incantations = try await service.load(endpoint: .incantations(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = incantations.data.map { ListItemsModel($0) }
            case .ashes:
                let ashes: Ashes = try await service.load(endpoint: .ashes(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = ashes.data.map { ListItemsModel($0) }
            case .bosses:
                let bosses: Bosses = try await service.load(endpoint: .bosses(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = bosses.data.map { ListItemsModel($0) }
            case .npcs:
                let npcs: NPCs = try await service.load(endpoint: .npcs(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = npcs.data.map { ListItemsModel($0) }
            case .creatures:
                let creatures: Creatures = try await service.load(endpoint: .creatures(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = creatures.data.map { ListItemsModel($0) }
            case .locations:
                let locations: Locations = try await service.load(endpoint: .locations(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = locations.data.map { ListItemsModel($0) }
            case .classes:
                let characterClasses: CharacterClasses = try await service.load(endpoint: .characterClasses(page: itemsPage, limit: Constants.API.pageLimit, name: nil))
                newItems = characterClasses.data.map { ListItemsModel($0) }
            }
            
            items.append(contentsOf: newItems)
            itemsPage += 1
            if newItems.count < Constants.API.pageLimit {
                listIsFull = true
            }
            
            applyFilter(type: self.filterType)
        } catch {
            showError(error.localizedDescription)
        }
    }
    
    func showError(_ description: String) {
        errorDescription = description
        isShowError = true
    }
}
