//
//  ArmorDetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 26/08/2022.
//

import Foundation

@MainActor
class ArmorDetailViewModel: ObservableObject {
    @Published var armorData: ArmorData? = nil
    
    private var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    func load() async {
        do {
            let service = Dependencies.shared.networkService
            let armor: Armor = try await service.load(endpoint: .armor(id: id))
            armorData = armor.data
        } catch {
            print(error)
        }
    }
}
