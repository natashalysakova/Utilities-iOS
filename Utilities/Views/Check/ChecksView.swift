//
//  ContentView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import SwiftUI

struct ChecksView: View {
    
    @Binding var dataModel : UtilityDataModel
    @State var isPresentingNewCheckView = false
    @State var newCheck = Check.Data()
    @State var years : [String] = []
    
    
    var body: some View {
        List{
            ForEach($years, id: \.self){ $value in
                ExtractedView(model: $dataModel, year: value)
            }
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                Button() {
                    //#warning("TODO: implement")
                } label: {
                    Label("Edit", systemImage: "pencil")
                }
                .tint(.green)
            }
            .swipeActions(edge: .trailing) {
                Button(role: .destructive) {
                    //#warning("TODO: implement")
                } label: {
                    Label("Delete", systemImage: "trash.fill")
                }
            }
            
        }
        .toolbar {
            NavigationLink (destination: CheckEditView(check: $newCheck)) {
                Image(systemName: "square.and.pencil")
            }
        }
        .onAppear(){
            years = dataModel.getYears()
        }
    }
}

struct ChecksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChecksView(dataModel: .constant(UtilityDataModel.sampleData), years: UtilityDataModel.sampleData.getYears())
        }
    }
}

struct ExtractedView: View {
    @Binding var model : UtilityDataModel
    @State var groupedCheks : [Check] = []
    @State var year : String
    var body: some View {
        Section(year) {
            ForEach($groupedCheks){ $check in
                NavigationLink(destination: CheckDetailsView(check: $check)) {
                    HStack {
                        Label(DateFormatter.shortDate.string(from: check.date), systemImage: "list.bullet")
                        Spacer()
                        Text(check.sumText).foregroundColor(.gray)
                    }
                }
            }
        }
        .onAppear(){
            groupedCheks = model.getChecks(year: year)
        }
        .font(.callout)
    }
}
