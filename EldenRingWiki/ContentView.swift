//
//  ContentView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 11/08/2022.
//

import SwiftUI

let networkService = NetworkService()

struct ContentView: View {
    @State var weapons: [WeaponsData] = []
    
    var body: some View {
        List(weapons, id: \.id) { weapon in
            Text(weapon.name)
        }
        .task {
            await load()
        }
        .refreshable {
            await load()
        }
    }
    
    func load() async {
        do {
            let weapons: Weapons = try await networkService.load(endpoint: .weapons(page: 1, limit: 10))
            self.weapons = weapons.data
        } catch {
            if let error = error as? NetworkError {
                print(error.errorDescription ?? "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
