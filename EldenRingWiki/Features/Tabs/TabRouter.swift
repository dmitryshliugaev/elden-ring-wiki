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
    case settings
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .catalog:
            return "Catalog".localizedString
        case .map:
            return "Map".localizedString
        case .settings:
            return "Settings".localizedString
        }
    }
    
    var iconName: String {
        switch self {
        case .catalog:
            return "books.vertical"
        case .map:
            return "globe.europe.africa"
        case .settings:
            return "gear"
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .catalog:
            CatalogView()
        case .map:
            MapView()
        case .settings:
            SettingsView()
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
