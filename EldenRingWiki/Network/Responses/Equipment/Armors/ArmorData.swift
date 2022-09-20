//
//  ArmorData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 13/08/2022.
//

import Foundation

struct ArmorData: ItemMappable, Decodable {
    /// Id of the armor piece
    let id: String
    /// Name of the armor piece
    let name: String
    /// Image URL of the armor piece
    let image: String?
    /// Short description of the armor piece
    let description: String?
    /// Category of the armor piece
    let category: String?
    /// How much this armor piece weights in your invetory
    let weight: Double?
    /// How much damage this armor piece negates
    let dmgNegation: [DmgNegation]
    /// How much resistance wearing this armor piece provides.
    let resistance: [Resistance]
}
