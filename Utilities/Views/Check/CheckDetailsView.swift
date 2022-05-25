//
//  CheckDetailsView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import SwiftUI

struct CheckDetailsView: View {
    @Binding var check : Check
    @State private var IsRecordDetailPresented : Bool = false
    @State private var DetailItem : Record?
    
//    func SortRecords(records: [Record]) -> [Record] {
//        records.sorted(by: { one, two in
//            one.tariff.utility.order < two.tariff.utility.order
//        })
//    }
    
    var body: some View {
        List {
            Section(header: Label("general", systemImage: "list.dash")){
#if DEBUG
                HStack{
                    Label("id", systemImage: "number")
                    Spacer()
                    Text(check.id?.uuidString ?? "")
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                }
#endif
                HStack{
                    Label("date", systemImage: "calendar")
                    Spacer()
                    Text(DateFormatter.shortDate.string(from: check.date))
                        .foregroundColor(Color.gray)
                }
                HStack{
                    Label("sum", systemImage: "hryvniasign.circle")
                    Spacer()
                    Text(check.sumText)
                        .foregroundColor(Color.gray)
                }
            }
            Section(header: Label("records", systemImage: "list.dash")) {
                ForEach(check.SortedRecords()) { record in
                    HStack{
                        Label(record.tariff.utility.name, systemImage: "list.dash.header.rectangle").lineLimit(1)
                        Spacer()
                        Text(record.costText)
                            .foregroundColor(Color.gray)
                        
                        Button {
                            DetailItem = record
                        } label: {
                            Image(systemName: "info.circle").renderingMode(.original)
                        }
                        
                    }
                }
            }
        }
        .navigationTitle(String(format: String(localized: "check_from"), DateFormatter.monthAndYear.string(from: check.date)))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button {

            } label: {
                Image(systemName: "square.and.arrow.up")
            }
        }
        .sheet(item: $DetailItem, onDismiss: {
            DetailItem = nil
        }, content: { record in
            RecordView(record: record)
        })
        
    }
}

struct CheckDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckDetailsView(check: .constant(Check.sampleData[0]))
        }
    }
}
