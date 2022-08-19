//
//  RootView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 14/08/2022.
//

import SwiftUI

struct RootView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        TabView(selection: $router.activeTab) {
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
        .environmentObject(router)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
