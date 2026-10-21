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
                    Color(hex: "123B46"),
                    Color(hex: "0E172F"),
                    Color(hex: "180B2D")
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
                                .fill(Color(hex: "30445B").opacity(0.8))
                                .frame(width: compact ? 64 : 80, height: compact ? 64 : 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color(hex: "6673B4").opacity(0.7), lineWidth: 1)
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
                                    .fill(Color(hex: "FFD533"))
                                    .frame(width: compact ? 15 : 18, height: 3)
                                    .offset(y: compact ? -5 : -6)
                            }

                            Text("N")
                        }
                        .font(.system(size: compact ? 28 : 31, weight: .bold, design: .rounded))
                        .foregroundColor(Color(hex: "FFD84D"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                        (
                            Text("VIRTUAL  •  ")
                                .foregroundColor(Color(hex: "2DE5BF"))
                            + Text(".COM")
                                .foregroundColor(Color(hex: "9358F7"))
                        )
                        .font(.system(size: compact ? 12 : 13, weight: .bold, design: .rounded))
                        .tracking(3)
                        .lineLimit(1)
                    }

                    Text("•  PASE DE ENTRADA · EVENTO EXCLUSIVO")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(Color(hex: "D3D4E2"))
                        .padding(.horizontal, 14)
                        .padding(.vertical, 6)
                        .background(Color(hex: "31334D").opacity(0.75))
                        .overlay(
                            Capsule()
                                .stroke(Color(hex: "5A547B").opacity(0.8), lineWidth: 1)
                        )
                        .clipShape(Capsule())
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                    VStack(alignment: .leading, spacing: compact ? 16 : 20) {
                        Label("CÓDIGO DE INVITACIÓN", systemImage: "ticket.fill")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "D8D5E6"))
                            .labelStyle(InvitationLabelStyle())

                        HStack(spacing: 13) {
                            Image(systemName: "key")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(Color(hex: "9BA0B8"))

                            TextField("Ingresa tu código (ej. GA-2025)", text: $eventCode)
                                .font(.system(size: 16, weight: .semibold, design: .rounded))
                                .foregroundColor(Color(hex: "F3F1F8"))
                                .keyboardType(.numberPad)
                                .textInputAutocapitalization(.characters)
                                .lineLimit(1)
                                .minimumScaleFactor(0.7)
                        }
                        .padding(.horizontal, 16)
                        .frame(height: compact ? 58 : 64)
                        .background(Color(hex: "0E0A1B").opacity(0.8))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color(hex: "4A415E"), lineWidth: 1)
                        )
                        .cornerRadius(16)

                        Button(action: {
                            viewModel.verifyCode(code: eventCode)
                        }) {
                            HStack(spacing: 12) {
                                Text("ENTRAR AL EVENTO")
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 19, weight: .bold))
                            }
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "071A25"))
                            .frame(maxWidth: .infinity)
                            .frame(height: compact ? 56 : 58)
                            .background(Color(hex: "10D7AF"))
                            .cornerRadius(15)
                        }

                        Divider()
                            .overlay(Color(hex: "453C57"))

                        Label("Acceso cifrado y verificado en tiempo real", systemImage: "lock.fill")
                            .font(.system(size: 13, weight: .regular, design: .rounded))
                            .foregroundColor(Color(hex: "AAA8BB"))
                            .labelStyle(InvitationLabelStyle())
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.horizontal, compact ? 20 : 24)
                    .padding(.vertical, compact ? 20 : 24)
                    .background(Color(hex: "211A31").opacity(0.82))
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color(hex: "524663").opacity(0.8), lineWidth: 1)
                    )
                    .cornerRadius(24)

                    VStack(spacing: compact ? 14 : 18) {
                        HStack(spacing: 4) {
                            Image(systemName: "questionmark.circle")
                                .foregroundColor(Color(hex: "9358F7"))
                            Text("¿No tienes un código?")
                            Button(action: {
                                showRegister = true
                            }) {
                                Text("Solicita acceso")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(hex: "1FE7BF"))
                                    .overlay(
                                        Rectangle()
                                            .fill(Color(hex: "1FE7BF"))
                                            .frame(height: 1)
                                            .offset(y: 2),
                                        alignment: .bottom
                                    )
                            }
                            .buttonStyle(.plain)
                        }
                        .font(.system(size: 14, design: .rounded))
                        .foregroundColor(Color(hex: "D5D1E0"))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)

                        Label("Centro de Soporte y Ayuda", systemImage: "headphones")
                            .font(.system(size: 13, design: .rounded))
                            .foregroundColor(Color(hex: "ACA9BB"))
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
                dismissButton: .default(Text("Aceptar"))
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
                .foregroundColor(Color(hex: "25E5C1"))
            configuration.title
        }
    }
}

struct CodeVerificationView_Previews: PreviewProvider {
    
    static var previews: some View {
        CodeVerificationView()
    }
}
