//
//  IncantationData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct IncantationData: ItemMappable, Decodable {
    /// Id of the incantation
    let id: String
    /// Name of the incantation
    let name: String
    /// Image URL of the incantation icon
    let image: String?
    /// Short description of the incantation
    let description: String?
    /// Type of Incantation
    let type: String?
    /// Cost in FP to cast this incantation once
    let cost: Double?
    /// How many skill slots equipping this incantation consumes
    let slots: Double?
    /// Skill activated when this Ash of War is equipped in a weapon
    let effects: String?
    /// What attributes and what amount is required to cast this incantation
    let requires: [Requires]
}
