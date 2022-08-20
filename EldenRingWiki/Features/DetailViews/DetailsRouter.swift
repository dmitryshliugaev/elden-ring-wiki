//
//  DetailsRouter.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 20/08/2022.
//

import SwiftUI

class DetailsRouter: ObservableObject {
    @ViewBuilder
    func makeDetailView(_ type: ListType, id: String) -> some View {
        Text("Item: \(id)")
    }
}
