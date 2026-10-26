import SwiftUI

struct HomeNowPlayingView: View {
    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(Color.aquamarine)
                .frame(width: 14, height: 14)
                .shadow(color: Color.aquamarine.opacity(0.8), radius: 5)

            Image(systemName: "music.note")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(Color.loginMutedText)

            Text("home.now_playing.title")
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(.white)
                .lineLimit(1)

            Spacer(minLength: 4)

            Text("home.now_playing.badge")
                .font(.system(size: 11, weight: .bold, design: .rounded))
                .foregroundColor(Color.aquamarine)
                .padding(.horizontal, 9)
                .padding(.vertical, 5)
                .background(Color.aquamarine.opacity(0.12))
                .overlay(Capsule().stroke(Color.aquamarine.opacity(0.55), lineWidth: 1))
                .clipShape(Capsule())
        }
        .padding(.horizontal, 14)
        .frame(height: 42)
        .background(Color.loginCardBackground)
        .overlay(
            Capsule().stroke(Color.loginCardBorder, lineWidth: 1)
        )
        .clipShape(Capsule())
    }
}
