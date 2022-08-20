//
//  ListItemsView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 17/08/2022.
//

import SwiftUI

struct ListItemsView: View {
    @EnvironmentObject private var tabRouter: TabRouter
    @StateObject var viewModel: ListItemsViewModel
    @StateObject private var router = DetailsRouter()
    
    public init(type: ListType) {
        _viewModel = StateObject(wrappedValue: .init(type: type))
    }
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $viewModel.isShowDetailView) {
                router.makeDetailView(viewModel.type,
                                      id: viewModel.itemId)
            } label: {
                EmptyView()
            }

            List {
                ForEach(viewModel.items, id: \.id) { item in
                    Button {
                        // tabRouter.searchItemOnMap(item.name)
                        viewModel.isShowDetailView = true
                        viewModel.itemId = item.id
                    } label: {
                        makeListItem(name: item.name,
                                     urlString: item.imageUrl)
                    }
                    
                    
                }
                
                if !viewModel.listIsFull {
                    ProgressView()
                        .frame(width: Constants.UI.thumbnailsSize,
                               height: Constants.UI.thumbnailsSize,
                               alignment: .center)
                        .task {
                            await viewModel.load()
                        }
                }
            }
            .listStyle(.plain)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(Text(viewModel.type.title))
        }
    }
    
    func makeListItem(name: String, urlString: String?) -> some View {
        return HStack {
            if let urlString = urlString {
                AsyncImage(url: URL(string: urlString)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: Constants.UI.thumbnailsSize, height: Constants.UI.thumbnailsSize)
                .cornerRadius(Constants.UI.thumbnailsSize/2)
            } else {
                Circle()
                    .fill(.gray)
                    .frame(width: Constants.UI.thumbnailsSize, height: Constants.UI.thumbnailsSize)
            }
            
            Text(name)
        }
    }
}

struct ListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemsView(type: .weapons)
    }
}
