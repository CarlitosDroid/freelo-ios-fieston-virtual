//
//  CodeVerificationView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/6/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct CodeVerificationView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(CodeVerificationViewModel.self)!
    
    @State private var eventCode: String = ""
    @State private var showingAlert = false
    @State private var showRegister = false
    
    var body: some View {
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

            GeometryReader { geometry in
                let compact = geometry.size.height < 700

                VStack(spacing: compact ? 12 : 18) {
                    VStack(spacing: compact ? 12 : 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.loginLogoPanel.opacity(0.8))
                                .frame(width: compact ? 64 : 80, height: compact ? 64 : 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.loginLogoBorder.opacity(0.7), lineWidth: 1)
                                )

                            Image("IconoFieston")
                                .resizable()
                                .scaledToFit()
                                .frame(width: compact ? 64 : 80, height: compact ? 64 : 80)
                        }

                        HStack(spacing: compact ? 5 : 7) {
                            ForEach(Array("FIEST"), id: \.self) { letter in
                                Text(String(letter))
                            }

                            ZStack(alignment: .top) {
                                Text("O")

                                Capsule()
                                    .fill(Color.loginAccentYellow)
                                    .frame(width: compact ? 15 : 18, height: 3)
                                    .offset(y: compact ? -5 : -6)
                            }

                            Text("N")
                        }
                        .font(.system(size: compact ? 28 : 31, weight: .bold, design: .rounded))
                        .foregroundColor(Color.loginBrandYellow)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                        (
                            Text(NSLocalizedString("login.brand.virtual", comment: "Virtual brand name"))
                                .foregroundColor(Color.loginBrandTurquoise)
                            + Text(NSLocalizedString("login.brand.domain", comment: "Brand domain"))
                                .foregroundColor(Color.loginBrandPurple)
                        )
                        .font(.system(size: compact ? 12 : 13, weight: .bold, design: .rounded))
                        .tracking(3)
                        .lineLimit(1)
                    }

                    Text(NSLocalizedString("login.entry_pass.badge", comment: "Exclusive event entry badge"))
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(Color.loginTextPrimary)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(Color.loginBadgeBackground.opacity(0.75))
                        .overlay(
                            Capsule()
                                .stroke(Color.loginBadgeBorder.opacity(0.8), lineWidth: 1)
                        )
                        .clipShape(Capsule())
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    VStack(alignment: .leading, spacing: compact ? 16 : 20) {
                        Label(
                            NSLocalizedString("login.invitation_code.title", comment: "Invitation code title"),
                            systemImage: "ticket.fill"
                        )
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color.loginTextPrimary)
                            .labelStyle(InvitationLabelStyle())

                        HStack(spacing: 13) {
                            Image(systemName: "key")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.loginIconMuted)

                            SecureField(
                                NSLocalizedString(
                                    "login.invitation_code.placeholder",
                                    comment: "Invitation code placeholder"
                                ),
                                text: $eventCode
                            )
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color.loginTextPrimary)
                                .keyboardType(.numberPad)
                                .textInputAutocapitalization(.characters)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .padding(.horizontal, 16)
                        .frame(height: compact ? 58 : 64)
                        .background(Color.loginFieldBackground.opacity(0.8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.loginFieldBorder, lineWidth: 1)
                        )
                        .cornerRadius(16)

                        Button(action: {
                            viewModel.verifyCode(code: eventCode)
                        }) {
                            HStack(spacing: 12) {
                                Text(NSLocalizedString("login.invitation_code.submit", comment: "Enter event button"))
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 19, weight: .bold))
                            }
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color.loginButtonText)
                            .frame(maxWidth: .infinity)
                            .frame(height: compact ? 56 : 58)
                            .background(Color.loginButtonBackground)
                            .cornerRadius(15)
                        }

                        Divider()
                            .overlay(Color.loginDivider)

                        Label(
                            NSLocalizedString(
                                "login.invitation_code.security_message",
                                comment: "Invitation code security message"
                            ),
                            systemImage: "lock.fill"
                        )
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(Color.loginMutedText)
                            .labelStyle(InvitationLabelStyle())
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, compact ? 20 : 24)
                    .padding(.vertical, compact ? 20 : 24)
                    .background(Color.loginCardBackground.opacity(0.82))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.loginCardBorder.opacity(0.8), lineWidth: 1)
                    )
                    .cornerRadius(24)

                    VStack(spacing: compact ? 14 : 18) {
                        HStack(spacing: 4) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(Color.loginBrandPurple)
                            Text(NSLocalizedString("login.access_request.question", comment: "Access request question"))
                            Button(action: {
                                showRegister = true
                            }) {
                                Text(NSLocalizedString("login.access_request.action", comment: "Access request action"))
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.loginLink)
                                    .overlay(
                                        Rectangle()
                                            .fill(Color.loginLink)
                                            .frame(height: 1)
                                            .offset(y: 2),
                                        alignment: .bottom
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color.loginTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                        Label(
                            NSLocalizedString("login.support.title", comment: "Support center title"),
                            systemImage: "headphones"
                        )
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(Color.loginMutedText)
                            .labelStyle(InvitationLabelStyle())
                    }
                }
                .padding(.horizontal, compact ? 18 : 28)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }

            RegisterView(viewMode: self.viewModel, showRegister: $showRegister)
        }
        .onReceive(self.viewModel.$inSession) { inSession in
            if inSession {
                NotificationCenter.default.post(name: NSNotification.Name("loginRootViewNotification"), object: nil)
            }
        }
        .onReceive(self.viewModel.$isError) { isError in
            if isError {
                self.showingAlert = true
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(self.viewModel.errorMessage),
                dismissButton: .default(
                    Text(NSLocalizedString("common.accept", comment: "Accept button"))
                )
            )
        }
        .onAppear {
            self.viewModel.verifySession()
        }
    }
}

private struct InvitationLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            configuration.icon
                .foregroundColor(Color.loginBrandTurquoise)
            configuration.title
        }
    }
}

struct CodeVerificationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CodeVerificationView()
    }
}
