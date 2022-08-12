//
//  HTTPURLResponse+.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
