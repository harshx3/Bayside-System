//
//  ProductDetailView.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/17/25.
//


import SwiftUI

struct ProductDetailView: View {
    
    // Get the Cart
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.dismiss) var dismiss // to close the screen
    
    let item: MenuItem
    
    // We will use this later for "Add to Cart" logic
    @State private var quantity = 1
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // 1. HERO IMAGE
                    // If we have a URL, show the big image. Otherwise, show a placeholder.
                    AsyncImage(url: URL(string: item.imageURL ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .clipped()
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 250)
                            .overlay(
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            )
                    }
                    
                    // 2. TITLE & INFO
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(String(format: "$%.2f", item.price))
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                        
                        Divider()
                        
                        Text("Description")
                            .font(.headline)
                        
                        Text(item.description ?? "No description available.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }
                    .padding()
                }
            }
            
            // 3. BOTTOM ACTION BAR (Sticky at bottom)
            VStack(spacing: 16) {
                Divider()
                
                // Quantity Stepper (Simple version)
                HStack {
                    Text("Quantity")
                        .font(.headline)
                    Spacer()
                    Stepper("", value: $quantity, in: 1...10)
                        .labelsHidden()
                    Text("\(quantity)")
                        .font(.headline)
                        .frame(width: 40)
                }
                .padding(.horizontal)
                
                // Add Button
                Button(action: addToOrder) {
                    Text("Add to Order - $\(String(format: "%.2f", item.price * Double(quantity)))")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)
            }
            .background(Color(uiColor: .systemBackground))
        }
        .ignoresSafeArea(edges: .top) // Let image go behind the status bar
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Actions
    func addToOrder() {
        cartManager
            .add(
                item: item,
                quantity: quantity,
                notes: nil
            )
        // Close the screen and go back to menu
        dismiss()
    }
}

// 🧪 PREVIEW HELPER
// Creates a fake item so we can see the design in Xcode
#Preview {
    ProductDetailView(item: MenuItem(
        id: 1,
        name: "Classic Cheese",
        description: "A delicious example burger.",
        price: 12.99,
        imageURL: nil,
        isAvailable: true,
        categoryId: 1
    ))
}
