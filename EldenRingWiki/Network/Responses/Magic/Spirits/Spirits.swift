//
//  Spirits.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct Spirits: Decodable {
    let success: Bool
    let count: Int
    let total: Int
    let data: [SpiritData]
}
