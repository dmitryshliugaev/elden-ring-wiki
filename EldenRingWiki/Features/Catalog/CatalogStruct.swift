//
//  CatalogStruct.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

protocol CatalogProtocol:  Identifiable, CaseIterable {
    var id: Int { get }
    var title: String { get }
}

enum CatalogStruct: Int, CatalogProtocol {
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
}

enum EquipmentGroup: Int, CatalogProtocol {
    case weapons, armors, shields, ammos
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .weapons:
            return "Weapons".localizedString
        case .armors:
            return "Armors".localizedString
        case .shields:
            return "Shields".localizedString
        case .ammos:
            return "Ammos".localizedString
        }
    }
}

enum ItemsGroup: Int, CatalogProtocol  {
    case items, talismans
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .items:
            return "Items".localizedString
        case .talismans:
            return "Talismans".localizedString
        }
    }
}

enum MagicGroup: Int, CatalogProtocol {
    case sorcery, spirits, incantations, ashes
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .sorcery:
            return "Sorcery".localizedString
        case .spirits:
            return "Spirits".localizedString
        case .incantations:
            return "Incantations".localizedString
        case .ashes:
            return "Ashes".localizedString
        }
    }
}

enum WorldGroup: Int, CatalogProtocol {
    case bosses, npcs, creatures, locations
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .bosses:
            return "Bosses".localizedString
        case .npcs:
            return "NPCs".localizedString
        case .creatures:
            return "Creatures".localizedString
        case .locations:
            return "Locations".localizedString
        }
    }
}

enum ClassesGroup: Int, CatalogProtocol {
    case classes
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .classes:
            return "Classes".localizedString
        }
    }
}
