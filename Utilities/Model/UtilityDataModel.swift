//
//  UtilityDataModel.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import SwiftUI
class UtilityDataModel : ObservableObject, Codable {
    init() {
        tariffs = []
        checks = []
        utilities = []
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tariffs = try container.decode([Tariff].self, forKey: .tariffs)
        checks = try container.decode([Check].self, forKey: .checks)
        utilities = try container.decode([Utility].self, forKey: .utilities)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tariffs, forKey: .tariffs)
        try container.encode(utilities, forKey: .utilities)
        try container.encode(checks, forKey: .checks)
    }
    
    
    @Published var tariffs : [Tariff]
    @Published var checks : [Check]
    @Published var utilities : [Utility]
    
    
    
    private enum CodingKeys : String, CodingKey {
        case tariffs = "Tarifs", checks = "Checks", utilities = "UtilityTypes"
    }
    
    func getPreviousTarifs(utilityId: Int) -> [Tariff]{
        return tariffs.filter{ tarif  in
            tarif.utility.id == utilityId
        }
    }
    
    func addTarif(from: Tariff.TarifData, utilityId: Int) {
        
        let id = (tariffs.max { one, two in
            one.id < two.id
        }?.id ?? 0) + 1
        
        let new = Tariff.FromData(data: from, id: id, utility: utilities.first(where: { x in
            x.id == utilityId
        })!)
        let oldTarifs = getPreviousTarifs(utilityId: utilityId)
        
        for t in oldTarifs {
            t.Disable()
        }
        
        tariffs.append(new)
        
        Save()
    }
    
    func  DeleteTarif (tarif: Tariff) {
        let index = tariffs.firstIndex { t
            in
            t.id == tarif.id
        }
        
        tariffs.remove(at: index!)
        
        Save()
        //UtilityStore.save(datamodel: self, completion: {result in print("Saved")})
    }

    
    func  DeleteTarif (item: Tariff, filter: Utility) {
        if (item.isActive){
            var tmpTarifs = self.getPreviousTarifs(utilityId: filter.id)
            tmpTarifs.sort { one, two in
                one.startDate > two.startDate
            }
            for j in tmpTarifs{
                if j.id != item.id {
                    j.isActive = true;
                    break
                }
            }
        }
        
        self.tariffs.removeAll { t in
            t.id == item.id
        }
        self.Save()
        //model.updateTarifs(newTarifs: SortedTarifs)
    }
    
    func UpdateUtility(from: Utility.Data){
        let util = utilities.first { u in
            u.id == from.id
        }
        
        util?.update(from: from)
        Save()
        
    }
    
    
    func  DeleteTarif (indexSet: IndexSet, filter: Utility) {
        
        for i in indexSet {
            let tmp = self.sortedAndFilteredTarifs(filter: filter)[i]
            DeleteTarif(item: tmp, filter: filter)
        }
    }
    
    func ActivateTarif (tarif :Tariff, filter :Utility)
    {
        let tarifs = self.sortedAndFilteredTarifs(filter: filter)
        for t in tarifs{
            if(t.id == tarif.id){
                t.isActive = true
            }
            else{
                t.isActive = false
            }
        }

        Save();
    }
    
    func deactivateTarifs (filter :Utility)
    {
        let tarifs = self.sortedAndFilteredTarifs(filter: filter)
        for t in tarifs{
                t.isActive = false
        }
        Save();
    }
    
    func Save() {
        Task {
            do {
                try await UtilityDataModel.save(model: self)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func validate(){
        for i in checks.indices{
            
            if checks[i].id == nil{
                checks[i].id = UUID()
            }
            
            for j in  checks[i].records.indices{
                if checks[i].records[j].id == nil{
                    checks[i].records[j].id = UUID()
                }
            }
        }
    }
    
    func updateTarifs(newTarifs: [Tariff])
    {
        for index in stride(from: tariffs.count - 1, to: 0, by: -1) {
            let old = tariffs[index]
            let temp = newTarifs.first { t in
                old.id == t.id
            }
            
            if(temp == nil){
                tariffs.remove(at: index)
            }
            else{
                old.Update(newData: temp!)
            }
        }
        
        Save()
    }
    
    var sortedTariffs : [Tariff] {
        tariffs.sorted(by: { one, two in
            one.startDate > two.startDate
        })
        
    }
    
    func sortedAndFilteredTarifs (filter: Utility) -> [Tariff]{
        sortedTariffs.filter { t in
            t.utility.id == filter.id
        }
    }
    
    func filteredUtilities (type: UtilityType) -> [Utility]{
        utilities.filter { u in
            u.utilityType == type
        }
    }
    
    var groupedChecks : Dictionary<Int, [Check]> {
        return Dictionary(grouping: checks) { c in
            Calendar.current.dateComponents([.year], from: c.date).year ?? 0
        }
    }
    func getYears() -> [String] {
        let d = DateFormatter()
        d.dateFormat = "yyyy"
        
        return checks.map { c in
            d.string(from: c.date)
        }.uniqued().sorted().reversed()
    }
    func getChecks(year : String) -> [Check] {
        let d = DateFormatter()
        d.dateFormat = "yyyy"
        
        return checks.filter({ c in
            d.string(from: c.date) == year
        }).sorted { c1, c2 in
            c1.date > c2.date
        }
    }
}

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}

extension UtilityDataModel {
    public static var sampleData: UtilityDataModel {
        let result =  UtilityDataModel()
        result.utilities = Utility.sampleData
        result.checks = Check.sampleData
        result.tariffs = Tariff.sampleData
        return result
    }
    
    
    static func load() async throws -> UtilityDataModel {
        try await withCheckedThrowingContinuation { continuation in
            load { result in
                switch result{
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let model):
                    continuation.resume(returning: model)
                }
            }
        }
    }
    
    @discardableResult
    static func save(model: UtilityDataModel) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            save(datamodel: model) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let modelSaved):
                    continuation.resume(returning: modelSaved)
                }
            }
        }
    }
    
    static func load2() -> UtilityDataModel{
        do{
        let fileURL = try fileURL()
        guard let file = try? FileHandle(forReadingFrom: fileURL) else {
            return UtilityDataModel()
        }
        let decoder = JSONDecoder();
        decoder.dateDecodingStrategy = .formatted(.iso8601Full)
        let tmp = try decoder.decode(UtilityDataModel.self, from: file.availableData)
        return tmp
        }
        catch{
            return UtilityDataModel()
        }
    }
    
    static func load(completion: @escaping (Result<UtilityDataModel, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(UtilityDataModel()))
                    }
                    return
                }
                let decoder = JSONDecoder();
                decoder.dateDecodingStrategy = .formatted(.iso8601Full)
                let tmp = try decoder.decode(UtilityDataModel.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(tmp))
                }
            } catch {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(datamodel: UtilityDataModel, completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let encoder = JSONEncoder();
                encoder.dateEncodingStrategy = .formatted(.iso8601Full)
                let data = try encoder.encode(datamodel)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(datamodel.checks.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("Utility.data.json")
    }
}

