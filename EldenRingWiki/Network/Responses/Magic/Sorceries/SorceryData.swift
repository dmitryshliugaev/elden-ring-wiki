//
//  SorceryData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct SorceryData: ItemMappable, Decodable {
    /// Id of the sorcery
    let id: String
    /// Name of the sorcery
    let name: String
    /// Image URL of the sorcery icon
    let image: String?
    /// Short description of the sorcery
    let description: String?
    /// Type of Incantation
    let type: String?
    /// Cost in FP to cast this sorcery once
    let cost: Double?
    /// How many skill slots equipping this sorcery consumes
    let slots: Double?
    /// Skill activated when this Ash of War is equipped in a weapon
    let effects: String?
    /// What attributes and what amount is required to cast this sorcery
    let requires: [Requires]?
}
