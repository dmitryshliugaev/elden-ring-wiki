//
//  WeaponsData.swift
//  
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

struct WeaponsData: ListItemMappable, Decodable {
    /// Id of the Weapon
    let id: String
    /// Name of the Weapon
    let name: String
    /// Image URL of the Weapon
    let image: String?
    /// Short description of the Weapon
    let description: String?
    /// What category of Weapons. Example: Axe, Sword, etc.
    let category: String?
    /// How much the Weapon weights when equipped
    let weight: Double?
    /// How much damage the Weapon does when used as a weapon
    let attack: [Attack]
    /// How much damage the Weapon blocks when used to defend an attack
    let defence: [Defence]
    /// What are the required attribute amount in order to properly use this Weapon.
    let requiredAttributes: [RequiredAttributes]
    /// How much the Weapon scales and with what attributes.
    let scalesWith : [ScalesWith]
}
