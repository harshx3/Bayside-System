//
//  MenuViewModel.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/15/25.
//


import Foundation
import SwiftUI
import Combine

// @MainActor - Ensure all updates happen on the "Main Thread" (UI Thread).
// If we updated the UI from a background thread, the app would crash.

@MainActor
class MenuViewModel: ObservableObject {
    
    // State Properties
    // @Published: When these change, the screen automatically reloads.
    @Published var categories: [MenuCategory] = []
    @Published var items: [MenuItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
     // The Worker
    private let service = MenuService()
    
    // Intents (Actions)
    func loadData() async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            // async let: Run both fetches at the SAME time (Parallel), not one by one.
            // This is faster.
            async let fetchedCategories = service.fetchCategories()
            async let fetchedItems = service.fetchMenu()
            
            // wait for both to finish
            let (cats, food) = try await (fetchedCategories, fetchedItems)
            
            self.categories = cats
            self.items = food
            
        } catch {
            self.errorMessage = "Failed to load menu: \(error.localizedDescription)"
        }
        self.isLoading = false
    }
    
    // Filter items for specific category
    func items(for categoryId: Int64) -> [MenuItem] {
        return items.filter {$0.categoryId == categoryId}
    }
}
