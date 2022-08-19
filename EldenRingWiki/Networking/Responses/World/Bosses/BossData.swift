//
//  BossData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import Foundation

struct BossData: ItemMappable, Decodable {
    /// Id of the boss
    let id: String
    /// Name of the boss
    let name: String
    /// Image of the boss
    let image: String?
    /// Short description of the boss
    let description: String?
    /// Where is the boss located
    let location: String?
    /// List of items and spoils this boss drops
    let drops: [String]
    /// How much HP this boss has
    let healthPoints: String?
}
