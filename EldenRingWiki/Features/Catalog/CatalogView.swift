//
//  CatalogView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel = CatalogViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $viewModel.isShowDetailView) {
                    if let selectedItem = viewModel.selectedItem {
                        DetailView(listItemsModel: selectedItem)
                    }
                } label: { EmptyView() }
                
                List {
                    switch viewModel.state {
                    case .catalog:
                        catalogStateView
                    case let .searchData(items):
                        makeSearchResultsList(items: items)
                    case .error:
                        errorView
                    }
                }
                .searchable(text: $viewModel.searchText,
                            placement: .navigationBarDrawer(displayMode: .always),
                            prompt: "Search.Prompt".localizedString)
                .navigationTitle(Text("Catalog"))
                .listStyle(.insetGrouped)
            }
        }
    }
    
    private var catalogStateView: some View {
        ForEach(CatalogStruct.allCases) { catalogSection in
            Section(header: sectionView(title: catalogSection.title,
                                        iconName: catalogSection.iconName)) {
                ForEach(catalogSection.items) { item in
                    NavigationLink(item.title) { item.contentView }
                }
            }
        }
    }
    
    func makeSearchResultsList(items: [ListItemsModel]) -> some View {
        ForEach(items, id: \.id) { item in
            Button {
                viewModel.isShowDetailView = true
                viewModel.selectedItem = item
            } label: {
                HStack {
                    if let urlString = item.imageUrl, let url = URL(string: urlString) {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                            case .failure(_):
                                Image(systemName: "exclamationmark.icloud")
                            @unknown default:
                                Image(systemName: "exclamationmark.icloud")
                            }
                        }
                        .frame(width: Constants.UI.thumbnailsSize,
                               height: Constants.UI.thumbnailsSize)
                        .cornerRadius(Constants.UI.thumbnailsSize/2)
                    } else {
                        Image(systemName: "exclamationmark.icloud")
                            .frame(width: Constants.UI.thumbnailsSize,
                                   height: Constants.UI.thumbnailsSize)
                    }
                    
                    Text(item.name)
                }
            }
        }
    }
    
    private func sectionView(title: String, iconName: String) -> some View {
        return HStack {
            Image(systemName: iconName)
            Text(title)
        }
        .foregroundColor(.white)
    }
    
    private var errorView: some View {
        Text("Error...")
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
