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
    
    case items(page: Int, limit: Int, name: String?)
    case item(id: String)
    
    case talismans(page: Int, limit: Int, name: String?)
    case talisman(id: String)
    
    case ashes(page: Int, limit: Int, name: String?)
    case ashe(id: String)
    
    case sorceries(page: Int, limit: Int, name: String?)
    case sorcery(id: String)
    
    case spirits(page: Int, limit: Int, name: String?)
    case spirit(id: String)
    
    case incantations(page: Int, limit: Int, name: String?)
    case incantation(id: String)
    
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
            
        case .items(_, _, _):
            return "items"
        case let .item(id):
            return "items/\(id)"
            
        case .talismans(_, _, _):
            return "talismans"
        case let .talisman(id):
            return "talismans/\(id)"
            
        case .ashes(_, _, _):
            return "ashes"
        case let .ashe(id):
            return "ashes/\(id)"
            
        case .sorceries(_, _, _):
            return "sorceries"
        case let .sorcery(id):
            return "sorceries/\(id)"
            
        case .spirits(_, _, _):
            return "spirits"
        case let .spirit(id):
            return "spirits/\(id)"
            
        case .incantations(_, _, _):
            return "incantations"
        case let .incantation(id):
            return "incantations/\(id)"
        }
    }
    
    public var request: URLRequest {
        var urlComponents = URLComponents(string: Constants.API.baseUrl + path())
        
        switch self {
        case let .weapons(page, limit, name),
            let .ammos(page, limit, name),
            let .armors(page, limit, name),
            let .shields(page, limit, name),
            let .items(page, limit, name),
            let .talismans(page, limit, name),
            let .ashes(page, limit, name),
            let .sorceries(page, limit, name),
            let .spirits(page, limit, name),
            let .incantations(page, limit, name):
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
                .shield(_),
                .item(_),
                .talisman(_),
                .ashe(_),
                .sorcery(_),
                .spirit(_),
                .incantation(_):
            break
        }
        
        // TODO: - Remove print
        print(urlComponents ?? "Empty URL Components")
        if let url = urlComponents?.url {
            return URLRequest(url: url)
        } else {
            preconditionFailure("Could not instantiate URL object with: \(#function)")
        }
    }
}

