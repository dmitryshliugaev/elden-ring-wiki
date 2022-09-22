//
//  DetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 06/09/2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var isMark: Bool
    @Published var isShowError = false
    
    private let repository: RepositoryProtocol
    
    let listItemsModel: ListItemsModel
    
    var errorDescription: String = ""
    
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
            showError(error.localizedDescription)
        }
    }
    
    func unmark() {
        do {
            try repository.unmarkItem(id: listItemsModel.id)
            isMark = false
        } catch {
            showError(error.localizedDescription)
        }
    }
    
    func showError(_ description: String) {
        errorDescription = description
        isShowError = true
    }
}
