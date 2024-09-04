//
//  Recipe.swift
//  Health and Wellness
//
//  Created by James Wood on 3/3/24.
//

import Foundation

struct Recipe: Hashable, Identifiable, Codable {
    let id = UUID()
    let name: String
    let ingredients: [Ingredient]
    let serves: Int?
    let url: String?
    let tags: [String]?
}

struct Ingredient: Hashable, Identifiable, Codable {
    let id = UUID()
    let ingredient: String
    let measurement: Float64?
    let units: String?
    
    var displayText: String {
        return "\(measurement != nil ? measurement!.formatted() : "") \(units != nil ? units! : "") \(ingredient)"
    }
}

struct MockData {
    static let sampleRecipes: [Recipe] = {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Recipe].self, from: mockDataJson())
        } catch {
            print("Unexpected error: \(error).")
            return []
        }
    }()
}

let mockDataJson = {
    if let filepath = Bundle.main.path(forResource: "SampleRecipes", ofType: "json") {
        do {
            return try String(contentsOfFile: filepath).data(using: .utf8)!
        } catch {
            print("Unexpected error: \(error).")
            return "{}".data(using: .utf8)!
        }
    } else {
        print("file not found")
        return "{}".data(using: .utf8)!
    }
}

