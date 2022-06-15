//
//  UtilityDetailsView.swift
//  Utilities
//
//  Created by Natalya Lysakova on 25.05.2022.
//

import SwiftUI

struct UtilityDetailsView: View {
    @Binding var utility : Utility
    
    @ObservedObject var model : UtilityDataModel
    
    @State var useMeters : Bool = false
    @State var ShowAddTarif : Bool = false
    @State var newTarifData = Tariff.TarifData()
    @State var refresh : Bool = false
    @State var newTariffAdded : Bool = false
    @State var editEnabled : Bool = false
    
    @State var editedUtility = Utility.Data()
    //    @State var order = "0"
    //    @State var selectedUtility : UtilityType = .Other
    
    var body: some View {
        Form{
            List{
#if DEBUG
                HStack{
                    Text("id")
                    Spacer()
                    Text(String(utility.id)).foregroundColor(.gray)
                }.listRowBackground(Color.orange)
#endif
                
                if editEnabled {
                    Picker("utility_type", selection: $editedUtility.utilityType) {
                        ForEach(UtilityType.allValues, id: \.self) { type in
                            HStack{
                                
                                Text(type.localizedName)
                                Image(systemName: type.icon).foregroundColor(type.color)
                                
                            }.tag(type)
                        }
                    }
                }
                else {
                    HStack{
                        Text("utility_type")
                        Spacer()
                        Text(utility.utilityType.localizedName)
                        Image(systemName: utility.utilityType.icon).foregroundColor(utility.utilityType.color)
                    }
                }
                
                HStack{
                    Text("utility_name")
                    Spacer()
                    if editEnabled {
                        TextField(utility.name, text: $editedUtility.name).multilineTextAlignment(.trailing)
                    }
                    else {
                        Text(String(utility.name)).foregroundColor(.gray)
                    }
                    
                }
                
                HStack{
                    Text("units")
                    Spacer()
                    if editEnabled {
                        TextField(editedUtility.units , text: $editedUtility.units).multilineTextAlignment(.trailing)
                    }
                    else{
                        Text(String(utility.units ?? "?")).foregroundColor(.gray)
                    }
                }
                
                HStack{
                    Text("order")
                    Spacer()
                    if editEnabled {
                        Stepper(String(editedUtility.order), value: $editedUtility.order)
                    }
                    else{
                        Text(String(utility.order)).foregroundColor(.gray)
                    }
                }
                
                if editEnabled{
                    Toggle("use_meters", isOn: $editedUtility.useMeters).disabled(!editEnabled)
                }
                else{
                    Toggle("use_meters", isOn: $utility.useMeters ).disabled(!editEnabled)
                }
                
                
                
                Section(header:
                            HStack{
                    Text("tarifs")
                    Spacer()
                    Button {
                        ShowAddTarif.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }.font(.callout)
                ){
                    
                    ForEach (model.sortedAndFilteredTarifs(filter: utility)) { tarif in
                        if(utility.id == tarif.utility.id)
                        {
                            HStack{
                                Text(DateFormatter.shortDate.string(from: tarif.startDate))
                                if(!tarif.isActive)
                                {
                                    Text(verbatim: " - ")
                                    Text(DateFormatter.shortDate.string(from: tarif.endDate ?? Date()))
                                    
                                }
                                Spacer()
                                Text(NumberFormatter.uah.string(from: tarif.cost as NSNumber) ?? "?")
                            }
                            .listRowBackground(tarif.color)
                            .foregroundColor(tarif.textColor)
                            .swipeActions(edge: .leading) {
                                if !tarif.isActive {
                                    Button  {
                                        model.ActivateTarif(tarif: tarif, filter: utility)
                                    } label: {
                                        Text("Activate")
                                    }
                                }
                            }.tint(.green)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive)  {
                                        model.DeleteTarif(item: tarif, filter: utility)
                                    } label: {
                                        Image(systemName: "trash")
                                    }.background(.green)
                                    
                                }
                        }
                    }
                    Button {
                        ShowAddTarif.toggle()
                    } label: {
                        HStack{
                            Image(systemName: "plus.circle.fill").symbolRenderingMode(.multicolor)
                            Text("add-tarif")
                        }
                    }.buttonStyle(.plain)
                    
                }
                
                
            }
            .onAppear {
                useMeters = utility.useMeters
            }
            
            .navigationBarTitle(utility.name)
            .navigationBarBackButtonHidden(editEnabled)
            .toolbar {
                
                ToolbarItem(placement: .cancellationAction) {
                    if editEnabled {
                        Button(role: .destructive) {
                            editEnabled.toggle()
                            editedUtility = Utility.Data()
                        } label: {
                            Text("Cancel")
                        }.accentColor(.red)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction){
                    if editEnabled {
                        Button {
                            editEnabled.toggle()
                            model.UpdateUtility(from: editedUtility)
                            utility.update(from: editedUtility)
                            editedUtility = Utility.Data()
                        } label: {
                            Text("Save")
                        }
                    }
                    else{
                        Button {
                            editedUtility = utility.data
                            editEnabled.toggle()
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
                
                ToolbarItem(placement: .primaryAction){
                    if !editEnabled {
                        
                    }
                }
                
            }
            .sheet(isPresented: $ShowAddTarif) {
                //on dismiss
                if(newTariffAdded) {
                    model.addTarif(from: newTarifData, utilityId: utility.id)
                    newTarifData = Tariff.TarifData()
                    newTariffAdded = false;
                }
            } content: {
                AddEditTarif(data: $newTarifData, utility: utility, saveTarif: $newTariffAdded)
            }
            
            
        }
    }
}

struct UtilityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                UtilityDetailsView(utility: .constant(Utility.sampleData[1]), model:
                                    UtilityDataModel.sampleData, editedUtility: Utility.sampleData[1].data).preferredColorScheme(.light)
            }
            NavigationView {
                UtilityDetailsView(utility: .constant(Utility.sampleData[0]), model: UtilityDataModel.sampleData, editedUtility: Utility.sampleData[0].data).preferredColorScheme(.dark)
            }
        }
    }
}
//struct EditView: View {
//    @Binding var utility : Utility
//
//
//    var body: some View {
//#if DEBUG
//        HStack{
//            Text("id")
//            Spacer()
//            Text(String(utility.id)).foregroundColor(.gray)
//        }.listRowBackground(Color.orange)
//#endif
//        //
//        Picker("utility_type", selection: $selectedUtility) {
//            ForEach(UtilityType.allValues, id: \.self) { type in
//                HStack{
//                    Image(systemName: type.icon).foregroundColor(type.color)
//                    Text(type.localizedName)
//
//                }.tag(type)
//            }
//        }.onChange(of: selectedUtility) { newValue in
//            utility.utilityType = newValue
//        }.onAppear {
//            selectedUtility = utility.utilityType
//        }
//
//        HStack{
//            Text("utility_name")
//            Spacer()
//
//            TextField(utility.name, text: $utility.name).multilineTextAlignment(.trailing)
//
//        }
//
//
//        HStack{
//            Text("units")
//            Spacer()
//            TextField(utility.units ?? "", text: $utility.units ?? "none")
//                .multilineTextAlignment(.trailing)
//
//
//        }
//        HStack{
//            Text("order")
//            Spacer()
//
//            //                TextField("order", text: $order)
//            //                    .keyboardType(.numberPad)
//            //                    .multilineTextAlignment(.trailing)
//            //                    .onChange(of: order) { newValue in
//            //                        utility.order = Int(newValue) ?? -1
//            //                    }
//        }
//        .onAppear(perform: {
//            order = String(utility.order)
//        })
//
//        HStack{
//            Toggle("use_meters", isOn: $utility.useMeters)
//        }
//    }
//}


func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
