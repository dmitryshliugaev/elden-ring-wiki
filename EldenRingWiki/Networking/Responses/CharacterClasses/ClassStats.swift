//
//  ClassStats.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct ClassStats: Decodable {
    let level: String
    let vigor: String
    let mind: String
    let endurance: String
    let strength: String
    let dexterity: String
    let intelligence: String
    let faith: String
    let arcane: String
}
