//
//  DecimalTextField.swift
//  Utilities
//
//  Created by Natalya Lysakova on 08.06.2022.
//

import SwiftUI

struct CurrencyTextField: View {
    public let placeholder : String
    @State private var numberString: String = ""
    @Binding var number : Decimal
    
    var body: some View {
        HStack {
            Text(placeholder)
            Spacer()
            TextField("0", text: $numberString)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .onChange(of: numberString) { newValue in
                do{
                    number = try Decimal(numberString, format: Decimal.FormatStyle.number)
                }
                catch{
                    number = 0
                }
            }
            Text("₴")
        }
    }
}

struct DecimalTextField_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyTextField(placeholder: "test", number: .constant(10)).previewLayout(.sizeThatFits)
    }
}
