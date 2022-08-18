//
//  SpiritData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct SpiritData: ItemMappable, Decodable {
    /// Id of the spirit
    let id: String
    /// Name of the spirit
    let name: String
    /// Image URL of the spirit icon
    let image: String?
    /// Short description of the spirit
    let description: String?
    /// Cost in FP to summon this spirit once
    let fpCost: String?
    /// Cost in HP to summon this spirit once
    let hpCost: String?
    /// What happens when we summon this spirit
    let effects: String?
}
