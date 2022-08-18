//
//  ItemMappable.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 18/08/2022.
//

import Foundation

protocol ItemMappable {
    var id: String { get }
    var name: String { get }
    var image: String? { get }
    var description: String? { get }
}
