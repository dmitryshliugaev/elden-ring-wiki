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

    case bosses(page: Int, limit: Int, name: String?)
    case boss(id: String)

    case npcs(page: Int, limit: Int, name: String?)
    case npc(id: String)

    case creatures(page: Int, limit: Int, name: String?)
    case creature(id: String)

    case locations(page: Int, limit: Int, name: String?)
    case location(id: String)

    case characterClasses(page: Int, limit: Int, name: String?)
    case characterClass(id: String)

    public func path() -> String {
        switch self {
        case .weapons:
            return "weapons"
        case let .weapon(id):
            return "weapons/\(id)"

        case .ammos:
            return "ammos"
        case let .ammo(id):
            return "ammos/\(id)"

        case .armors:
            return "armors"
        case let .armor(id):
            return "armors/\(id)"

        case .shields:
            return "shields"
        case let .shield(id):
            return "shields/\(id)"

        case .items:
            return "items"
        case let .item(id):
            return "items/\(id)"

        case .talismans:
            return "talismans"
        case let .talisman(id):
            return "talismans/\(id)"

        case .ashes:
            return "ashes"
        case let .ashe(id):
            return "ashes/\(id)"

        case .sorceries:
            return "sorceries"
        case let .sorcery(id):
            return "sorceries/\(id)"

        case .spirits:
            return "spirits"
        case let .spirit(id):
            return "spirits/\(id)"

        case .incantations:
            return "incantations"
        case let .incantation(id):
            return "incantations/\(id)"

        case .bosses:
            return "bosses"
        case let .boss(id):
            return "bosses/\(id)"

        case .npcs:
            return "npcs"
        case let .npc(id):
            return "npcs/\(id)"

        case .creatures:
            return "creatures"
        case let .creature(id):
            return "creatures/\(id)"

        case .locations:
            return "locations"
        case let .location(id):
            return "locations/\(id)"

        case .characterClasses:
            return "classes"
        case let .characterClass(id):
            return "classes/\(id)"
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
             let .incantations(page, limit, name),
             let .bosses(page, limit, name),
             let .npcs(page, limit, name),
             let .creatures(page, limit, name),
             let .locations(page, limit, name),
             let .characterClasses(page, limit, name):
            urlComponents?.queryItems = [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit)),
            ]

            if let name {
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
             .incantation(_),
             .boss(_),
             .npc(_),
             .creature(_),
             .location(_),
             .characterClass:
            break
        }

        print(urlComponents?.url ?? "--")
        if let url = urlComponents?.url {
            var urlRequest = URLRequest(url: url)
            urlRequest.cachePolicy = .returnCacheDataElseLoad
            return urlRequest
        } else {
            preconditionFailure("Could not instantiate URL object with: \(#function)")
        }
    }
}
