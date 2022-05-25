//
//  ContentView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import SwiftUI

struct ChecksView: View {
    
    @Binding var checks : [Check]
    @State var isPresentingNewCheckView = false
    @State var newCheck = Check.Data()
    
    
    var body: some View {
        List{
            
            ForEach($checks){$check in
                NavigationLink(destination: CheckDetailsView(check: $check)) {
                    HStack {
                        Label(DateFormatter.shortDate.string(from: check.date), systemImage: "list.bullet")
                        Spacer()
                        Text(check.sumText).foregroundColor(.gray)
                    }
                }
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
    }
}

struct ChecksView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChecksView(checks: .constant(Check.sampleData))
        }
    }
}
