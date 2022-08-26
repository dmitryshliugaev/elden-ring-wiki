//
//  ArmorDetailView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 26/08/2022.
//

import SwiftUI

struct ArmorDetailView: View {
    @EnvironmentObject private var router: TabRouter
    @StateObject private var viewModel: ArmorDetailViewModel
    
    public init(id: String) {
        _viewModel = StateObject(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        List {
            if let armorData = viewModel.armorData {
                HStack {
                    Spacer()
                    if let urlString = armorData.image, let url = URL(string: urlString) {
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
                        router.searchItemOnMap(armorData.name)
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
                
                if let description = armorData.description {
                    Section("Description".localizedString) {
                        Text(description)
                    }
                }
                
                if let category = armorData.category {
                    Section("Category".localizedString) {
                        Text(category)
                    }
                }
                
                if let weight = armorData.weight {
                    Section("Weight".localizedString) {
                        Text(String(format: "%g", weight))
                    }
                }
                
                Section {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("DmgNegation".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(armorData.dmgNegation, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Resistance".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(armorData.resistance, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
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
        .navigationTitle(Text(viewModel.armorData?.name ?? "Armor"))
    }
}

struct ArmorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArmorDetailView(id: "")
    }
}
