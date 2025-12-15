//
//  MenuCategory.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/15/25.
//

import Foundation

struct MenuCategory: Identifiable, Codable {
    var id: Int64
    var name: String
    var iconName: String?
    var sortOrder: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case iconName = "icon_name"
        case sortOrder = "sort_order"
    }
}
