//
//  EldenRingWikiApp.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 11/08/2022.
//

import SwiftUI

@main
struct EldenRingWikiApp: App {
    init() {
        setupAppearance()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(.dark)
        }
    }

    private func setupAppearance() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.eldenLight)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.eldenLight)]
        UINavigationBar.appearance().barTintColor = UIColor(.skyDark)
    }
}
