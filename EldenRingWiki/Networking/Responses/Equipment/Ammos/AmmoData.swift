//
//  AmmoData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 13/08/2022.
//

import Foundation

struct AmmoData: ItemMappable, Decodable {
    /// Id of the ammo item
    let id: String
    /// Name of the ammo item
    let name: String
    /// Image URL of the ammo item
    let image: String?
    /// Short description of the ammo item
    let description: String?
    /// Damage type of the ammo item
    let type: String?
    /// Passive effect caused by the ammo item. Example: Bleed, Poison, etc.
    let passive: String?
    /// How much damage the the projectile does in each category of damage.
    let attackPower: [AttackPower]
}
