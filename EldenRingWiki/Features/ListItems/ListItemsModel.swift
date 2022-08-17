//
//  ListItemsModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Foundation

protocol ListItemMappable {
    var id: String { get }
    var name: String { get }
    var image: String? { get }
    var description: String? { get }
}

struct ListItemsModel {
    let id: String
    let name: String
    let imageUrl: String?
    let description: String?
    
    init(response: ListItemMappable) {
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
    }
}
