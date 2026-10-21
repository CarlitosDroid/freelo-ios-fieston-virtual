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
    
    @State private var nombre: String = ""
    @State private var eventCode: String = ""
    @State private var showPassword = false
    @State private var showingAlert = false
    @State private var showRegister = false
    
    var body: some View {
        ZStack {
            Color(hex: "060D36")
                .ignoresSafeArea()

            GeometryReader { geometry in
                VStack(spacing: 0) {
                    VStack(spacing: 8) {
                        Image("Fieston")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 230, height: 105)

                        Rectangle()
                            .fill(Color(hex: "FFD43B"))
                            .frame(width: 26, height: 4)
                            .cornerRadius(2)

                        Text("F I E S T O N")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .tracking(7)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color(hex: "FFD15B"))

                        Text("V I R T U A L .COM")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .tracking(5)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color(hex: "36D5F4"))

                        Text("Tu evento digital, llevado a otro nivel")
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .foregroundColor(Color(hex: "A9B3D2"))
                            .padding(.top, 8)
                    }
                    .padding(.top, 28)
                    .padding(.bottom, 38)

                    VStack(alignment: .leading, spacing: 22) {
                        LoginField(
                            title: "NOMBRE O USUARIO",
                            placeholder: "Ingresa tu nombre o email",
                            text: $nombre,
                            icon: "person"
                        )

                        LoginField(
                            title: "CONTRASEÑA",
                            placeholder: "••••••••••••",
                            text: $eventCode,
                            icon: "lock",
                            isSecure: !showPassword,
                            keyboardType: .numberPad,
                            trailingIcon: showPassword ? "eye.slash" : "eye",
                            trailingAction: { showPassword.toggle() }
                        )

                        Button("¿Olvidaste tu contraseña?") {
                            // Recuperación aún no forma parte del flujo existente.
                        }
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color(hex: "1ED7F2"))
                        .frame(maxWidth: .infinity, alignment: .trailing)

                        Button(action: {
                            viewModel.verifyCode(code: eventCode)
                        }) {
                            HStack(spacing: 12) {
                                Text("Iniciar Sesión")
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 22, weight: .bold))
                            }
                            .font(.system(size: 23, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 70)
                            .background(
                                LinearGradient(
                                    colors: [Color(hex: "16C39F"), Color(hex: "0FB6D2")],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(25)
                        }

                        HStack(spacing: 10) {
                            Rectangle().fill(Color(hex: "364269")).frame(height: 1)
                            Text("C O N É C T A T E\nC O N")
                                .font(.system(size: 15, weight: .medium, design: .rounded))
                                .foregroundColor(Color(hex: "AAB5D4"))
                                .multilineTextAlignment(.center)
                                .fixedSize()
                            Rectangle().fill(Color(hex: "364269")).frame(height: 1)
                        }
                        .padding(.top, 4)

                        HStack(spacing: 18) {
                            SocialButton(title: "Google", icon: "G")
                            SocialButton(title: "Apple", icon: "apple.logo")
                        }
                    }
                    .padding(.horizontal, 36)
                    .padding(.vertical, 32)
                    .background(Color(hex: "0C1945").opacity(0.9))
                    .overlay(
                        RoundedRectangle(cornerRadius: 34)
                            .stroke(Color(hex: "273665"), lineWidth: 1.5)
                    )
                    .cornerRadius(34)

                    Button(action: {
                        showRegister = true
                    }) {
                        HStack(spacing: 5) {
                            Text("¿No tienes una cuenta?")
                            Text("Regístrate")
                                .foregroundColor(Color(hex: "FFD43B"))
                                .fontWeight(.bold)
                                .underline()
                        }
                        .font(.system(size: 17, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                        .foregroundColor(Color(hex: "D4D9ED"))
                    }
                    .padding(.top, 34)
                    .padding(.bottom, 22)
                }
                .padding(.horizontal, 22)
                .frame(width: geometry.size.width, height: geometry.size.height)
                .scaleEffect(
                min(
                    1,
                    min(
                        geometry.size.width / 390,
                        geometry.size.height / 850
                    )
                )
                )
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
                dismissButton: .default(Text("Aceptar"))
            )
        }
        .onAppear {
            self.viewModel.verifySession()
        }
    }
}

private struct LoginField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let icon: String
    var isSecure = false
    var keyboardType: UIKeyboardType = .default
    var trailingIcon: String?
    var trailingAction: (() -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundColor(Color(hex: "D9DDF0"))

            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 23))
                    .foregroundColor(Color(hex: "AAB5D4"))
                    .frame(width: 26)

                Group {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                    } else {
                        TextField(placeholder, text: $text)
                    }
                }
                .keyboardType(keyboardType)
                .font(.system(size: 18, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.75)
                .foregroundColor(Color(hex: "D9DDF0"))

                if let trailingIcon = trailingIcon, let trailingAction = trailingAction {
                    Button(action: trailingAction) {
                        Image(systemName: trailingIcon)
                            .font(.system(size: 21))
                            .foregroundColor(Color(hex: "AAB5D4"))
                    }
                }
            }
            .padding(.horizontal, 18)
            .frame(height: 72)
            .background(Color(hex: "080F38").opacity(0.65))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color(hex: "273665"), lineWidth: 1.5)
            )
            .cornerRadius(25)
        }
    }
}

private struct SocialButton: View {
    let title: String
    let icon: String

    var body: some View {
        Button(action: {}) {
            HStack(spacing: 12) {
                if icon == "G" {
                    Text(icon)
                        .font(.system(size: 23, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "4285F4"))
                } else {
                    Image(systemName: icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white)
                }
                Text(title)
                    .font(.system(size: 17, weight: .medium, design: .rounded))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                    .foregroundColor(Color(hex: "D9DDF0"))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 58)
            .background(Color(hex: "202A55"))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Color(hex: "364269"), lineWidth: 1.5)
            )
            .cornerRadius(18)
        }
    }
}

struct CodeVerificationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CodeVerificationView()
    }
}
