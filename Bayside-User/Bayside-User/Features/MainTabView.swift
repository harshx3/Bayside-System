//
//  ContentView.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/11/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
      
            TabView {
                // MENU
               Text("Home")
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                
               MenuView()
                    .tabItem {
                        Label("Menu", systemImage: "fork.knife")
                    }
                
                Text("My Orders")
                    .tabItem {
                        Label("My Orders", systemImage: "list.clipboard")
                    }
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.crop.circle")
                    }
                CartView()
                    .tabItem {
                        Label(
                            "Order",
                            systemImage: "bag"
                        )
                    }
                    .badge(
                        cartManager.items.isEmpty ? 0 : cartManager.items.count
                    )
               
            }
            .tint(.blue)
        
    }
}

#Preview {
    MainTabView()
}
