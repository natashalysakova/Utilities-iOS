//
//  ReportView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 27.05.2022.
//

import SwiftUI

struct ReportView: View {
    var check : Check
    
    
    var body: some View {
        List {
            Text(DateFormatter.shortDate.string(from: check.date))
            ForEach(check.records) { record in
                if(record.tariff.utility.useMeters)
                {
                    HStack(alignment: .bottom){
                        VStack(alignment: .leading){
                            Text(record.tariff.utility.name)
                            let calc = "\(record.meters) - \(record.previousValue) = \(record.measure) * \(NumberFormatter.uah.string(from: record.tariff.cost as NSNumber)!)"
                            Text(verbatim: "\(calc)")
                        }
                        Spacer()
                        Text(record.costText)
                    }
                }
                else{
                    HStack(alignment: .top){
                        Text(record.tariff.utility.name)
                        Spacer()
                        Text(record.costText)
                    }
                }
            }
            HStack{
                Spacer()
                Text("total")
                Text(check.sumText)
            }
        }
    }
    
    func actionSheet(image : UIImage) {
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(check: Check.sampleData[0])
    }
}
