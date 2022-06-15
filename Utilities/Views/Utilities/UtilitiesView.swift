//
//  UtilitiesView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 23.05.2022.
//

import SwiftUI

struct UtilitiesView: View {
    
    @Binding var dataModel : UtilityDataModel
    @State var newUtilityPresented : Bool = false
    @State var newUtilityType : UtilityType = .Other
    
    
    
    var body: some View {
        
        List{
            ForEach (UtilityType.allValues, id: \.self) { key in
                
                UtilitySectionVew(
                    dataModel: $dataModel,
                    utilityType: key,
                    newUtilityPresented: $newUtilityPresented,
                    newUtilityType: $newUtilityType)
            }
        }
        .sheet(isPresented: $newUtilityPresented, onDismiss: {
            print("closing")
        }) {
            Form{
                List{
                    HStack{
                        Text("utility_type")
                        Spacer()
                        Text(newUtilityType.localizedName)
                    }
                }
            }
        }
    }
}

struct UtilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UtilitiesView(dataModel: .constant(UtilityDataModel.sampleData)).preferredColorScheme(.light)
            UtilitiesView(dataModel: .constant(UtilityDataModel.sampleData)).preferredColorScheme(.dark)
        }
    }
}
