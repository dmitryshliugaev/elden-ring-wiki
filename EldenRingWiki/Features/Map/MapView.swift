//
//  MapView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 19/08/2022.
//

import SwiftUI

struct MapView: View {
    @StateObject var webViewModel = WebViewModel()
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            WebViewContainer(webViewModel: webViewModel)
            if webViewModel.isLoading {
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
