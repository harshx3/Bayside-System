//
//  OrderService.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/22/25.
//

import Foundation
import Supabase

struct OrderItemCallback: Encodable {
    // A temporary struct just for uploading to 'order_items'
    let order_id: Int64
    let menu_item_id: Int64
    let quantity: Int
    let unit_price: Double
}

class OrderSevice {
    private let client = SupabaseManager.shared.client

    func placeOrder(items: [CartItem], total: Double, notes: String?) async throws {
        // GET CURRENT USER
        // need to know who is ordering.
        // if this fails, the isn't logged in
        
        let user = try await client.auth.session.user
        
        print(
            "Creating Order for user: \(user.id)"
        )
        
        // CREATE ORDER HERE
        let newOrder = Order(
            id: nil,
            status: "new",
            total: total,
            notes: notes,
            userId: user.id,
            createdAt: nil
        )
        
        // Insert and return the new Order so we can get its ID
        let orderResponse: Order = try await client
            .from("orders")
            .insert(newOrder)
            .select() // ask DB to send back the created row
            .single() // expect exactly one row
            .execute()
            .value
        
        guard let orderId = orderResponse.id else {
            throw URLError(
                .badServerResponse
            )
        }
        print(
            "Order Created! ID: \(orderId)"
        )
        
        // CREATE THE ORDER ITEMS
        // Convert local CartItems into database rows
        let orderItems = items.map { item in
            OrderItemCallback(
                order_id: orderId,
                menu_item_id: item.menuItem.id ?? 0,
                quantity: item.quantity,
                unit_price: item.menuItem.price
            )
        }
        
        // Bulk insert all items at once
        try await client
            .from("order_items")
            .insert(
                orderItems
            )
            .execute()
        
        print("Order Items Saved!")
    }
}
