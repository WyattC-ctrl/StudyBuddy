//
//  ResetPw.swift
//  StudyBuddy
//
//  Created by Aishah A on 11/25/25.
//

import SwiftUI

struct ResetPw: View {
    @Environment(\.dismiss) private var dismiss

    @State private var username: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showNewPassword: Bool = false
    @State private var showConfirmPassword: Bool = false

    private let brandRed = Color(hex: 0x9E122C)
    private let fieldBorder = Color(.systemGray3)

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Logo
                    Image("StudyBuddySignUpLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180, height: 120)
                        .padding(.top, 24)

                    // Titles
                    VStack(spacing: 6) {
                        Text("Change your password")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)

                        Text("Enter a new password below to change a password")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 28)
                    }

                    // Form
                    VStack(spacing: 14) {
                        // Username or Email
                        TextField("Username or Email", text: $username)
                            .keyboardType(.emailAddress)
                            .textContentType(.username)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(fieldBorder, lineWidth: 1)
                            )

                        // New Password
                        HStack {
                            Group {
                                if showNewPassword {
                                    TextField("New password", text: $newPassword)
                                } else {
                                    SecureField("New password", text: $newPassword)
                                }
                            }
                            .textContentType(.newPassword)

                            Button {
                                withAnimation { showNewPassword.toggle() }
                            } label: {
                                Image(systemName: showNewPassword ? "eye.slash" : "eye")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(fieldBorder, lineWidth: 1)
                        )

                        // Confirm Password
                        HStack {
                            Group {
                                if showConfirmPassword {
                                    TextField("Re-enter new password", text: $confirmPassword)
                                } else {
                                    SecureField("Re-enter new password", text: $confirmPassword)
                                }
                            }
                            .textContentType(.newPassword)

                            Button {
                                withAnimation { showConfirmPassword.toggle() }
                            } label: {
                                Image(systemName: showConfirmPassword ? "eye.slash" : "eye")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(fieldBorder, lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 24)

                    // Requirements
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password must contain:")
                            .font(.headline.weight(.semibold))
                            .foregroundStyle(.primary)

                        VStack(alignment: .leading, spacing: 6) {
                            Text("At least 10 characters")
                            Text("At least one uppercase letter (A–Z)")
                            Text("At least one number (0–9)")
                        }
                        .foregroundStyle(brandRed)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)

                    // Reset Button
                    Button {
                        // TODO: Validate username/newPassword/confirmPassword and trigger reset flow
                    } label: {
                        Text("Reset password")
                            .font(.system(size: 20, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 14)
                            .foregroundColor(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(brandRed)
                            )
                            .shadow(color: brandRed.opacity(0.2), radius: 6, y: 3)
                    }
                    .padding(.horizontal, 24)

                    Spacer(minLength: 24)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle("Reset Password")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                    }
                }
            }
        }
    }
}

#Preview {
    ResetPw()
}
