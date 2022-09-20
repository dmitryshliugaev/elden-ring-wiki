//
//  ItemData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct ItemData: ItemMappable, Decodable {
    /// Id of the item
    let id: String
    /// Name of the item
    let name: String
    /// Image URL of the item
    let image: String?
    /// Short description of the item
    let description: String?
    /// Type of item
    let type: String?
    /// What the item does when given, consumed or used to upgrade things
    let effect: String?
}
