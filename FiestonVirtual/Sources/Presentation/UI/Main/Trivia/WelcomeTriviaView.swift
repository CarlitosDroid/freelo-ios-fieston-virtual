import SwiftUI

struct WelcomeTriviaView: View {

    var onClickTriviaButton: () -> Void

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    HStack(spacing: 7) {
                        Circle()
                            .fill(Color(hex: "36FFC4"))
                            .frame(width: 11, height: 11)

                        Text("trivia.live_badge")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "36FFC4"))

                        Spacer()
                    }
                    .padding(.horizontal, 12)
                    .frame(height: 27)
                    .background(
                        Capsule()
                            .fill(Color(hex: "142D2D"))
                            .overlay(
                                Capsule()
                                    .stroke(Color(hex: "36FFC4").opacity(0.55), lineWidth: 1)
                            )
                    )
                    .fixedSize(horizontal: true, vertical: false)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)

                    Text("trivia.title")
                        .font(.system(size: 48, weight: .black, design: .rounded))
                        .tracking(4)
                        .foregroundColor(Color(hex: "9CFFE6"))
                        .shadow(color: Color(hex: "36FFC4").opacity(0.65), radius: 16)
                        .padding(.top, 12)

                    Text("trivia.subtitle")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color(hex: "E4E1E7"))
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal, 24)
                        .padding(.top, 12)

                    Image("WelcomeTrivia")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 290, maxHeight: 270)
                        .padding(.top, 25)
                        .shadow(color: Color(hex: "36FFC4").opacity(0.16), radius: 22)

                    HStack(spacing: 6) {
                        Text("🔥")
                            .font(.system(size: 15))

                        Text("trivia.players_now")
                            .font(.system(size: 12, weight: .bold, design: .rounded))
                            .foregroundColor(Color(hex: "36FFC4"))
                    }
                    .padding(.horizontal, 14)
                    .frame(height: 34)
                    .background(
                        Capsule()
                            .fill(Color(hex: "20282B"))
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.15), lineWidth: 1)
                            )
                    )
                    .padding(.top, 8)

                    HStack(spacing: 12) {
                        TriviaInfoCard(
                            icon: "timer",
                            iconColor: Color(hex: "36FFC4"),
                            value: "60s",
                            title: "trivia.time_per_question"
                        )

                        TriviaInfoCard(
                            icon: "trophy.fill",
                            iconColor: Color(hex: "FFD000"),
                            value: "500 pts",
                            title: "trivia.party_prize"
                        )
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 13)

                    Button(action: onClickTriviaButton) {
                        HStack(spacing: 18) {
                            Text("trivia.play")
                                .font(.system(size: 25, weight: .black, design: .rounded))
                                .tracking(1)

                            Image(systemName: "play.fill")
                                .font(.system(size: 16, weight: .bold))
                        }
                        .foregroundColor(Color(hex: "11151A"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 66)
                        .background(
                            Capsule()
                                .fill(Color(hex: "FFD000"))
                                .shadow(color: Color(hex: "FFD000").opacity(0.42), radius: 16)
                        )
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)
                    .padding(.top, 21)
                    .padding(.bottom, max(20, geometry.safeAreaInsets.bottom + 8))
                }
                .frame(minHeight: geometry.size.height)
            }
        }
    }
}

private struct TriviaInfoCard: View {

    let icon: String
    let iconColor: Color
    let value: String
    let title: LocalizedStringKey

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(iconColor)
                .frame(height: 25)

            Text(value)
                .font(.system(size: 24, weight: .black, design: .rounded))
                .foregroundColor(Color.white)

            Text(title)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(Color(hex: "D8D8DC"))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 112)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "161E20").opacity(0.9))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white.opacity(0.14), lineWidth: 1)
                )
        )
    }
}

struct WelcomeTriviaView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeTriviaView { }
            .preferredColorScheme(.dark)
    }
}
