//
//  UtilitySectionVew.swift
//  Utilities
//
//  Created by Natalya Lysakova on 06.06.2022.
//

import SwiftUI

struct UtilitySectionVew: View {
    @Binding var dataModel : UtilityDataModel
    
    @State var filteredUtilities : [Utility] = []
    @State var utilityType : UtilityType
    
    @Binding var newUtilityPresented : Bool
    @Binding var newUtilityType : UtilityType
    
//    init() {
//
//    }
    
    var body: some View {
        
        Section(header:
                    HStack {
            Image(systemName: utilityType.icon).foregroundColor(utilityType.color)
            Text(utilityType.localizedName)
            Spacer()
            Button {
                newUtilityType = utilityType
                newUtilityPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }.font(.callout)
        ){
            ForEach ($filteredUtilities) { $utility in
                NavigationLink(destination: UtilityDetailsView(utility: $utility, model: dataModel)) {
                    Text(utility.name)
                }
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button() {
                        //#warning("TODO: implement")
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    .tint(.green)
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        //#warning("TODO: implement")
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
            }
        }
        .onAppear {
            filteredUtilities = dataModel.filteredUtilities(type: utilityType)
        }
        
    }
}

struct UtilitySectionVew_Previews: PreviewProvider {
    static var previews: some View {
        UtilitySectionVew(dataModel: .constant(UtilityDataModel.sampleData), utilityType: .Other, newUtilityPresented: .constant(false), newUtilityType: .constant(.Other))
    }
}
