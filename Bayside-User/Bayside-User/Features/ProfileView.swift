//
//  ProfileView.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 1/6/26.
//

import SwiftUI
internal import Auth
import Supabase

struct ProfileView: View {

    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Image(systemName: "person.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        VStack(alignment: .leading) {
                            Text("Signed in as")
                                .font(.caption)
                                .foregroundColor(.gray)
                            // ✅ 2. Show real email
                            Text(authViewModel.email.isEmpty ? "User" : authViewModel.email)
                                .font(.headline)
                        }
                    }
                }
                
                Section {
                    Button(role: .destructive, action: {
                        // ✅ 3. Call the ViewModel's SignOut
                        Task { await authViewModel.signOut() }
                    }) {
                        HStack {
                            Spacer()
                            Text("Log Out")
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
}
