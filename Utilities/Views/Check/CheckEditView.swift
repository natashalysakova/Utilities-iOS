//
//  CheckEditView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 23.05.2022.
//

import SwiftUI

struct CheckEditView: View {
    @Binding var check : Check.Data
    //@Binding var utilities : [Utility]
    
//#warning("TODO: implement")
    
    @State var isExpanded : Bool = true
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form{
            DatePicker(String(localized: "date"), selection: $check.date, in: ...Date(), displayedComponents: .date)
            
            Section(String(localized: "records")) {
                ForEach( $check.records, id: \.id) { $record in
                    
                    DisclosureGroup (isExpanded: $isExpanded) {
                       
                        //ForEach ($utilities) { $utility in
                            //Text(utility.name)
                        //}
                        
                        
                        if(record.tariff.utility.useMeters){
                            HStack{
                                Label(String(localized: "previous_value"), systemImage: "arrow.counterclockwise")
                                Spacer()
                                TextField ("0", value: $record.previousValue, formatter: NumberFormatter())
                                    .textFieldStyle(MyTextFieldStyle())
                            }
                            HStack{
                                Label(String(localized: "meters"), systemImage: "sum")
                                Spacer()
                                TextField ("0", value: $record.meters, formatter: NumberFormatter())
                                    .textFieldStyle(MyTextFieldStyle())
                            }
                            HStack{
                                Label(String(localized: "mesures"), systemImage: "sum")
                                Spacer(minLength: 50)
                                Text (NumberFormatter().string(from: record.measure as NSNumber) ?? "?")
                                    .frame(width: 100)
                                    .foregroundColor(.gray)
                            }
                        }
                        else{
                            HStack{
                                Label(String(localized: "mesures"), systemImage: "sum")
                                Spacer(minLength: 50)
                                TextField ("0", value: $record.measure, formatter: NumberFormatter())
                                    .textFieldStyle(MyTextFieldStyle())
                            }
                        }
                        
                        
                    } label: {
                        Label(record.tariff.utility.name, systemImage: "list.dash.header.rectangle")
                        Spacer()
                        Text(record.costText)
                            .foregroundColor(Color.gray)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }
                }
            }
        }
    }
}

struct CheckEditView_Previews: PreviewProvider {
    static var previews: some View {
        CheckEditView(check: .constant(Check.sampleData[0].data))
    }
}

struct MyTextFieldStyle : TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .frame(width: 100)
    }
    
    
}
