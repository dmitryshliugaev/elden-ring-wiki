//
//  DeathCountView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 02/12/2022.
//

import SwiftUI

struct DeathCountView: View {
    @StateObject var viewModel: DeathCountViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: .init(repository: Dependencies.shared.deathRepository))
    }
    var body: some View {
        VStack {
            Spacer()
            Text("\(viewModel.deathCount)")
                .font(.title)
            Spacer()
            Button(action: {
                viewModel.deathCount += 1
            }) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: Constants.UI.buttonSmall, height: Constants.UI.buttonSmall)
                    .cornerRadius(Constants.UI.buttonSmall / 2)
            }
            Spacer()
                .frame(height: Constants.UI.Padding.large * 2)
        }
    }
}

struct DeathCountView_Previews: PreviewProvider {
    static var previews: some View {
        DeathCountView()
    }
}
