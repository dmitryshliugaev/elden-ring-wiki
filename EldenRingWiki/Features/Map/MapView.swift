//
//  MapView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import SwiftUI

struct MapView: View {
    @EnvironmentObject private var router: TabRouter
    @StateObject var webViewModel = WebViewModel()

    var body: some View {
        ZStack {
            WebViewContainer(webViewModel: webViewModel)
            if webViewModel.isLoading {
                Color.black

                ProgressView()
                    .frame(width: Constants.UI.thumbnailsSize,
                           height: Constants.UI.thumbnailsSize,
                           alignment: .center)
            }
        }
        .onAppear {
            webViewModel.searchByName(router.searchItem)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
