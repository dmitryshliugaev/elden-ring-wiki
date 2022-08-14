//
//  ContentView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 11/08/2022.
//

import SwiftUI

let networkService: NetworkServiceProtocol = NetworkService()

@MainActor
class ContentModel: ObservableObject {
    @Published var weapons: [WeaponsData] = []
    @Published var armors: [ArmorData] = []
    @Published var shields: [ShieldData] = []
    @Published var ammos: [AmmoData] = []
    
    var weaponsPage = 0
    var weaponsIsFull = false
    
    var armorsPage = 0
    var armorsIsFull = false
    
    var shieldsPage = 0
    var shieldsIsFull = false
    
    var ammosPage = 0
    var ammosIsFull = false
    
    var limit = 30
    
    func loadWeapons() async {
        do {
            let weapons: Weapons = try await networkService.load(endpoint: .weapons(page: weaponsPage, limit: limit, name: nil))
            self.weapons.append(contentsOf: weapons.data)
            self.weaponsPage += 1
            if weapons.data.count < limit {
                self.weaponsIsFull = true
            }
        } catch {
            if let error = error as? NetworkError {
                print(error.errorDescription ?? "")
            }
        }
    }
    
    func loadArmors() async {
        do {
            let armors: Armors = try await networkService.load(endpoint: .armors(page: 0, limit: 100, name: nil))
            self.armors.append(contentsOf: armors.data)
            self.armorsPage += 1
            if armors.data.count < limit {
                self.armorsIsFull = true
            }
        } catch {
            if let error = error as? NetworkError {
                print(error.errorDescription ?? "")
            }
        }
    }
    
    func loadShields() async {
        do {
            let shields: Shields = try await networkService.load(endpoint: .shields(page: 0, limit: 100, name: nil))
            self.shields.append(contentsOf: shields.data)
            self.shieldsPage += 1
            if shields.data.count < limit {
                self.shieldsIsFull = true
            }
        } catch {
            if let error = error as? NetworkError {
                print(error.errorDescription ?? "")
            }
        }
    }
    
    func loadAmmos() async {
        do {
            let ammos: Ammos = try await networkService.load(endpoint: .ammos(page: 0, limit: 100, name: nil))
            self.ammos.append(contentsOf: ammos.data)
            self.ammosPage += 1
            if ammos.data.count < limit {
                self.ammosIsFull = true
            }
        } catch {
            if let error = error as? NetworkError {
                print(error.errorDescription ?? "")
            }
        }
    }
}

struct ContentView: View {
    @EnvironmentObject private var tabController: TabController
    @StateObject var model = ContentModel()
    
    var body: some View {
        List {
            Button {
                tabController.open(.map)
            } label: {
                Text("Open map")
            }
            
            Button {
                tabController.open(.other)
            } label: {
                Text("Open other")
            }
            
            ForEach(model.weapons, id: \.id) { weapon in
                makeListItem(name: weapon.name, urlString: weapon.image)
            }
            
            if !model.weaponsIsFull {
                ProgressView()
                    .frame(width: 50, height: 50, alignment: .center)
                    .task {
                        await model.loadWeapons()
                    }
            }
        }
    }
    
    func makeListItem(name: String, urlString: String?) -> some View {
        return HStack {
            if let urlString = urlString {
                AsyncImage(url: URL(string: urlString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 50, height: 50)
            } else {
                Circle()
                    .fill(.gray)
                    .frame(width: 50, height: 50)
            }
            
            Text(name)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
