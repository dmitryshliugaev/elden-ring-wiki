//
//  ListItemsView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import SwiftUI

struct ListItemsView: View {
    @StateObject var viewModel: ListItemsViewModel

    public init(type: ListType) {
        _viewModel = StateObject(wrappedValue: .init(type: type,
                                                     repository: Dependencies.shared.markRepository))
    }

    var body: some View {
        VStack {
            Picker(viewModel.filterType.title, selection: $viewModel.filterType) {
                ForEach(FilterType.allCases, id: \.self) {
                    Text($0.title).tag($0)
                }
            }.pickerStyle(.segmented)

            List {
                ForEach(viewModel.filteredItems, id: \.id) { item in
                    Button {
                        viewModel.showDetailView(with: item)
                    } label: {
                        makeListItem(id: item.id,
                                     name: item.name,
                                     urlString: item.imageUrl)
                    }
                }

                if !viewModel.listIsFull,
                   !viewModel.filteredItems.isEmpty,
                   viewModel.filterType == .all
                {
                    HStack(alignment: .center) {
                        Spacer()
                        ProgressView()
                            .frame(width: Constants.UI.thumbnailsSize,
                                   height: Constants.UI.thumbnailsSize,
                                   alignment: .center)
                            .task {
                                await viewModel.load()
                            }
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text(viewModel.type.title))
            .background(
                NavigationLink(isActive: $viewModel.isShowDetailView) {
                    if let selectedItem = viewModel.selectedItem {
                        DetailView(listItemsModel: selectedItem)
                    }
                } label: { EmptyView() }
            )
            .task {
                viewModel.getMarkedList()
                viewModel.applyFilter(type: viewModel.filterType)
                await viewModel.load()
            }
            .alert(viewModel.errorDescription, isPresented: $viewModel.isShowError) {
                Button("TryAgain".localizedString) {
                    Task {
                        await viewModel.load()
                    }
                }

                Button("Cancel".localizedString) {}
            }
        }
    }

    func makeListItem(id: String, name: String, urlString: String?) -> some View {
        HStack {
            if let urlString, let url = URL(string: urlString) {
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

            Text(name)

            Spacer()

            if viewModel.markedList.contains(id) {
                Image(systemName: "checkmark.square")
            }
        }
    }
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(type: .weapons)
    }
}
