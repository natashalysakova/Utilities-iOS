//
//  RecordView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 23.05.2022.
//

import SwiftUI

struct RecordView: View {
    let record : Record
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .center){
            List {
#if DEBUG
                HStack{
                    Label("id", systemImage: "number")
                    Spacer()
                    Text(record.id?.uuidString ?? "")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }.listRowBackground(Color.orange)
#endif
                Section(String(localized: "tariff")) {
                    HStack (alignment: .lastTextBaseline){
                        Label(String(localized: "utility_name"), systemImage: "rectangle.and.pencil.and.ellipsis")
                        Spacer()
                        Text(record.tariff.utility.name)
                    }
                    HStack{
                        Label(String(localized: "utility_type"), systemImage: "hammer")
                        Spacer()
                        Text(record.tariff.utility.utilityType.localizedName)
                    }
                    HStack{
                        Label(String(localized: "tarif_start_date"), systemImage: "calendar")
                        Spacer()
                        Text(DateFormatter.shortDate.string(from: record.tariff.startDate))
                    }
                    HStack {
                        Label(String(localized: "tarif_cost"), systemImage: "hryvniasign.circle")
                        Spacer()
                        Text(NumberFormatter.uah.string(from: record.tariff.cost as NSNumber) ?? "0")
                    }
                    
                    HStack{
                        Label(String(localized: "units"), systemImage: "ruler")
                        Spacer()
                        Text(record.tariff.utility.units ?? "")
                    }
                }
                
                Section(String(localized: "data")) {
                    
                    if(record.tariff.utility.useMeters){
                        HStack{
                            Label(String(localized: "previous_value"), systemImage: "arrow.counterclockwise")
                            Spacer()
                            Text(String(describing: record.previousValue)).foregroundColor(.gray)
                        }
                        
                        HStack{
                            Label(String(localized: "meters"), systemImage: "arrow.down.to.line")
                            Spacer()
                            Text(String(describing: record.meters))
                        }
                        
                    }
                    
                    
                    if record.measure != 1 || record.tariff.utility.useMeters
                    {
                        HStack{
                            Label(String(localized: "mesures"), systemImage: "sum")
                            Spacer()
                            Text(String(describing: record.measure))
                        }
                    }
                    
                    HStack{
                        Label(String(localized: "cost"), systemImage: "hryvniasign.circle")
                        Spacer()
                        Text(String(describing: record.costText))
                    }
                }
            }
            
            Button(action: {
                dismiss()
            }, label: {
                Text(String(localized: "close")).padding(.horizontal, 30)
            })
            .controlSize(.large)
            Spacer()
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(record: .sampleData[0]).previewLayout(.sizeThatFits)
    }
}
