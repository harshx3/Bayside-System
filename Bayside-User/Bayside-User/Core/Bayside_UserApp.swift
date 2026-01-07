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
    // This will run as the app launches.
    // we touch 'SupabaseManager.shared' to force it to wake up and connect
    
    // Initialize the Cart Manager here (The Owner)
    // Global Managers
    @StateObject private var cartManager = CartManager()
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            // THE ROUTER
            if authViewModel.isAuthenticated {
                MainTabView()
                    .environmentObject(cartManager)
                    .environmentObject(
                        authViewModel
                    )
                    .transition(
                        .move(
                            edge: .trailing
                        )
                    )
            } else {
                LoginView(
                    viewModel: authViewModel
                )
                .transition(
                    .move(
                        edge: .leading
                    )
                )
            }
                
          
        }
       
    }
}
