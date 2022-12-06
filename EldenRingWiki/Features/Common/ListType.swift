//
//  ListType.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import SwiftUI

enum ListType: Int, Identifiable, CaseIterable {
    case weapons, armors, shields, ammos, items, talismans, sorceries, spirits, incantations, ashes, bosses, npcs, creatures, locations, classes

    var id: Int {
        rawValue
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
        case .sorceries:
            return "Sorceries".localizedString
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
        ListItemsView(type: self)
    }
}
