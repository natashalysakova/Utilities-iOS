//
//  UtilitySection.swift
//  Utilities
//
//  Created by Natalya Lysakova on 25.05.2022.
//

import SwiftUI

struct UtilitySectionView: View {
    var utilities : [Utility]
    var tarifs : [Tariff]
    
    @Binding public var newUtilityPresented : Bool
    @Binding public var newUtilityType : UtilityType
    
    var body: some View {
        let key = utilities[0].utilityType
        
        Section(header:
                    HStack {
            Image(systemName: key.icon).foregroundColor(key.color)
            Text(key.localizedName)
            Spacer()
            Button {
                newUtilityType = key
                newUtilityPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }
        }.font(.callout)
        ){
            ForEach (utilities) { utility in
                NavigationLink(destination: UtilityDetailsView(utility: utility, tarifs: tarifs)) {
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
    }
}

struct UtilitySection_Previews: PreviewProvider {
    static var previews: some View {
        List{
            UtilitySectionView(utilities: Utility.sampleData, tarifs: Tariff.sampleData, newUtilityPresented: .constant(false), newUtilityType: .constant(.Other)).previewLayout(.sizeThatFits)
        }
        
    }
}
