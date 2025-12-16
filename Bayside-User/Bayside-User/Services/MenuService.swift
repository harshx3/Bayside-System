//
//  MenuService.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/14/25.
//

import Foundation
import Supabase

// This service handles all "Food" related data.
// It is the only part of the app allowed to talk to the 'menu_items' table.

class MenuService {
    
    // Using the Singleton we created earlier to get the client
    private let client = SupabaseManager.shared.client
    
    // Fetch Categories (The Tabs)
    func fetchCategories() async throws -> [MenuCategory] {
        print("Fetching Categories...")
        
        let categories: [MenuCategory] = try await client
            .from("categories")
            .select()
            .order("sort_order", ascending: true)
            .execute()
            .value
        
        return categories
    }
    
    // FETCH: Get all food items
    func fetchMenu() async throws -> [MenuItem] {
        print("Fetching menu from Suapbase...")
        
        // Select * from menu_items Order by name ASC
        let response: [MenuItem] = try await client
            .from("menu_items")
            .select() // Select all columns
            .eq("is_available", value: true)
            .order("name", ascending: true)
            .execute()
            .value
        
        print("Fetched \(response.count) items")
        return response
    }
}
