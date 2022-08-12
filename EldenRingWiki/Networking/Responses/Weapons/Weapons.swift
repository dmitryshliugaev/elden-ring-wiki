//
//  Weapons.swift
//  
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

struct Weapons: Decodable {
    let success: Bool
    let count: Int
    let total: Int
    let data: [WeaponsData]
}
