//
//  AmmoDetailView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 28/08/2022.
//

import SwiftUI

struct AmmoDetailView: View {
    @EnvironmentObject private var router: TabRouter
    @StateObject private var viewModel: AmmoDetailViewModel
    
    public init(id: String) {
        _viewModel = StateObject(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        List {
            if let ammoData = viewModel.ammoData {
                HStack {
                    Spacer()
                    if let urlString = ammoData.image, let url = URL(string: urlString) {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .scaledToFit()
                            case .failure(_):
                                Image(systemName: "exclamationmark.icloud")
                            @unknown default:
                                Image(systemName: "exclamationmark.icloud")
                            }
                        }
                        .frame(width: Constants.UI.detailImageSize,
                               height: Constants.UI.detailImageSize)
                    } else {
                        Image(systemName: "exclamationmark.icloud")
                            .frame(width: Constants.UI.detailImageSize,
                                   height: Constants.UI.detailImageSize)
                    }
                    Spacer()
                }
                .listRowBackground(Color.black)
                
                Section {
                    Button {
                        router.searchItemOnMap(ammoData.name)
                    } label: {
                        HStack {
                            Spacer()
                            Image(systemName: "mappin.circle")
                            Text("ShowOnMap".localizedString)
                            Spacer()
                        }
                        .foregroundColor(Color.eldenLight)
                    }
                }
                
                if let description = ammoData.description {
                    Section("Description".localizedString) {
                        Text(description)
                    }
                }
                
                if let type = ammoData.type {
                    Section("Type".localizedString) {
                        Text(type)
                    }
                }
                
                if let passive = ammoData.passive {
                    Section("Passive".localizedString) {
                        Text(passive)
                    }
                }
                
                Section("AttackPower".localizedString) {
                    ForEach(ammoData.attackPower, id: \.name) { row in
                        HStack {
                            Text(row.name)
                            Spacer()
                            Text(String(format: "%g", row.amount ?? 0))
                        }
                    }
                }
                
            } else {
                Text("Loading...")
            }
        }
        .task {
            await viewModel.load()
        }
        .foregroundColor(.white)
        .navigationTitle(Text(viewModel.ammoData?.name ?? "Ammo"))
    }
}

struct AmmoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AmmoDetailView(id: "")
    }
}
