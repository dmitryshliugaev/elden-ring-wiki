//
//  DeathCountViewModel.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 02/12/2022.
//

import Combine
import Foundation

class DeathCountViewModel: ObservableObject {
    private let repository: DeathRepositoryProtocol
    private var cancellable: AnyCancellable?
    
    @Published var deathCount: Int
    
    init(repository: DeathRepositoryProtocol) {
        self.repository = repository
        deathCount = repository.getDeathCount()
        
        cancellable = $deathCount
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.global(qos: .background))
            .sink { count in
                repository.saveDeathCount(count)
            }
    }
}
