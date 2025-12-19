//
//  Bayside_UserApp.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/11/25.
//

import SwiftUI

@main
struct Bayside_UserApp: App {
    
    // Testing the database connection
    // This will run asa the app launches.
    // we touch 'SupabaseManager.shared' to force it to wake up and connect
    
    // Initialize the Cart Manager here (The Owner)
    @StateObject private var cartManager = CartManager()
    
   
    var body: some Scene {
        WindowGroup {
            MainTabView()
            
            // Pass ito down to all child views.
                .environmentObject(cartManager)
        }
    }
}
