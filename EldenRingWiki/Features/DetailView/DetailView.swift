//
//  DetailView.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 01/09/2022.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject private var router: TabRouter
    @StateObject var viewModel: DetailViewModel

    init(listItemsModel: ListItemsModel) {
        _viewModel = StateObject(wrappedValue: .init(listItemsModel: listItemsModel,
                                                     repository: Dependencies.shared.markRepository))
    }

    var body: some View {
        List {
            mainInfo

            groupOne

            groupTwo

            stats

            drops

            requires

            attackAndDefence

            requiredAttributesAndScalesWith

            attackPower

            dmgNegationAndResistance
        }
        .foregroundColor(.white)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(Text(viewModel.listItemsModel.name))
        .alert(viewModel.errorDescription, isPresented: $viewModel.isShowError) {
            Button("OK", role: .cancel) {}
        }
    }

    @ViewBuilder
    var mainInfo: some View {
        Group {
            HStack {
                Spacer()
                if let urlString = viewModel.listItemsModel.imageUrl, let url = URL(string: urlString) {
                    CacheAsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case let .success(image):
                            image
                                .resizable()
                                .scaledToFit()
                        case .failure:
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
                if viewModel.listItemsModel.listType != .classes {
                    Button {
                        router.searchItemOnMap(viewModel.listItemsModel.name)
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

                markItem
            }

            if let description = viewModel.listItemsModel.description {
                Section("Description".localizedString) {
                    Text(description)
                }
            }
        }
    }

    @ViewBuilder
    var groupOne: some View {
        Group {
            if let type = viewModel.listItemsModel.type {
                Section("Type".localizedString) {
                    Text(type)
                }
            }

            if let passive = viewModel.listItemsModel.passive {
                Section("Passive".localizedString) {
                    Text(passive)
                }
            }

            if let category = viewModel.listItemsModel.category {
                Section("Category".localizedString) {
                    Text(category)
                }
            }

            if let weight = viewModel.listItemsModel.weight {
                Section("Weight".localizedString) {
                    Text(String(format: "%g", weight))
                }
            }

            if let effect = viewModel.listItemsModel.effect {
                Section("Effect".localizedString) {
                    Text(effect)
                }
            }

            if let affinity = viewModel.listItemsModel.affinity {
                Section("Affinity".localizedString) {
                    Text(affinity)
                }
            }

            if let skill = viewModel.listItemsModel.skill {
                Section("Skill".localizedString) {
                    Text(skill)
                }
            }

            if let cost = viewModel.listItemsModel.cost {
                Section("Cost".localizedString) {
                    Text(String(format: "%g", cost))
                }
            }

            if let slots = viewModel.listItemsModel.slots {
                Section("Slots".localizedString) {
                    Text(String(format: "%g", slots))
                }
            }

            if let effects = viewModel.listItemsModel.effects {
                Section("Effects".localizedString) {
                    Text(effects)
                }
            }
        }
    }

    @ViewBuilder
    var groupTwo: some View {
        Group {
            if let fpCost = viewModel.listItemsModel.fpCost {
                Section("FPCost".localizedString) {
                    Text(fpCost)
                }
            }

            if let hpCost = viewModel.listItemsModel.hpCost {
                Section("HPCost".localizedString) {
                    Text(hpCost)
                }
            }

            if let location = viewModel.listItemsModel.location {
                Section("Location".localizedString) {
                    Text(location)
                }
            }

            if let quote = viewModel.listItemsModel.quote {
                Section("Quote".localizedString) {
                    Text(quote)
                }
            }

            if let role = viewModel.listItemsModel.role {
                Section("Role".localizedString) {
                    Text(role)
                }
            }

            if let healthPoints = viewModel.listItemsModel.healthPoints {
                Section("HealthPoints".localizedString) {
                    Text(healthPoints)
                }
            }
        }
    }

    @ViewBuilder
    var stats: some View {
        if let stats = viewModel.listItemsModel.stats {
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

    @ViewBuilder
    var drops: some View {
        if !viewModel.listItemsModel.drops.isEmpty {
            Section("Drops".localizedString) {
                ForEach(viewModel.listItemsModel.drops, id: \.self) { dropName in
                    Text(dropName)
                }
            }
        }
    }

    @ViewBuilder
    var requires: some View {
        if !viewModel.listItemsModel.requires.isEmpty {
            Section("Requires".localizedString) {
                ForEach(viewModel.listItemsModel.requires, id: \.name) { require in
                    HStack {
                        Text(require.name)
                        Spacer()
                        Text(String(format: "%g", require.amount ?? 0))
                    }
                }
            }
        }
    }

    @ViewBuilder
    var attackAndDefence: some View {
        if !viewModel.listItemsModel.attack.isEmpty,
           !viewModel.listItemsModel.defence.isEmpty
        {
            Section {
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.listItemsModel.attack, id: \.name) { row in
                            HStack {
                                Text(row.name)
                                Spacer()
                                Text(String(format: "%g", row.amount ?? 0))
                            }

                            if viewModel.listItemsModel.attack.last?.name != row.name {
                                Divider()
                            }
                        }
                    }

                    VStack(alignment: .leading) {
                        ForEach(viewModel.listItemsModel.defence, id: \.name) { row in
                            HStack {
                                Text(row.name)
                                Spacer()
                                Text(String(format: "%g", row.amount ?? 0))
                            }

                            if viewModel.listItemsModel.defence.last?.name != row.name {
                                Divider()
                            }
                        }
                    }
                }
            } header: {
                HStack {
                    Text("Attack".localizedString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)

                    Text("Defence".localizedString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                }
            }
        }
    }

    @ViewBuilder
    var requiredAttributesAndScalesWith: some View {
        if !viewModel.listItemsModel.requiredAttributes.isEmpty,
           !viewModel.listItemsModel.scalesWith.isEmpty
        {
            Section {
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.listItemsModel.requiredAttributes, id: \.name) { row in
                            HStack {
                                Text(row.name)
                                Spacer()
                                Text(String(format: "%g", row.amount ?? 0))
                            }

                            if viewModel.listItemsModel.requiredAttributes.last?.name != row.name {
                                Divider()
                            }
                        }
                    }

                    VStack(alignment: .leading) {
                        ForEach(viewModel.listItemsModel.scalesWith, id: \.name) { row in
                            HStack {
                                Text(row.name)
                                Spacer()
                                Text(row.scaling ?? "-")
                            }

                            if viewModel.listItemsModel.scalesWith.last?.name != row.name {
                                Divider()
                            }
                        }
                    }
                }
            } header: {
                HStack {
                    Text("RequiredAttributes".localizedString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)

                    Text("ScalesWith".localizedString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                }
            }
        }
    }

    @ViewBuilder
    var attackPower: some View {
        if !viewModel.listItemsModel.attackPower.isEmpty {
            Section("AttackPower".localizedString) {
                ForEach(viewModel.listItemsModel.attackPower, id: \.name) { row in
                    HStack {
                        Text(row.name)
                        Spacer()
                        Text(String(format: "%g", row.amount ?? 0))
                    }
                }
            }
        }
    }

    @ViewBuilder
    var dmgNegationAndResistance: some View {
        if !viewModel.listItemsModel.dmgNegation.isEmpty,
           !viewModel.listItemsModel.resistance.isEmpty
        {
            Section {
                HStack(alignment: .top, spacing: 20) {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.listItemsModel.dmgNegation, id: \.name) { row in
                            HStack {
                                Text(row.name)
                                Spacer()
                                Text(String(format: "%g", row.amount ?? 0))
                            }

                            if viewModel.listItemsModel.dmgNegation.last?.name != row.name {
                                Divider()
                            }
                        }
                    }

                    VStack(alignment: .leading) {
                        ForEach(viewModel.listItemsModel.resistance, id: \.name) { row in
                            HStack {
                                Text(row.name)
                                Spacer()
                                Text(String(format: "%g", row.amount ?? 0))
                            }

                            if viewModel.listItemsModel.resistance.last?.name != row.name {
                                Divider()
                            }
                        }
                    }
                }
            } header: {
                HStack {
                    Text("DmgNegation".localizedString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)

                    Text("Resistance".localizedString)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(1)
                }
            }
        }
    }

    @ViewBuilder
    var markItem: some View {
        if viewModel.isMark {
            VStack {
                Button {
                    viewModel.unmark()
                } label: {
                    HStack {
                        Spacer()
                        Image(systemName: "checkmark.square")
                        Text("MarkUnchecked".localizedString)
                        Spacer()
                    }
                    .foregroundColor(Color.eldenLight)
                }
            }
        } else {
            Button {
                viewModel.mark()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "square")
                    Text("MarkChecked".localizedString)
                    Spacer()
                }
                .foregroundColor(Color.eldenLight)
            }
        }
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
