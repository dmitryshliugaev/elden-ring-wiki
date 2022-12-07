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
        GeometryReader { geometry in
            VStack {
                Spacer()

                VStack {
                    Text("\(viewModel.deathCount)")
                        .font(Font.custom("Mantinia", fixedSize: 40))
                        .foregroundColor(.DSRed)

                    Text("YouDied".localizedString)
                        .font(Font.custom("Mantinia", fixedSize: 36))
                        .foregroundColor(.DSRed)
                }
                .padding()
                .frame(width: geometry.size.width)
                .background {
                    Color.black
                        .blur(radius: 20)
                }

                Spacer()

                Button(action: {
                    viewModel.deathCount += 1
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: Constants.UI.buttonSmall, height: Constants.UI.buttonSmall)
                }
                .frame(width: Constants.UI.buttonMedium, height: Constants.UI.buttonMedium)
                .background(.gray.opacity(0.5))
                .cornerRadius(Constants.UI.buttonMedium / 2)

                Spacer()
                    .frame(height: Constants.UI.Padding.large * 2)
            }
            .background(Image("eldenringlogo"))
        }
    }
}

struct DeathCountView_Previews: PreviewProvider {
    static var previews: some View {
        DeathCountView()
    }
}
