//
//  CartManager.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/18/25.
//

import Foundation
import Combine

@MainActor
class CartManager: ObservableObject {
    // This array holds the user's order
    @Published var items: [CartItem] = []
    
    // Calculate property for the grand total
    var total: Double {
        items.reduce(0) { $0 + $1.total}
    }
    
    func add(item: MenuItem, quantity: Int, notes: String?) {
        let newItem = CartItem(
            menuItem: item,
            quantity: quantity, notes: notes
        )
        items.append(newItem)
        print("Cart Updated! Total items: \(items.count)")
    }
    
    func removeFromCart(id: UUID) {
        items.removeAll { $0.id == id }
    }
    
    func clearCart() {
        items.removeAll()
    }
    
    func checkout() async throws {
        let service = OrderSevice()
        
        // Send data to supabase
        try await service
            .placeOrder(
                items: self.items,
                total: self.total,
                notes: nil
            )
        // if successful, clear the local cart
        self.clearCart()
    }
}
