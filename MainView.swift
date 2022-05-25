//
//  MainView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 23.05.2022.
//

import SwiftUI

struct MainView: View {
    @Binding public var model : UtilityDataModel
    
    @State private var selection = 0
    @State private var isDetailViewActive = false
    let saveAction: ()->Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    //
    var handler: Binding<Int> { Binding(
        get: {self.selection },
        set: {
//            if $0 == self.selection
//            {                  }
            self.selection = $0
        }
    )
    }
    
    
    var body: some View {
        
        TabView (selection: handler ) {
            NavigationView {
                ChecksView(checks: $model.checks).navigationTitle(String(localized: "checks"))
            }
            .tabItem {
                Image(systemName: "list.dash")
                Text("checks")
            }
            .tag(0)
            
//            NavigationView {
//                TarifsView(tarifs: $model.tariffs).navigationTitle(String(localized: "tarifs"))
//            }.tabItem {
//                Image(systemName: "banknote")
//                Text("tarifs")
//            }.tag(1)
            
            NavigationView {
                UtilitiesView(utilities: $model.utilities, tarifs: $model.tariffs)
                    .navigationTitle(String(localized: "utilities"))
            }.tabItem {
                Image(systemName: "hammer")
                Text("utilities")
            }.tag(1)
        }
        .navigationViewStyle(.stack)
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }}
        
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(model: .constant(UtilityDataModel.sampleData), saveAction: {}).previewLayout(.device)
    }
}
