//
//  Creature.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import Foundation

struct Creature: Decodable {
    let success: Bool
    let data: CreatureData
}
