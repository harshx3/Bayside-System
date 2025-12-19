//
//  CartView.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/18/25.
//

import SwiftUI
import Foundation

struct CartView: View {
    // Listen to the Manager
     @EnvironmentObject var cartManager: CartManager
    var body: some View {
       
        NavigationStack {
            VStack {
                if cartManager.items.isEmpty {
                    // EmptyState
                    EmptyView()
                }
                else {
                    // Cart list
                    List {
                        ForEach(cartManager.items) { item in
                            HStack {
                                // Quantity Badge
                                Text(
                                    "\(item.quantity)x"
                                )
                                .fontWeight(
                                    .bold
                                )
                                .frame(
                                    width: 30
                                )
                                
                                VStack(
                                    alignment: .leading
                                ) {
                                    Text(
                                        item.menuItem
                                            .name)
                                    .fontWeight(
                                        .semibold
                                    )
                                    if let notes = item.notes {
                                        Text(notes)
                                            .font(.caption)
                                            .foregroundStyle(
                                                .gray
                                            )
                                    }
                                }
                                Spacer()
                                
                                Text(
                                    String(
                                        format: "$%.2f",
                                        item.total
                                    )
                                )
                            }
                        }
                        .onDelete(
                            perform: deleteItems
                        )
                    }
                    VStack(spacing: 12) {
                        HStack {
                            Text("Total")
                                .font(
                                    .title2
                                )
                                .fontWeight(
                                    .bold
                                )
                            Spacer()
                            Text(
                                String(
                                    format: "$%.2f",
                                    cartManager.total
                                )
                            )
                            .font(
                                .title2
                            )
                            .fontWeight(
                                .bold
                            )
                            .foregroundStyle(
                                .blue
                            )
                        }
                        .padding(
                            .horizontal
                        )
                        
                        Button(action: {
                            print("Proceeding to Checkout...")
                        }) {
                            Text("Checkout")
                                .font(
                                    .headline
                                )
                                .foregroundStyle(
                                    .white
                                )
                                .frame(
                                    maxWidth: .infinity
                                )
                                .padding()
                                .background(
                                    Color.blue
                                )
//                                .clipShape()
                        }
                        .padding(
                            .horizontal
                        )
                    }
                    .padding(
                        .bottom
                    )
                    .background(
                        Color(
                            uiColor: .systemBackground
                        )
                        .shadow(
                            radius: 2
                        )
                    )
                }
            }
            .navigationTitle("My Order")
            // Add and "Edit" button to the top right to easily delete items
            .toolbar {
                EditButton()
            }
        }
        
    }
    
    private func deleteItems(at offsets: IndexSet) {
        // Map the index to the CartItems ID
        let idsToDelete = offsets.map { cartManager.items[$0].id }
        
        // remove them one by one
        for id in idsToDelete {
            cartManager.removeFromCart(id: id)
        }
    }
}

#Preview {
    CartView()
        .environmentObject(
            CartManager()
        )
}
