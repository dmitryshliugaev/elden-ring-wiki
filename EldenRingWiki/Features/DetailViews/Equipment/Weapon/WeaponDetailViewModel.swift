//
//  WeaponDetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 22/08/2022.
//

import Foundation

@MainActor
class WeaponDetailViewModel: ObservableObject {
    @Published var weaponData: WeaponData? = nil
    
    private var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    func load() async {
        do {
            let service = Dependencies.shared.networkService
            let weapon: Weapon = try await service.load(endpoint: .weapon(id: id))
            weaponData = weapon.data
        } catch {
            print(error)
        }
    }
}
