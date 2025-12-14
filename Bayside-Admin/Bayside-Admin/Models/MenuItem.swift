//
//  MenuItem.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/12/25.
//

import Foundation

// Codable: Allows to turn into JSON(for the Database) and back to Swift automatically.
// Identifiable: Required for SwiftUI Lists (so the interface knows which row is which).

struct MenuItem: Identifiable, Codable {
    var id: Int64?
    var name: String
    var description: String?
    var price: Double
    var imageURL: String?
    var isAvailable: Bool
    var categoryId: Int64?
    
    
    //MAPPING:
    // Database uses snake_case (image_url), but swift uses camelCase(imageURL).
    // This enum tells swift how to translate b/w the two.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case price
        case imageURL = "image_url" // The translation Map
        case isAvailable = "is_available"
        case categoryId = "category_id"
    }
}
