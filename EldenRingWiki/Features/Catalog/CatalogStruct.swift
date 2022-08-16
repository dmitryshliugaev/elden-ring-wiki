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
    
    var items: [CatalogSubItem] {
        switch self {
        case .equipment:
            return [
                CatalogSubItem.weapons,
                CatalogSubItem.armors,
                CatalogSubItem.shields,
                CatalogSubItem.ammos,
            ]
        case .items:
            return [
                CatalogSubItem.items,
                CatalogSubItem.talismans,
            ]
        case .magic:
            return [
                CatalogSubItem.sorcery,
                CatalogSubItem.spirits,
                CatalogSubItem.incantations,
                CatalogSubItem.ashes,
            ]
        case .world:
            return [
                CatalogSubItem.bosses,
                CatalogSubItem.npcs,
                CatalogSubItem.creatures,
                CatalogSubItem.locations,
            ]
        case .classes:
            return [
                CatalogSubItem.classes,
            ]
        }
    }
}

enum CatalogSubItem: Int, Identifiable, CaseIterable {
    case weapons, armors, shields, ammos, items, talismans, sorcery, spirits, incantations, ashes, bosses, npcs, creatures, locations, classes
    
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
        case .items:
            return "Items".localizedString
        case .talismans:
            return "Talismans".localizedString
        case .sorcery:
            return "Sorcery".localizedString
        case .spirits:
            return "Spirits".localizedString
        case .incantations:
            return "Incantations".localizedString
        case .ashes:
            return "Ashes".localizedString
        case .bosses:
            return "Bosses".localizedString
        case .npcs:
            return "NPCs".localizedString
        case .creatures:
            return "Creatures".localizedString
        case .locations:
            return "Locations".localizedString
        case .classes:
            return "Classes".localizedString
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .weapons:
            ContentView()
        case .armors:
            ContentView()
        case .shields:
            ContentView()
        case .ammos:
            ContentView()
        case .items:
            ContentView()
        case .talismans:
            ContentView()
        case .sorcery:
            ContentView()
        case .spirits:
            ContentView()
        case .incantations:
            ContentView()
        case .ashes:
            ContentView()
        case .bosses:
            ContentView()
        case .npcs:
            ContentView()
        case .creatures:
            ContentView()
        case .locations:
            ContentView()
        case .classes:
            ContentView()
        }
    }
}
