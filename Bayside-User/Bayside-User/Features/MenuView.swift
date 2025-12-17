//
//  MenuView.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/16/25.
//

import SwiftUI

struct MenuView: View {
    // 🧠 ENGINEER NOTE:
    // We use @StateObject here because this View 'owns' the ViewModel.
    // It will keep the data alive as long as this screen is on display.
    @StateObject private var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Color
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("Loading Menu...")
                } else if let error = viewModel.errorMessage {
                    // Error State (e.g., No Internet)
                    VStack(spacing: 16) {
                        Image(systemName: "wifi.slash")
                            .font(.largeTitle)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await viewModel.loadData() }
                        }
                    }
                    .padding()
                } else {
                    // ✅ THE MAIN CONTENT
                    mainMenuList
                }
            }
            .navigationTitle("Bayside Deli")
            // 🚀 KICKSTART: Load data when the view appears
            .task {
                await viewModel.loadData()
            }
        }
    }
    
    // MARK: - Subviews
    // We break the UI into smaller pieces to keep the 'body' clean.
    
    private var mainMenuList: some View {
        ScrollView {
            // 'LazyVStack' is crucial for performance.
            // It only renders the burgers currently visible on screen.
            // 'pinnedViews: .sectionHeaders' makes the Category stick to the top!
            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                
                ForEach(viewModel.categories) { category in
                    Section {
                        // The items in this category
                        let items = viewModel.items(for: category.id)
                        
                        ForEach(items) { item in
                            MenuItemView(item: item)
                            Divider() // Line between items
                                .padding(.leading)
                        }
                        
                    } header: {
                        // The Sticky Header
                        CategoryHeaderView(category: category)
                    }
                }
            }
        }
    }
}

// MARK: - Helper Views
// These are small components just for this screen.

struct CategoryHeaderView: View {
    let category: MenuCategory
    
    var body: some View {
        HStack(spacing: 8) {
            // 🧠 ENGINEER NOTE:
            // We store "SF Symbol" names in the database (e.g., "flame.fill").
            // This lets us change the icons remotely without updating the app!
            if let iconName = category.iconName {
                Image(systemName: iconName)
                    .foregroundColor(.blue)
            }
            
            Text(category.name)
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Spacer()
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(.ultraThinMaterial) // The "Frosted Glass" blur effect
    }
}

struct MenuItemView: View {
    let item: MenuItem
    
    var body: some View {
        HStack(spacing: 12) {
            // 1. Text Info
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                
                if let desc = item.description {
                    Text(desc)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(2) // Don't take up too much space
                }
                
                Text(String(format: "$%.2f", item.price))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            // 2. Image (Placeholder for now)
            // We will hook up the real images next!
            if let _ = item.imageURL {
                AsyncImage(url: URL(string: item.imageURL ?? "")) { image in
                    image.resizable()
                         .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .clipped()
            }
        }
        .padding()
        .background(Color(uiColor: .secondarySystemGroupedBackground))
    }
}

#Preview {
    MenuView()
}
