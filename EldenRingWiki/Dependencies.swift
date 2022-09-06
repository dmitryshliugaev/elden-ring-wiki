//
//  Dependencies.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import Foundation

class Dependencies {
    public static let shared = Dependencies()
    
    private init() {}
    
    public lazy var networkService: NetworkServiceProtocol = {
        let cache = URLCache(memoryCapacity: 10_000_000, diskCapacity: 1_000_000_000)
        URLSession.shared.configuration.urlCache = cache
        URLSession.shared.configuration.requestCachePolicy = .useProtocolCachePolicy
        
        return NetworkService()
    }()
    
    public lazy var imageCache: ImageCache = {
        ImageCache()
    }()
    
    public lazy var repository: RepositoryProtocol = {
        Repository()
    }()
}
