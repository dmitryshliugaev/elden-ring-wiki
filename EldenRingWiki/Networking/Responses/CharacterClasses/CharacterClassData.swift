//
//  CharacterClassData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct CharacterClassData: ItemMappable, Decodable {
    /// Id of the class
    let id: String
    /// Name of the class
    let name: String
    /// Image URL of the class character using the initial equipment provided
    let image: String?
    /// Short description of the class
    let description: String?
    /// Initial stats of the class
    let stats: ClassStats
}
