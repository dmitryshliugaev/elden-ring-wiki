//
//  CatalogStruct.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

enum CatalogStruct: Int, Identifiable, CaseIterable {
    case equipment, items, magic, world, classes
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .equipment:
            return "Equipment".localizedString
        case .items:
            return "Items".localizedString
        case .magic:
            return "Magic".localizedString
        case .world:
            return "World".localizedString
        case .classes:
            return "Classes".localizedString
        }
    }
    
    var iconName: String {
        switch self {
        case .equipment:
            return "shield.righthalf.filled"
        case .items:
            return "latch.2.case"
        case .magic:
            return "wand.and.stars"
        case .world:
            return "globe"
        case .classes:
            return "person.3.sequence"
        }
    }
    
    var items: [ListType] {
        switch self {
        case .equipment:
            return [
                ListType.weapons,
                ListType.armors,
                ListType.shields,
                ListType.ammos,
            ]
        case .items:
            return [
                ListType.items,
                ListType.talismans,
            ]
        case .magic:
            return [
                ListType.sorceries,
                ListType.spirits,
                ListType.incantations,
                ListType.ashes,
            ]
        case .world:
            return [
                ListType.bosses,
                ListType.npcs,
                ListType.creatures,
                ListType.locations,
            ]
        case .classes:
            return [
                ListType.classes,
            ]
        }
    }
}

