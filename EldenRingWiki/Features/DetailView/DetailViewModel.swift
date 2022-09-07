//
//  DetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 06/09/2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var isMark: Bool
    
    private let repository: RepositoryProtocol
    
    let listItemsModel: ListItemsModel
    
    init(listItemsModel: ListItemsModel,
         repository: RepositoryProtocol) {
        self.listItemsModel = listItemsModel
        self.repository = repository
        self.isMark = repository.isItemMarked(id: listItemsModel.id)
    }
    
    func mark() {
        do {
            try repository.markItem(id: listItemsModel.id)
            isMark = true
        } catch {
            print(error)
        }
    }
    
    func unmark() {
        do {
            try repository.unmarkItem(id: listItemsModel.id)
            isMark = false
        } catch {
            print(error)
        }
    }
}
