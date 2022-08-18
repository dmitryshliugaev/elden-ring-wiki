//
//  AsheData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct AsheData: ItemMappable, Decodable {
    /// Id of the ash of war item
    let id: String
    /// Name of the ash of war item
    let name: String
    /// Image URL of the ash of war item
    let image: String?
    /// Short description of the ash of war item
    let description: String?
    /// Affinity of an Ash of War
    let affinity: String?
    /// Skill activated when this Ash of War is equipped in a weapon
    let skill: String?
}
