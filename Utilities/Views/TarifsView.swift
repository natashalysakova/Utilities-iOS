//
//  TarifsView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 23.05.2022.
//

import SwiftUI

struct TarifsView: View {
    @Binding var tarifs : [Tariff]
    var body: some View {
        Text(String(localized: "tarifs"))
    }
}

struct TarifsView_Previews: PreviewProvider {
    static var previews: some View {
        TarifsView(tarifs: .constant(Tariff.sampleData))
    }
}
