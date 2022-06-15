//
//  Aadd.swift
//  Utilities
//
//  Created by Natalya Lysakova on 01.06.2022.
//

import SwiftUI

struct AddEditTarif: View {
    @Binding var data : Tariff.TarifData
    var utility : Utility
    @Binding var saveTarif : Bool
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        VStack {
            Form {
                DatePicker("date", selection: $data.startDate, displayedComponents: .date)
                
                CurrencyTextField(placeholder: String(localized: "cost"), number: $data.cost).onChange(of: data.cost) { newValue in
                    
                    if newValue == 0{
                        self.background(.red)
                    }
                }
            }
            HStack{
                Button("cancel"){
                    dismiss()
                }.padding(.horizontal, 70)
                
                Button("save"){
                    if(isValid())
                    {
                        saveTarif = true
                        dismiss()
                    }
                }.padding(.horizontal, 70)
                
                
            }
        }
        
    }
    func isValid() -> Bool{
        return data.cost > 0
    }
}

struct Aadd_Previews: PreviewProvider {
    static var previews: some View {
        AddEditTarif(data: .constant(Tariff.TarifData()), utility: Utility.sampleData[0], saveTarif: .constant(false))
    }
}
