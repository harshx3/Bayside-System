//
//  CartItem.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/18/25.
//

import Foundation


struct CartItem: Identifiable, Codable {
    var id: UUID = UUID() // Unique ID for this specific instance in the cart
    var menuItem: MenuItem
    var quantity: Int
    var notes: String?
    
    
    // Helper to calculate total for this line
    var total: Double {
        return menuItem.price * Double(
            quantity
        )
    }
}
