//
//  UtilitySection.swift
//  Utilities
//
//  Created by Natalya Lysakova on 25.05.2022.
//

import SwiftUI

struct UtilitySectionView: View {
    @Binding var utilities : [Utility]
    @Binding var tarifs : [Tariff]
    
    @Binding public var newUtilityPresented : Bool
    @Binding public var newUtilityType : UtilityType
    
    var body: some View {
        
    }
}

struct UtilitySection_Previews: PreviewProvider {
    static var previews: some View {
        List{
            UtilitySectionView(utilities: .constant(Utility.sampleData), tarifs: .constant(Tariff.sampleData), newUtilityPresented: .constant(false), newUtilityType: .constant(.Other)).previewLayout(.sizeThatFits)
        }
        
    }
}
