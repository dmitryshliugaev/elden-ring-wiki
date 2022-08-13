//
//  Shields.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 13/08/2022.
//

import Foundation

struct Shields: Decodable {
    let success: Bool
    let count: Int
    let total: Int
    let data: [ShieldData]
}
