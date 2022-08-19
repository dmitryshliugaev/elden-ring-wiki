//
//  CreatureData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import Foundation

struct CreatureData: ItemMappable, Decodable {
    /// Id of the creature
    let id: String
    /// Name of the creature
    let name: String
    /// Image URL of the creature
    let image: String?
    /// Short description of the creature
    let description: String?
    /// Where this creature can be found
    let location: String?
    /// What items and resources this creature drops
    let drops: [String]
}
