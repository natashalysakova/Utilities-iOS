//
//  UtilityStore.swift
//  Utilities
//
//  Created by Natalya Lysakova on 22.05.2022.
//

import Foundation
import SwiftUI

class UtilityStore : ObservableObject {
    
    @Published var model: UtilityDataModel = UtilityDataModel()
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("Utility.data.json")
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
                var tmp = try decoder.decode(UtilityDataModel.self, from: file.availableData)
                tmp.checks = tmp.checks.sorted(by: { one, two in
                    one.date > two.date
                })
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
}

