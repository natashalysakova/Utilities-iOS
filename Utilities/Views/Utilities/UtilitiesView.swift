//
//  UtilitiesView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 23.05.2022.
//

import SwiftUI

struct UtilitiesView: View {
    
    @Binding var utilities : [Utility]
    @Binding var tarifs : [Tariff]
    
    @State var newUtilityPresented : Bool = false
    @State var newUtilityType : UtilityType = .Other
    

    
    var body: some View {
        List{
            ForEach (UtilityType.allValues, id: \.self) { key in
                let filtered = WillDo(type: key)
                if filtered.count > 0 {
                    UtilitySectionView(utilities: filtered, tarifs: GetTarifs(type: filtered), newUtilityPresented: $newUtilityPresented, newUtilityType: $newUtilityType)
                }
            }
        }
        .toolbar {
            //#warning("TODO: implement")
            Button {
                
            } label: {
                Image(systemName: "plus")
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
    
    func WillDo(type : UtilityType) -> [Utility]{
        return utilities.filter({
            $0.utilityType == type
        })
    }
    
    func GetTarifs(type : [Utility]) -> [Tariff]{
        var result : [Tariff] = []
        for t in tarifs {
            if type.contains(where: { u in
                u.id == t.utility.id
            })
            {
                result.append(t)
            }
        }
        return result
    }
}

struct UtilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            UtilitiesView(utilities: .constant(Utility.sampleData), tarifs: .constant(Tariff.sampleData)).preferredColorScheme(.light)
            UtilitiesView(utilities: .constant(Utility.sampleData), tarifs: .constant(Tariff.sampleData)).preferredColorScheme(.dark)
        }
    }
}
