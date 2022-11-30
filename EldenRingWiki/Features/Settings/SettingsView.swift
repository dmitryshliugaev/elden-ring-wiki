//
//  SettingsView.swift
//  EldenRingWiki
//
//  Created by Ekaterina Bulavina on 20.09.2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel = SettingsViewModel()
    
    var body: some View {
        Text("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
