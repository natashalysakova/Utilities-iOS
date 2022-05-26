//
//  UtilityDetailsView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 25.05.2022.
//

import SwiftUI

struct UtilityDetailsView: View {
    var utility : Utility
    var tarifs : [Tariff]
    @State var useMeters : Bool = false
    
    var body: some View {
        List{
            HStack{
                Text("utility_type")
                Spacer()
                Text(utility.utilityType.localizedName)
                Image(systemName: utility.utilityType.icon).foregroundColor(utility.utilityType.color)
            }
            
            HStack{
                Text("utility_name")
                Spacer()
                Text(String(utility.name)).foregroundColor(.gray)
                
            }
#if DEBUG
            HStack{
                Text("id")
                Spacer()
                Text(String(utility.id)).foregroundColor(.gray)
            }
#endif
            
            HStack{
                Text("units")
                Spacer()
                Text(String(utility.units ?? "?")).foregroundColor(.gray)
                
            }
            HStack{
                Text("order")
                Spacer()
                Text(String(utility.order)).foregroundColor(.gray)
            }
            
            HStack{
                Toggle("use_meters", isOn: $useMeters).disabled(true)
            }
            
            Section(header:
                        HStack{
                Text("tarifs")
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
                
            }.font(.callout)){
                ForEach (tarifs.sorted(by: { one, two in
                    one.startDate > two.startDate
                })){tarif in
                    if(utility.id == tarif.utility.id)
                    {
                        HStack{
                            Text(DateFormatter.shortDate.string(from: tarif.startDate))
                            if(!tarif.isActive)
                            {
                                Text(verbatim: " - ")
                                Text(DateFormatter.shortDate.string(from: tarif.endDate ?? Date()))
                                
                            }
                            Spacer()
                            Text(NumberFormatter.uah.string(from: tarif.cost as NSNumber) ?? "?")
                        }
                        .listRowBackground(tarif.color)
                        .foregroundColor(tarif.textColor)
                        
                    }
                }
            }
        }
        .onAppear {
            useMeters = utility.useMeters
        }
        .navigationBarTitle(utility.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UtilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UtilityDetailsView(utility: Utility.sampleData[0], tarifs: Tariff.sampleData).preferredColorScheme(.light)
            }
            NavigationView {
                UtilityDetailsView(utility: Utility.sampleData[0], tarifs: Tariff.sampleData).preferredColorScheme(.dark)
            }
        }
    }
}
