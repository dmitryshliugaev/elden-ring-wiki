//
//  WeaponDetailView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 22/08/2022.
//

import SwiftUI

struct WeaponDetailView: View {
    @EnvironmentObject private var router: TabRouter
    @StateObject private var viewModel: WeaponDetailViewModel
    
    public init(id: String) {
        _viewModel = StateObject(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        List {
            if let weaponData = viewModel.weaponData {
                HStack {
                    Spacer()
                    if let urlString = weaponData.image, let url = URL(string: urlString) {
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
                        router.searchItemOnMap(weaponData.name)
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
                
                if let description = weaponData.description {
                    Section("Description".localizedString) {
                        Text(description)
                    }
                }
                
                if let category = weaponData.category {
                    Section("Category".localizedString) {
                        Text(category)
                    }
                }
                
                if let weight = weaponData.weight {
                    Section("Weight".localizedString) {
                        Text(String(format: "%g", weight))
                    }
                }
                
                Section {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Attack".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(weaponData.attack, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Defence".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(weaponData.defence, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                    }
                }
                
                Section {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("RequiredAttributes".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(weaponData.requiredAttributes, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("ScalesWith".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(weaponData.scalesWith, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(row.scaling ?? "-")
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
        .navigationTitle(Text(viewModel.weaponData?.name ?? "Weapon"))
    }
}

struct WeaponDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeaponDetailView(id: "")
    }
}