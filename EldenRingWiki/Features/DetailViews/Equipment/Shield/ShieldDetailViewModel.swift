//
//  ShieldDetailViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 27/08/2022.
//

import Foundation

@MainActor
class ShieldDetailViewModel: ObservableObject {
    @Published var shieldData: ShieldData? = nil
    
    private var id: String
    
    public init(id: String) {
        self.id = id
    }
    
    func load() async {
        do {
            let service = Dependencies.shared.networkService
            let shield: Shield = try await service.load(endpoint: .shield(id: id))
            shieldData = shield.data
        } catch {
            print(error)
        }
    }
}
