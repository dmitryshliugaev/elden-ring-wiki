//
//  TabRouter.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

enum Tab: Int, CaseIterable, Identifiable {
    case catalog
    case map
    case deathCount

    var id: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .catalog:
            return "Catalog".localizedString
        case .map:
            return "Map".localizedString
        case .deathCount:
            return "DeathCount".localizedString
        }
    }

    var iconName: String {
        switch self {
        case .catalog:
            return "books.vertical"
        case .map:
            return "globe.europe.africa"
        case .deathCount:
            return "heart.slash.fill"
        }
    }

    @ViewBuilder
    var contentView: some View {
        switch self {
        case .catalog:
            CatalogView()
        case .map:
            MapView()
        case .deathCount:
            DeathCountView()
        }
    }
}

class TabRouter: ObservableObject {
    @Published var activeTab: Tab = .catalog
    @Published var searchItem: String = ""

    func open(_ tab: Tab) {
        activeTab = tab
    }

    func searchItemOnMap(_ itemName: String) {
        searchItem = itemName
        open(.map)
    }
}
