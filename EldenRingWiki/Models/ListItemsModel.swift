//
//  ListItemsModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Foundation

struct ListItemsModel {
    var listType: ListType
    var id: String
    var name: String
    var imageUrl: String?
    var description: String?
    var type: String?
    var passive: String?
    var category: String?
    var weight: Double?
    var effect: String?
    var affinity: String?
    var skill: String?
    var cost: Double?
    var slots: Double?
    var effects: String?
    var fpCost: String?
    var hpCost: String?
    var location: String?
    var quote: String?
    var role: String?
    var healthPoints: String?
    var stats: ClassStats?
    var drops: [String] = []
    var requires: [Requires] = []
    var attack: [Attack] = []
    var defence: [Defence] = []
    var requiredAttributes: [RequiredAttributes] = []
    var scalesWith : [ScalesWith] = []
    var attackPower: [AttackPower] = []
    var dmgNegation: [DmgNegation] = []
    var resistance: [Resistance] = []
    
    init(_ response: AmmoData) {
        self.listType = .ammos
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.type = response.type
        self.passive = response.passive
        self.attackPower = response.attackPower
    }
    
    init(_ response: ShieldData) {
        self.listType = .shields
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.category = response.category
        self.weight = response.weight
        self.attack = response.attack
        self.defence = response.defence
        self.requiredAttributes = response.requiredAttributes
        self.scalesWith = response.scalesWith
    }
    
    init(_ response: ArmorData) {
        self.listType = .armors
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.category = response.category
        self.weight = response.weight
        self.dmgNegation = response.dmgNegation
        self.resistance = response.resistance
    }
    
    init(_ response: WeaponData) {
        self.listType = .weapons
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.category = response.category
        self.weight = response.weight
        self.attack = response.attack
        self.defence = response.defence
        self.requiredAttributes = response.requiredAttributes
        self.scalesWith = response.scalesWith
    }
    
    init(_ response: TalismanData) {
        self.listType = .talismans
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.effect = response.effect
    }
    
    init(_ response: ItemData) {
        self.listType = .items
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.type = response.type
        self.effect = response.effect
    }
    
    init(_ response: AsheData) {
        self.listType = .ashes
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.affinity = response.affinity
        self.skill = response.skill
    }
    
    init(_ response: IncantationData) {
        self.listType = .incantations
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.type = response.type
        self.cost = response.cost
        self.slots = response.slots
        self.effects = response.effects
        self.requires = response.requires
    }
    
    init(_ response: SpiritData) {
        self.listType = .spirits
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.fpCost = response.fpCost
        self.hpCost = response.hpCost
        self.effects = response.effects
    }
    
    init(_ response: SorceryData) {
        self.listType = .sorceries
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.type = response.type
        self.cost = response.cost
        self.slots = response.slots
        self.effects = response.effects
        self.requires = response.requires
    }
    
    init(_ response: LocationData) {
        self.listType = .locations
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
    }
    
    init(_ response: CreatureData) {
        self.listType = .creatures
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.location = response.location
        self.drops = response.drops ?? []
    }
    
    init(_ response: NPCData) {
        self.listType = .npcs
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.location = response.location
        self.quote = response.quote
        self.role = response.role
    }
    
    init(_ response: BossData) {
        self.listType = .bosses
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.location = response.location
        self.drops = response.drops
        self.healthPoints = response.healthPoints
    }
    
    init(_ response: CharacterClassData) {
        self.listType = .classes
        self.id = response.id
        self.name = response.name
        self.imageUrl = response.image
        self.description = response.description
        self.stats = response.stats
    }
}
