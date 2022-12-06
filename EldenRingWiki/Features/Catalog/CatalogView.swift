//
//  CatalogView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel: CatalogViewModel

    public init() {
        _viewModel = StateObject(wrappedValue: .init(repository: Dependencies.shared.markRepository))
    }

    var body: some View {
        NavigationView {
            List {
                switch viewModel.state {
                case .catalog:
                    catalogStateView
                case let .searchData(items):
                    makeSearchResultsList(items: items)
                case let .error(description):
                    errorView(description)
                case .loading:
                    loadingView
                }
            }
            .searchable(text: $viewModel.searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "Search.Prompt".localizedString)
            .navigationTitle(Text("Catalog".localizedString))
            .listStyle(.insetGrouped)
            .background(
                NavigationLink(isActive: $viewModel.isShowDetailView) {
                    if let selectedItem = viewModel.selectedItem {
                        DetailView(listItemsModel: selectedItem)
                    }
                } label: { EmptyView() }
            )
        }
        .navigationViewStyle(.stack)
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

    @ViewBuilder
    func makeSearchResultsList(items: [ListItemsModel]) -> some View {
        if items.isEmpty {
            HStack {
                Spacer()
                Text("No results")
                Spacer()
            }
            .listRowBackground(Color.black)
        } else {
            ForEach(items, id: \.id) { item in
                Button {
                    viewModel.showDetailView(with: item)
                } label: {
                    HStack {
                        if let urlString = item.imageUrl, let url = URL(string: urlString) {
                            CacheAsyncImage(url: url) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case let .success(image):
                                    image.resizable()
                                case .failure:
                                    Image(systemName: "exclamationmark.icloud")
                                @unknown default:
                                    Image(systemName: "exclamationmark.icloud")
                                }
                            }
                            .frame(width: Constants.UI.thumbnailsSize,
                                   height: Constants.UI.thumbnailsSize)
                            .cornerRadius(Constants.UI.thumbnailsSize / 2)
                        } else {
                            Image(systemName: "exclamationmark.icloud")
                                .frame(width: Constants.UI.thumbnailsSize,
                                       height: Constants.UI.thumbnailsSize)
                        }

                        Text(item.name)

                        Spacer()

                        if viewModel.markedList.contains(item.id) {
                            Image(systemName: "checkmark.square")
                        }
                    }
                }
            }
            .task {
                viewModel.getMarkedList()
            }
        }
    }

    private func sectionView(title: String, iconName: String) -> some View {
        HStack {
            Image(systemName: iconName)
            Text(title)
        }
        .foregroundColor(.white)
    }

    private func errorView(_ description: String) -> some View {
        HStack {
            Spacer()
            Image(systemName: "exclamationmark.triangle")
            Text(description)
            Spacer()
        }
        .listRowBackground(Color.black)
    }

    private var loadingView: some View {
        HStack {
            Spacer()
            Text("Loading...")
            Spacer()
        }
        .listRowBackground(Color.black)
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
