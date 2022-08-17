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
        NetworkService()
    }()
}
