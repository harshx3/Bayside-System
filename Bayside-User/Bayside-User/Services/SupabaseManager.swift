//
//  SupabaseManager.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/11/25.
//

import Foundation
import Supabase

final class SupabaseManager {
    
    // The Singleton Instance
    // Anywhere in the app, you call SupabaseManager.shared to the database.
    static let shared = SupabaseManager()
    
    // The actual worker that talk to the database
    let client: SupabaseClient
    
    // Initialization
    // This prevents anyone from writing 'SupabaseManager()' manually.
    // You must use 'SupabaseManager.shared'; This guarantees only ONE connection exists.
    private init() {
        
        // Load the keys safely from the Info.plist
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String,
              let key = Bundle.main.object(forInfoDictionaryKey: "ANON_KEY") as? String,
              let url = URL(string: urlString) else {
            fatalError("API key or URL missing!")
        }
        self.client = SupabaseClient(supabaseURL: url, supabaseKey: key)
        print("Database Connected Successfully!")
    }
}
