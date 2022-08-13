//
//  Endpoint.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

public enum Endpoint {
    case weapons(page: Int, limit: Int, name: String?)
    case weapon(id: String)
    
    case ammos(page: Int, limit: Int, name: String?)
    case ammo(id: String)
    
    case armors(page: Int, limit: Int, name: String?)
    case armor(id: String)
    
    case shields(page: Int, limit: Int, name: String?)
    case shield(id: String)
    
    public func path() -> String {
        switch self {
        case .weapons(_, _, _):
            return "weapons"
        case let .weapon(id):
            return "weapons/\(id)"
            
        case .ammos(_, _, _):
            return "ammos"
        case let .ammo(id):
            return "ammos/\(id)"
            
        case .armors(_, _, _):
            return "armors"
        case let .armor(id):
            return "armors/\(id)"
            
        case .shields(_, _, _):
            return "shields"
        case let .shield(id):
            return "shields/\(id)"
        }
    }
    
    public var request: URLRequest {
        var urlComponents = URLComponents(string: Constants.API.baseUrl + path())
        
        switch self {
        case let .weapons(page, limit, name),
            let .ammos(page, limit, name),
            let .armors(page, limit, name),
            let .shields(page, limit, name):
            urlComponents?.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
            
            if let name = name {
                urlComponents?.queryItems?.append(URLQueryItem(name: "name", value: name))
            }
            
        case .weapon(_),
                .ammo(_),
                .armor(_),
                .shield(_):
            break
        }
        print(urlComponents)
        if let url = urlComponents?.url {
            return URLRequest(url: url)
        } else {
            preconditionFailure("Could not instantiate URL object with: \(#function)")
        }
    }
}

