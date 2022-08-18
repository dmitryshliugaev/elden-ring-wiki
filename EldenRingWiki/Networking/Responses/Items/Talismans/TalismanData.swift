//
//  TalismanData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct TalismanData: ItemMappable, Decodable {
    /// Id of the talisman
    let id: String
    /// Name of the talisman
    let name: String
    /// Image URL of the talisman
    let image: String?
    /// Short description of the talisman
    let description: String?
    /// What happens when we equip this talisman
    let effect: String?
}
