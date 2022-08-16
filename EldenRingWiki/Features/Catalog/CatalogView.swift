//
//  CatalogView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

struct CatalogView: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(CatalogStruct.allCases) { catalogSection in
                    Section(header: sectionView(title: catalogSection.title,
                                                iconName: catalogSection.iconName)) {
                        ForEach(catalogSection.items) { item in
                            NavigationLink(item.title) { item.contentView }
                        }
                    }
                }
            }
            .navigationTitle(Text("Catalog"))
        }
        
    }
    
    func sectionView(title: String, iconName: String) -> some View {
        return HStack {
            Image(systemName: iconName)
            Text(title)
        }
        .foregroundColor(.black)
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
