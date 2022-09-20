//
//  LocationData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import Foundation

struct LocationData: ItemMappable, Decodable {
    /// Id of the location
    let id: String
    /// Name of the location
    let name: String
    /// Image URL of the location screenshot
    let image: String?
    /// Short description of the location
    let description: String?
}
