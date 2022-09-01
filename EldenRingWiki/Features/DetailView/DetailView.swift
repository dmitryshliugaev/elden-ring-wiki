//
//  DetailView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 01/09/2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var router: TabRouter
    
    let listItemsModel: ListItemsModel
    
    var body: some View {
        List {
            Group {
                HStack {
                    Spacer()
                    if let urlString = listItemsModel.imageUrl, let url = URL(string: urlString) {
                        CacheAsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                            case .failure(_):
                                Image(systemName: "exclamationmark.icloud")
                            @unknown default:
                                Image(systemName: "exclamationmark.icloud")
                            }
                        }
                        .frame(height: Constants.UI.detailImageSize)
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
                        router.searchItemOnMap(listItemsModel.name)
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
                
                if let description = listItemsModel.description {
                    Section("Description".localizedString) {
                        Text(description)
                    }
                }
            }
            
            Group {
                if let type = listItemsModel.type {
                    Section("Type".localizedString) {
                        Text(type)
                    }
                }
                
                if let passive = listItemsModel.passive {
                    Section("Passive".localizedString) {
                        Text(passive)
                    }
                }
                
                if let category = listItemsModel.category {
                    Section("Category".localizedString) {
                        Text(category)
                    }
                }
                
                if let weight = listItemsModel.weight {
                    Section("Weight".localizedString) {
                        Text(String(format: "%g", weight))
                    }
                }
                
                if let effect = listItemsModel.effect {
                    Section("Effect".localizedString) {
                        Text(effect)
                    }
                }
                
                if let affinity = listItemsModel.affinity {
                    Section("Affinity".localizedString) {
                        Text(affinity)
                    }
                }
                
                if let skill = listItemsModel.skill {
                    Section("Skill".localizedString) {
                        Text(skill)
                    }
                }
                
                if let cost = listItemsModel.cost {
                    Section("Cost".localizedString) {
                        Text(String(format: "%g", cost))
                    }
                }
                
                if let slots = listItemsModel.slots {
                    Section("Slots".localizedString) {
                        Text(String(format: "%g", slots))
                    }
                }
                
                if let effects = listItemsModel.effects {
                    Section("Effects".localizedString) {
                        Text(effects)
                    }
                }
            }
            
            Group {
                if let fpCost = listItemsModel.fpCost {
                    Section("FPCost".localizedString) {
                        Text(fpCost)
                    }
                }
                
                if let hpCost = listItemsModel.hpCost {
                    Section("HPCost".localizedString) {
                        Text(hpCost)
                    }
                }
                
                if let location = listItemsModel.location {
                    Section("Location".localizedString) {
                        Text(location)
                    }
                }
                
                if let quote = listItemsModel.quote {
                    Section("Quote".localizedString) {
                        Text(quote)
                    }
                }
                
                if let role = listItemsModel.role {
                    Section("Role".localizedString) {
                        Text(role)
                    }
                }
                
                if let healthPoints = listItemsModel.healthPoints {
                    Section("HealthPoints".localizedString) {
                        Text(healthPoints)
                    }
                }
                
                if let stats = listItemsModel.stats {
                    Section("Stats".localizedString) {
                        HStack {
                            Text("Stats.level".localizedString)
                            Spacer()
                            Text(stats.level)
                        }
                        HStack {
                            Text("Stats.vigor".localizedString)
                            Spacer()
                            Text(stats.vigor)
                        }
                        HStack {
                            Text("Stats.mind".localizedString)
                            Spacer()
                            Text(stats.mind)
                        }
                        HStack {
                            Text("Stats.endurance".localizedString)
                            Spacer()
                            Text(stats.endurance)
                        }
                        HStack {
                            Text("Stats.strength".localizedString)
                            Spacer()
                            Text(stats.strength)
                        }
                        HStack {
                            Text("Stats.dexterity".localizedString)
                            Spacer()
                            Text(stats.dexterity)
                        }
                        HStack {
                            Text("Stats.intelligence".localizedString)
                            Spacer()
                            Text(stats.intelligence)
                        }
                        HStack {
                            Text("Stats.faith".localizedString)
                            Spacer()
                            Text(stats.faith)
                        }
                        HStack {
                            Text("Stats.arcane".localizedString)
                            Spacer()
                            Text(stats.arcane)
                        }
                        
                    }
                }
            }
            
            if !listItemsModel.drops.isEmpty {
                Section("Drops".localizedString) {
                    ForEach(listItemsModel.drops, id: \.self) { dropName in
                        Text(dropName)
                    }
                }
            }
            
            if !listItemsModel.requires.isEmpty {
                Section("Requires".localizedString) {
                    ForEach(listItemsModel.requires, id: \.name) { require in
                        HStack {
                            Text(require.name)
                            Spacer()
                            Text(String(format: "%g", require.amount ?? 0))
                        }
                    }
                }
            }
            
            
            
            if !listItemsModel.attack.isEmpty,
               !listItemsModel.defence.isEmpty {
                Section {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("Attack".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(listItemsModel.attack, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Defence".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(listItemsModel.defence, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                    }
                }
            }
            
            if !listItemsModel.requiredAttributes.isEmpty,
               !listItemsModel.scalesWith.isEmpty {
                Section {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("RequiredAttributes".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(listItemsModel.requiredAttributes, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("ScalesWith".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(listItemsModel.scalesWith, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(row.scaling ?? "-")
                                }
                            }
                        }
                    }
                }
            }
            
            if !listItemsModel.attackPower.isEmpty {
                Section("AttackPower".localizedString) {
                    ForEach(listItemsModel.attackPower, id: \.name) { row in
                        HStack {
                            Text(row.name)
                            Spacer()
                            Text(String(format: "%g", row.amount ?? 0))
                        }
                    }
                }
            }
            
            
            if !listItemsModel.dmgNegation.isEmpty,
               !listItemsModel.resistance.isEmpty {
                Section {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading) {
                            Text("DmgNegation".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(listItemsModel.dmgNegation, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Resistance".localizedString)
                                .font(.headline)
                            Spacer().frame(height: 8)
                            ForEach(listItemsModel.resistance, id: \.name) { row in
                                HStack {
                                    Text(row.name)
                                    Spacer()
                                    Text(String(format: "%g", row.amount ?? 0))
                                }
                            }
                        }
                    }
                }
            }
            
        }
        .foregroundColor(.white)
        .navigationTitle(Text(listItemsModel.name))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(listItemsModel: ListItemsModel(
            LocationData(id: "",
                         name: "",
                         image: nil,
                         description: nil)))
    }
}
