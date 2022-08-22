//
//  Constants.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import SwiftUI

struct Constants {
    struct API {
        /// Base URL https://eldenring.fanapis.com/api/
        static let baseUrl = "https://eldenring.fanapis.com/api/"
        /// Page limit 30
        static let pageLimit = 30
        /// Map URL
        static let mapUrl = "https://mapgenie.io/elden-ring/maps/the-lands-between"
    }
    
    struct UI {
        /// 50
        static let thumbnailsSize: CGFloat = 50
        
        /// 200
        static let detailImageSize: CGFloat = 200
    }
}
