//
//  data.swift
//  mindwade
//
//  Created by David D on 11/9/23.
//

import Foundation

struct AnchorFlashcard: Identifiable, Codable {
    let id: Int
    let title: String
    let details: String
    let level: Int
    let parentID: Int?
}

class DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    var anchorFlashcards: [AnchorFlashcard] {
        if let data = loadJSONData() {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([AnchorFlashcard].self, from: data)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        return []
    }
    
    private func loadJSONData() -> Data? {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
        return nil
    }
}
