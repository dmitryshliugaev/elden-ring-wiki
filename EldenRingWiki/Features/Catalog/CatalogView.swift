//
//  CatalogView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 15/08/2022.
//

import SwiftUI

struct CatalogView: View {
    var body: some View {
        List {
            ForEach(CatalogStruct.allCases) { catalogItem in
                Section(header: sectionView(title: catalogItem.title,
                                            iconName: catalogItem.iconName)) {
                    ForEach(sectionItemsTitles(catalogItem: catalogItem), id: \.self) { title in
                        Button {
                            print(title)
                        } label: {
                            Text(title)
                        }
                        .accentColor(.black)
                    }
                }
            }
        }
    }
    
    func sectionView(title: String, iconName: String) -> some View {
        return HStack {
            Image(systemName: iconName)
            Text(title)
        }
        .foregroundColor(.black)
        
    }
    
    func sectionItemsTitles(catalogItem: CatalogStruct) -> [String] {
        switch catalogItem {
        case .equipment:
            return EquipmentGroup.allCases.map { $0.title }
        case .items:
            return ItemsGroup.allCases.map { $0.title }
        case .magic:
            return MagicGroup.allCases.map { $0.title }
        case .world:
            return WorldGroup.allCases.map { $0.title }
        case .classes:
            return ClassesGroup.allCases.map { $0.title }
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
