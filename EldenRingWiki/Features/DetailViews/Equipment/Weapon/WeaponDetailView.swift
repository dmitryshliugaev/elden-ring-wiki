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
                
                Section("Attack".localizedString) {
                    ForEach(weaponData.attack, id: \.name) { row in
                        HStack {
                            Text(row.name)
                            Text(String(format: "%g", row.amount ?? 0))
                        }
                    }
                }
                
                Section("Defence".localizedString) {
                    ForEach(weaponData.defence, id: \.name) { row in
                        HStack {
                            Text(row.name)
                            Text(String(format: "%g", row.amount ?? 0))
                        }
                    }
                }
                
                Section("RequiredAttributes".localizedString) {
                    ForEach(weaponData.requiredAttributes, id: \.name) { row in
                        HStack {
                            Text(row.name)
                            Text(String(format: "%g", row.amount ?? 0))
                        }
                    }
                }
                
                Section("ScalesWith".localizedString) {
                    ForEach(weaponData.scalesWith, id: \.name) { row in
                        HStack {
                            Text(row.name)
                            Text(row.scaling ?? "-")
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
