//
//  Item.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

struct Item: Decodable {
    let success: Bool
    let data: ItemData
}
