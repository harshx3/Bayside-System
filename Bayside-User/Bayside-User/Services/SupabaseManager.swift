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
        
        
        let databaseURL = (Bundle.main.object(forInfoDictionaryKey: "API_URL") as? String)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let anonKey = (Bundle.main.object(forInfoDictionaryKey: "ANON_KEY") as? String)?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        
        //validate and prepend "https://
        guard let url = URL(string: "https://" + databaseURL) else {
            fatalError("FATAL ERROR: Supabase URL is missing or invalid in Info.plist/Config.xcconfig. Check API_URL")
        }
        self.client = SupabaseClient(supabaseURL: url, supabaseKey: anonKey)
        print("Database Connected Successfully!")
    }
}
