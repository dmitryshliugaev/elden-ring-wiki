//
//  ItemDetailView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 31/08/2022.
//

import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject private var router: TabRouter
    @StateObject private var viewModel: ItemDetailViewModel
    
    public init(id: String) {
        _viewModel = StateObject(wrappedValue: .init(id: id))
    }
    
    var body: some View {
        List {
            if let itemData = viewModel.itemData {
                HStack {
                    Spacer()
                    if let urlString = itemData.image, let url = URL(string: urlString) {
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
                        router.searchItemOnMap(itemData.name)
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
                
                if let description = itemData.description {
                    Section("Description".localizedString) {
                        Text(description)
                    }
                }
                
                if let type = itemData.type {
                    Section("Type".localizedString) {
                        Text(type)
                    }
                }
                
                if let effect = itemData.effect {
                    Section("Effect".localizedString) {
                        Text(effect)
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
        .navigationTitle(Text(viewModel.itemData?.name ?? "Item"))
    }
}

struct ItemsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(id: "")
    }
}
