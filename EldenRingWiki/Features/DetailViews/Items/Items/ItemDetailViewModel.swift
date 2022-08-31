//
//  ItemDetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 31/08/2022.
//

import Foundation

@MainActor
class ItemDetailViewModel: ObservableObject {
    @Published var itemData: ItemData? = nil
    
    private var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    func load() async {
        do {
            let service = Dependencies.shared.networkService
            let item: Item = try await service.load(endpoint: .item(id: id))
            itemData = item.data
        } catch {
            print(error)
        }
    }
}
