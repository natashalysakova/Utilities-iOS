//
//  UtilitiesApp.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import SwiftUI

@main
struct UtilitiesApp: App {
    
    @State private var model = UtilityDataModel()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            MainView(model: $model){
                Task{
                    do {
                        try await UtilityDataModel.save(model: model)
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                    }
                }
            }
            .onAppear(){
                model = UtilityDataModel.load2()
                model.validate()
            }
            .preferredColorScheme(.dark)
            .task {
                do {
                   
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
