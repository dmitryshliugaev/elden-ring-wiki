//
//  DeathCountViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 02/12/2022.
//

import Combine

class DeathCountViewModel: ObservableObject {
    private let repository: DeathRepositoryProtocol
    
    @Published var deathCount: Int
    
    init(repository: DeathRepositoryProtocol) {
        self.repository = repository
        deathCount = repository.getDeathCount()
    }
}
