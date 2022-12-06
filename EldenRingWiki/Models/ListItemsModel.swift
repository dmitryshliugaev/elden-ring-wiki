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
    var scalesWith: [ScalesWith] = []
    var attackPower: [AttackPower] = []
    var dmgNegation: [DmgNegation] = []
    var resistance: [Resistance] = []

    init(_ response: AmmoData) {
        listType = .ammos
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        type = response.type
        passive = response.passive
        attackPower = response.attackPower
    }

    init(_ response: ShieldData) {
        listType = .shields
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        category = response.category
        weight = response.weight
        attack = response.attack
        defence = response.defence
        requiredAttributes = response.requiredAttributes
        scalesWith = response.scalesWith
    }

    init(_ response: ArmorData) {
        listType = .armors
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        category = response.category
        weight = response.weight
        dmgNegation = response.dmgNegation
        resistance = response.resistance
    }

    init(_ response: WeaponData) {
        listType = .weapons
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        category = response.category
        weight = response.weight
        attack = response.attack
        defence = response.defence
        requiredAttributes = response.requiredAttributes
        scalesWith = response.scalesWith
    }

    init(_ response: TalismanData) {
        listType = .talismans
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        effect = response.effect
    }

    init(_ response: ItemData) {
        listType = .items
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        type = response.type
        effect = response.effect
    }

    init(_ response: AsheData) {
        listType = .ashes
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        affinity = response.affinity
        skill = response.skill
    }

    init(_ response: IncantationData) {
        listType = .incantations
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        type = response.type
        cost = response.cost
        slots = response.slots
        effects = response.effects
        requires = response.requires ?? []
    }

    init(_ response: SpiritData) {
        listType = .spirits
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        fpCost = response.fpCost
        hpCost = response.hpCost
        effects = response.effects
    }

    init(_ response: SorceryData) {
        listType = .sorceries
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        type = response.type
        cost = response.cost
        slots = response.slots
        effects = response.effects
        requires = response.requires ?? []
    }

    init(_ response: LocationData) {
        listType = .locations
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
    }

    init(_ response: CreatureData) {
        listType = .creatures
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        location = response.location
        drops = response.drops ?? []
    }

    init(_ response: NPCData) {
        listType = .npcs
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        location = response.location
        quote = response.quote
        role = response.role
    }

    init(_ response: BossData) {
        listType = .bosses
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        location = response.location
        drops = response.drops
        healthPoints = response.healthPoints
    }

    init(_ response: CharacterClassData) {
        listType = .classes
        id = response.id
        name = response.name
        imageUrl = response.image
        description = response.description
        stats = response.stats
    }
}
