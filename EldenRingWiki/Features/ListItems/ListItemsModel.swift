//
//  ListItemsModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Foundation

struct ListItemsModel {
    let id: String
    let name: String
    let imageUrl: String?
    let description: String?
    
    init(weapon: WeaponsData) {
        self.id = weapon.id
        self.name = weapon.name
        self.imageUrl = weapon.image
        self.description = weapon.description
    }
    
    init(armor: ArmorData) {
        self.id = armor.id
        self.name = armor.name
        self.imageUrl = armor.image
        self.description = armor.description
    }
    
    init(shield: ShieldData) {
        self.id = shield.id
        self.name = shield.name
        self.imageUrl = shield.image
        self.description = shield.description
    }
    
    init(ammo: AmmoData) {
        self.id = ammo.id
        self.name = ammo.name
        self.imageUrl = ammo.image
        self.description = ammo.description
    }
}
