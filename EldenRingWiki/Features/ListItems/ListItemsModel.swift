//
//  ListItemsModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Foundation

struct ListItemsModel {
    let id: String
    let name: String
    let imageUrl: String?
    let description: String?
    
    init(response: ItemMappable) {
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
    }
}
