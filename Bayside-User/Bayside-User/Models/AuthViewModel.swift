//
//  AuthViewModel.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/26/25.
//


import Foundation
import Combine
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    // FORM STATE
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // AUTH STATUS
    // The View will watch this to know when to switch screens
    @Published var isAuthenticated = false
    
    private let client = SupabaseManager.shared.client
    
    // SIGN IN
    func signIn() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await client.auth
                .signIn(
                    email: email,
                    password: password
                )
            isAuthenticated = true
            print("LOGIN SUCCESSFUL!")
        } catch {
            errorMessage = "LOGIN FAILED: \(error.localizedDescription)"
            isAuthenticated = false
        }
        isLoading = false
    }
    
    // SIGN UP
    func signUp() async {
        isLoading = true
        errorMessage = nil
        
        do {
            try await client.auth
                .signUp(
                    email: email,
                    password: password
                )
            isAuthenticated = true
            print("ACCOUNT CREATED")
        } catch {
            errorMessage = "SIGN UP FAILED: \(error.localizedDescription)"
        }
        isLoading = false
    }
    
    // SIGN OUT
    func signOut() async {
        try? await client.auth
            .signOut()
        isAuthenticated = false
        email = ""
        password = ""
    }
}
