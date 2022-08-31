//
//  DetailsRouter.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 20/08/2022.
//

import SwiftUI

class DetailsRouter: ObservableObject {
    @ViewBuilder
    func showDetailView(_ type: ListType, id: String) -> some View {
        switch type {
        case .weapons:
            WeaponDetailView(id: id)
        case .armors:
            ArmorDetailView(id: id)
        case .shields:
            ShieldDetailView(id: id)
        case .ammos:
            AmmoDetailView(id: id)
        case .items:
            ItemDetailView(id: id)
        default:
            Text("Item: \(id)")
        }
    }
}
