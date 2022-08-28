//
//  AmmoDetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 28/08/2022.
//

import Foundation

@MainActor
class AmmoDetailViewModel: ObservableObject {
    @Published var ammoData: AmmoData? = nil
    
    private var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    func load() async {
        do {
            let service = Dependencies.shared.networkService
            let ammo: Ammo = try await service.load(endpoint: .ammo(id: id))
            ammoData = ammo.data
        } catch {
            print(error)
        }
    }
}
