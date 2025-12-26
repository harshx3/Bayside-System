//
//  Bayside_UserApp.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/11/25.
//

import SwiftUI
import Supabase

@main
struct Bayside_UserApp: App {
    
    // Testing the database connection
    // This will run asa the app launches.
    // we touch 'SupabaseManager.shared' to force it to wake up and connect
    
    // Initialize the Cart Manager here (The Owner)
    @StateObject private var cartManager = CartManager()
    
    init() {
            // TEST: Hardcoded Login (Existing User)
            Task {
                
                let email = "admin@bayside.com"
                let password = "admin123"
                
                // 0. CLEANUP: Clear old sessions
                try? await SupabaseManager.shared.client.auth.signOut()
                
                do {
                    // 1. Log In
                    try await SupabaseManager.shared.client.auth.signIn(
                        email: email,
                        password: password
                    )
                    print("✅ Success! Signed in as Admin.")
                } catch {
                    print("🔴 LOGIN ERROR: \(error)")
                    print("Check that 'admin@bayside.com' exists in Supabase -> Auth -> Users")
                }
            }
        }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
            
            // Pass ito down to all child views.
                .environmentObject(cartManager)
          
        }
       
    }
}
