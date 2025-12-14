//
//  Order.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/12/25.
//


import Foundation

struct Order: Identifiable, Codable {
    var id: Int64?
    var status: String // "New", "Coocking", "Ready", "Delivered"
    var total: Double
    var notes: String?
    var customerId: UUID?
    var createdAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case status
        case total
        case notes
        case customerId = "customer_id"
        case createdAt = "created_at"
    }
}
