//
//  Endpoint.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

public enum Endpoint {
    case weapons(page: Int, limit: Int)
    case weaponsSearch(name: String)
    case weapon(id: String)
    
    public func path() -> String {
        switch self {
        case .weapons(_, _):
            return "weapons"
        case .weaponsSearch(_):
            return "weapons"
        case let .weapon(id):
            return "weapons/\(id)"
        }
    }
    
    public var request: URLRequest {
        var urlComponents = URLComponents(string: Constants.API.baseUrl + path())
        
        switch self {
        case let .weapons(page, limit):
            urlComponents?.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit))
            ]
            
        case let .weaponsSearch(name):
            urlComponents?.queryItems = [URLQueryItem(name: "name", value: name)]
            
        case .weapon(_):
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

