//
//  WelcomeView.swift
//  FiestonVirtual
//

import SwiftUI
import KingfisherSwiftUI

struct WelcomeView: View {

    @Binding var welcome: Welcome
    @Binding var showSheet: Bool

    var body: some View {
        Color.clear
            .frame(width: 1, height: 1)
            .sheet(isPresented: $showSheet) {
                GeometryReader { geometry in
                    let compact = geometry.size.height < 700

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

                        VStack(spacing: compact ? 14 : 20) {
                            HStack {
                                Spacer()

                                Button(action: {
                                    showSheet = false
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

                            VStack(spacing: compact ? 8 : 12) {
                                Image("IconoFieston")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(
                                        width: compact ? 72 : 88,
                                        height: compact ? 72 : 88
                                    )

                                Text("F I E S T O N")
                                    .font(
                                        .system(
                                            size: compact ? 25 : 29,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .tracking(compact ? 4 : 6)
                                    .foregroundColor(Color.loginBrandYellow)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.7)

                                (
                                    Text(NSLocalizedString("login.brand.virtual", comment: "Virtual brand name"))
                                        .foregroundColor(Color.loginBrandTurquoise)
                                    + Text(NSLocalizedString("login.brand.domain", comment: "Brand domain"))
                                        .foregroundColor(Color.loginBrandPurple)
                                )
                                .font(.system(size: 12, weight: .bold, design: .rounded))
                                .tracking(3)
                            }

                            VStack(spacing: compact ? 14 : 20) {
                                Text(NSLocalizedString("welcome.title", comment: "Welcome event title"))
                                    .font(
                                        .system(
                                            size: compact ? 22 : 26,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundColor(Color.loginBrandYellow)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(3)
                                    .minimumScaleFactor(0.7)

                                Text(NSLocalizedString("welcome.description", comment: "Welcome event description"))
                                    .font(
                                        .system(
                                            size: compact ? 15 : 17,
                                            weight: .semibold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundColor(Color.loginBrandTurquoise)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(5)
                                    .minimumScaleFactor(0.75)

                                Group {
                                    if let imageURL = URL(string: welcome.imageUrl),
                                       !welcome.imageUrl.isEmpty {
                                        KFImage(imageURL)
                                            .resizable()
                                            .renderingMode(.original)
                                            .aspectRatio(contentMode: .fit)
                                    } else {
                                        Image("IconoFieston")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(20)
                                    }
                                }
                                .frame(
                                    maxWidth: compact ? 145 : 180,
                                    maxHeight: compact ? 145 : 180
                                )
                                .background(Color.loginLogoPanel.opacity(0.65))
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color.loginCardBorder, lineWidth: 1)
                                )

                                Text(NSLocalizedString("welcome.subtitle", comment: "Welcome event prize"))
                                    .font(
                                        .system(
                                            size: compact ? 15 : 17,
                                            weight: .bold,
                                            design: .rounded
                                        )
                                    )
                                    .foregroundColor(Color.loginBrandYellow)
                                    .multilineTextAlignment(.center)
                                    .lineLimit(4)
                                    .minimumScaleFactor(0.75)
                            }
                            .padding(.horizontal, compact ? 18 : 24)
                            .padding(.vertical, compact ? 20 : 26)
                            .frame(maxWidth: .infinity)
                            .background(Color.loginCardBackground.opacity(0.82))
                            .overlay(
                                RoundedRectangle(cornerRadius: 24)
                                    .stroke(Color.loginCardBorder.opacity(0.8), lineWidth: 1)
                            )
                            .cornerRadius(24)

                            Button(action: {
                                showSheet = false
                            }) {
                                Text(NSLocalizedString("welcome.continue", comment: "Continue button"))
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                    .foregroundColor(Color.loginButtonText)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: compact ? 52 : 56)
                                    .background(Color.loginButtonBackground)
                                    .cornerRadius(15)
                            }
                            .buttonStyle(.plain)

                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, compact ? 18 : 26)
                        .padding(.top, compact ? 10 : 18)
                    }
                    .preferredColorScheme(.dark)
                }
            }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(
            welcome: .constant(
                Welcome(
                    title: "Bienvenido al evento",
                    description: "Disfruta esta experiencia virtual.",
                    subtitle: "¡Esperamos que lo disfrutes!",
                    imageUrl: ""
                )
            ),
            showSheet: .constant(true)
        )
    }
}
