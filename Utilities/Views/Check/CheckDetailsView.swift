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
    @State private var IsPopoverPresented : Bool = false
    
    //    func SortRecords(records: [Record]) -> [Record] {
    //        records.sorted(by: { one, two in
    //            one.tariff.utility.order < two.tariff.utility.order
    //        })
    //    }
    
    
    
    var body: some View {
        
        let report = ReportView(check: check)
        
        VStack{
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
                            Image(systemName: record.tariff.utility.utilityType.icon).foregroundColor(record.tariff.utility.utilityType.color)
                            Text(record.tariff.utility.name)
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
                NavigationLink("Report", destination: report, isActive: $IsPopoverPresented)
            }
            .navigationTitle(String(format: String(localized: "check_from"), DateFormatter.monthAndYear.string(from: check.date)))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    IsPopoverPresented.toggle()

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
    
    
    
}

struct CheckDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckDetailsView(check: .constant(Check.sampleData[0]))
        }
    }
}

extension View {
    
    func screenshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = UIScreen.main.bounds.size
        //let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}
