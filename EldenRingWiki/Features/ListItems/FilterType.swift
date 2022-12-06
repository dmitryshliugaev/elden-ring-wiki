//
//  FilterType.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 10/09/2022.
//

import Foundation

enum FilterType: Int, Identifiable, CaseIterable {
    case all
    case checked
    case unchecked

    var id: Int {
        rawValue
    }

    var title: String {
        switch self {
        case .all:
            return "All".localizedString
        case .checked:
            return "Checked".localizedString
        case .unchecked:
            return "Unchecked".localizedString
        }
    }
}
