//
//  NPCData.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import Foundation

struct NPCData: ItemMappable, Decodable {
    /// Id of the NPC
    let id: String
    /// Name of the NPC
    let name: String
    /// Image of the NPC
    let image: String?
    /// Short description of the NPC
    let description: String?
    /// Where is the NPC located
    let location: String?
    /// Iconic quote from that NPC
    let quote: String?
    /// NPC role
    let role: String?
}
