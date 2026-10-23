//
//  RegisterView.swift
//  FiestonVirtual
//

import SwiftUI

struct RegisterView: View {

    var viewMode: CodeVerificationViewModel

    @Binding var showRegister: Bool

    @State private var email = ""
    @State private var password = ""

    var body: some View {
        Color.clear
            .frame(width: 1, height: 1)
            .sheet(isPresented: $showRegister) {
                ZStack {
                    LinearGradient(
                        colors: [
                            Color.loginGradientStart,
                            Color.loginGradientMiddle,
                            Color.loginGradientEnd
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .ignoresSafeArea()

                    VStack(spacing: 20) {
                        HStack {
                            Spacer()

                            Button(action: {
                                showRegister = false
                            }) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color.loginTextPrimary)
                                    .frame(width: 34, height: 34)
                                    .background(Color.loginBadgeBackground.opacity(0.8))
                                    .clipShape(Circle())
                            }
                            .buttonStyle(.plain)
                        }

                        VStack(spacing: 12) {
                            Image("IconoFieston")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)

                            Text(NSLocalizedString("register.title", comment: "Registration title"))
                                .font(.system(size: 25, weight: .bold, design: .rounded))
                                .foregroundColor(Color.loginBrandYellow)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)

                            (
                                Text(NSLocalizedString("login.brand.virtual", comment: "Virtual brand name"))
                                    .foregroundColor(Color.loginBrandTurquoise)
                                + Text(NSLocalizedString("login.brand.domain", comment: "Brand domain"))
                                    .foregroundColor(Color.loginBrandPurple)
                            )
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .tracking(3)
                        }

                        VStack(alignment: .leading, spacing: 18) {
                            RegisterField(
                                title: NSLocalizedString("register.email.title", comment: "Registration email title"),
                                placeholder: NSLocalizedString(
                                    "register.email.placeholder",
                                    comment: "Registration email placeholder"
                                ),
                                text: $email,
                                icon: "envelope"
                            )

                            RegisterField(
                                title: NSLocalizedString(
                                    "register.password.title",
                                    comment: "Registration password title"
                                ),
                                placeholder: NSLocalizedString(
                                    "register.password.placeholder",
                                    comment: "Registration password placeholder"
                                ),
                                text: $password,
                                icon: "lock",
                                isSecure: true
                            )

                            Button(action: {
                                viewMode.verifyCode(code: "719299")
                            }) {
                                Text(NSLocalizedString("register.submit", comment: "Registration submit button"))
                                    .font(.system(size: 17, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.loginButtonText)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 58)
                                    .background(Color.loginButtonBackground)
                                    .cornerRadius(15)
                            }

                            Text(NSLocalizedString("register.terms", comment: "Registration terms message"))
                                .font(.system(size: 12, design: .rounded))
                                .foregroundColor(Color.loginMutedText)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity)
                        }
                        .padding(22)
                        .background(Color.loginCardBackground.opacity(0.82))
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color.loginCardBorder.opacity(0.8), lineWidth: 1)
                        )
                        .cornerRadius(24)

                        Button(action: {
                            showRegister = false
                        }) {
                            Text(NSLocalizedString("register.back_to_login", comment: "Return to login action"))
                                .font(.system(size: 14, weight: .medium, design: .rounded))
                                .foregroundColor(Color.loginLink)
                        }
                        .buttonStyle(.plain)

                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 18)
                }
                .preferredColorScheme(.dark)
            }
    }
}

private struct RegisterField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let icon: String
    var isSecure = false

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(title)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(Color.loginTextPrimary)

            HStack(spacing: 13) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.loginIconMuted)

                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .font(.system(size: 16, design: .rounded))
                .foregroundColor(Color.loginTextPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.75)
            }
            .padding(.horizontal, 16)
            .frame(height: 58)
            .background(Color.loginFieldBackground.opacity(0.8))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.loginFieldBorder, lineWidth: 1)
            )
            .cornerRadius(16)
        }
    }
}
