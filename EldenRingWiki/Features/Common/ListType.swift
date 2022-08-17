//
//  ListType.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import SwiftUI

enum ListType: Int, Identifiable, CaseIterable {
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
        ListItemsView(type: self)
    }
    
//    func getListEndpoint(page: Int, limit: Int, name: String?) -> Endpoint {
//        switch self {
//        case .weapons:
//            return .weapons(page: page, limit: limit, name: name)
//        case .armors:
//            return .armors(page: page, limit: limit, name: name)
//        case .shields:
//            return .shields(page: page, limit: limit, name: name)
//        case .ammos:
//            return .ammos(page: page, limit: limit, name: name)
//
//            //TODO
//        case .items:
//            return .weapons(page: page, limit: limit, name: name)
//        case .talismans:
//            return .weapons(page: page, limit: limit, name: name)
//        case .sorcery:
//            return .weapons(page: page, limit: limit, name: name)
//        case .spirits:
//            return .weapons(page: page, limit: limit, name: name)
//        case .incantations:
//            return .weapons(page: page, limit: limit, name: name)
//        case .ashes:
//            return .weapons(page: page, limit: limit, name: name)
//        case .bosses:
//            return .weapons(page: page, limit: limit, name: name)
//        case .npcs:
//            return .weapons(page: page, limit: limit, name: name)
//        case .creatures:
//            return .weapons(page: page, limit: limit, name: name)
//        case .locations:
//            return .weapons(page: page, limit: limit, name: name)
//        case .classes:
//            return .weapons(page: page, limit: limit, name: name)
//        }
//    }
//
//    func getDetailsEndpoint(id: String) -> Endpoint {
//        switch self {
//        case .weapons:
//            return .weapon(id: id)
//        case .armors:
//            return .armor(id: id)
//        case .shields:
//            return .shield(id: id)
//        case .ammos:
//            return .ammo(id: id)
//
//            //TODO
//        case .items:
//            return .weapon(id: id)
//        case .talismans:
//            return .weapon(id: id)
//        case .sorcery:
//            return .weapon(id: id)
//        case .spirits:
//            return .weapon(id: id)
//        case .incantations:
//            return .weapon(id: id)
//        case .ashes:
//            return .weapon(id: id)
//        case .bosses:
//            return .weapon(id: id)
//        case .npcs:
//            return .weapon(id: id)
//        case .creatures:
//            return .weapon(id: id)
//        case .locations:
//            return .weapon(id: id)
//        case .classes:
//            return .weapon(id: id)
//        }
//    }
}
