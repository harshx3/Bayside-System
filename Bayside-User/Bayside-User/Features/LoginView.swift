//
//  LoginView.swift
//  Bayside-User
//
//  Created by Harsh Makwana on 12/26/25.
//

import SwiftUI

struct LoginView: View {
    // Observe the ViewModel
    @ObservedObject var viewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [
                    .blue
                        .opacity(
                            0.8
                        ),
                    .purple
                        .opacity(
                            0.8
                        )],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                //LOGO
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(
                        .white
                    )
                    .shadow(
                        radius: 10
                    )
                
                Text("Bayside Deli")
                    .font(
                        .largeTitle
                    )
                    .fontWeight(
                        .bold
                    )
                    .foregroundStyle(
                        .white
                    )
                
                // INPUT FIELDS
                VStack(spacing: 16) {
                    TextField(
                        "Email",
                        text: $viewModel.email
                    )
                    .textContentType(
                        .emailAddress
                    )
                    .keyboardType(
                        .emailAddress
                    )
                    .autocapitalization(
                        .none
                    )
                    .padding()
                    .background(
                        .ultraThinMaterial
                    )
                    .clipShape(
                        .capsule
                    )
                    
                
                    SecureField(
                        "Password",
                        text: $viewModel.password
                    )
                    .padding()
                    .background(
                        .ultraThinMaterial
                    )
                    .clipShape(
                        .capsule
                    )
                }
                .padding(
                    .horizontal
                )
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(
                            .caption
                        )
                        .padding(8)
                        .background(
                            .white
                        )
                        .clipShape(
                            .capsule
                        )
                }
                
                // BUTTONS
                VStack(spacing: 16) {
                    Button(
action: {
    Task {
        await viewModel
        .signIn() }
                    })
                    {
                        if viewModel.isLoading {
                            ProgressView()
                                .tint(
                                    .blue
                                )
                        }
                        else {
                            Text("Sign In")
                                .fontWeight(
                                    .bold
                                )
                        }
                    }
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(
                        .white
                    )
                    .foregroundStyle(
                        .blue
                    )
                    .clipShape(
                        .capsule
                    )
                    
                    Button(action: {
    Task {
        await viewModel
        .signUp() }
                    }) {
                        Text("Create Account")
                            .fontWeight(
                                .semibold
                            )
                            .foregroundStyle(
                                .white
                            )
                    }
                }
                .padding(
                    .horizontal
                )
                
                Spacer()
            }
            .padding(.top, 60)
        }
    }
}

#Preview {
    LoginView(
        viewModel: AuthViewModel())
}
