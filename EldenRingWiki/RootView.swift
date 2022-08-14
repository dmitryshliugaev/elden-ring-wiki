//
//  RootView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 14/08/2022.
//

import SwiftUI

enum Tab: Int, CaseIterable, Identifiable{
    case catalog
    case map
    case other
    
    var id: Int {
        self.rawValue
    }
    
    var title: String {
        switch self {
        case .catalog:
            return "Catalog".localizedString
        case .map:
            return "Map".localizedString
        case .other:
            return "Other".localizedString
        }
    }
    
    var iconName: String {
        switch self {
        case .catalog:
            return "books.vertical"
        case .map:
            return "globe.europe.africa"
        case .other:
            return "circle.and.line.horizontal"
        }
    }
    
    @ViewBuilder
    var contentView: some View {
        switch self {
        case .catalog:
            ContentView()
        case .map:
            Color.brown
        case .other:
            Color.cyan
        }
    }
}

class TabController: ObservableObject {
    @Published var activeTab: Tab = .catalog
    
    func open(_ tab: Tab) {
        activeTab = tab
    }
}

struct RootView: View {
    @StateObject private var tabController = TabController()
    
    var body: some View {
        TabView(selection: $tabController.activeTab) {
            ForEach(Tab.allCases) { tab in
                tab.contentView
                    .tabItem {
                        Label {
                            Text(tab.title)
                        } icon: {
                            Image(systemName: tab.iconName)
                        }
                    }
                    .tag(tab)
            }
        }
        .environmentObject(tabController)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
