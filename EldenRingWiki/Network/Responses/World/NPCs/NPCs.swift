//
//  NPCs.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import Foundation

struct NPCs: Decodable {
    let success: Bool
    let count: Int
    let total: Int
    let data: [NPCData]
}
