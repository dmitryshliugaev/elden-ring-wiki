//
//  DetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 06/09/2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    private let repository: RepositoryProtocol
    
    let listItemsModel: ListItemsModel
    
    init(listItemsModel: ListItemsModel,
         repository: RepositoryProtocol) {
        self.listItemsModel = listItemsModel
        self.repository = repository
    }
    
    func mark() {
        do {
            try repository.markItem(id: listItemsModel.id)
        } catch {
            print(error)
        }
    }
    
    func isMarked() -> Bool {
        return repository.isItemMarked(id: listItemsModel.id)
    }
}
