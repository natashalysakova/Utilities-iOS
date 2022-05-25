//
//  UtilitiesApp.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import SwiftUI

@main
struct UtilitiesApp: App {
    @StateObject private var store = UtilityStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            MainView(model: $store.model){
                Task{
                    do {
                        try await UtilityStore.save(model: store.model)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            
            .task {
                do {
                    store.model = try await UtilityStore.load()
                    store.model.validate()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                //store.model.checks = Check.sampleData
                //store.model.tariffs = Tariff.sampleData
                //store.model.utilities = Utility.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
        }
    }
}

enum MainVews : Int {
    case checks = 0
    case tarifs = 1
    case utilities = 2
}
