//
//  ShieldData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 13/08/2022.
//

import Foundation

struct ShieldData: ItemMappable, Decodable {
    /// Id of the Shield
    let id: String
    /// Name of the Shield
    let name: String
    /// Image URL of the Shield
    let image: String?
    /// Short description of the Shield
    let description: String?
    /// What category of shield. Example: Small Shield, Medium Shield, etc.
    let category: String?
    /// How much the Shield weights when equipped
    let weight: Double?
    /// How much damage the Shield does when used as a weapon
    let attack: [Attack]
    /// How much damage the Shield blocks when used as a shield
    let defence: [Defence]
    /// What are the required attribute amount in order to properly use this shield.
    let requiredAttributes: [RequiredAttributes]
    /// How much the shield scales and with what attributes.
    let scalesWith: [ScalesWith]
}
