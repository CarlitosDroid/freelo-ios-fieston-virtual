import SwiftUI
import KingfisherSwiftUI

struct HomeWelcomeCard: View {
    @Binding var user: User?
    @Binding var imageUrl: String

    let onProfileImageSelected: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("home.profile.greeting")
                        .font(.system(size: 13, weight: .semibold, design: .rounded))
                        .foregroundColor(Color.loginBrandPurple)

                    Text("\(user?.name ?? "") \(user?.lastName ?? "")")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .lineLimit(1)

                    HStack(spacing: 8) {
                        HomeProfileBadge(
                            title: String(format: NSLocalizedString("home.profile.rank", comment: ""), user?.ranking ?? 0),
                            color: Color.loginAccentYellow,
                            icon: "trophy.fill"
                        )
                        HomeProfileBadge(
                            title: String(format: NSLocalizedString("home.profile.points", comment: ""), user?.totalScore ?? 0),
                            color: Color.aquamarine,
                            icon: "bolt.fill"
                        )
                    }
                    .padding(.top, 8)
                }

                Spacer()

                ZStack(alignment: .bottomTrailing) {
                    KFImage(URL(string: imageUrl))
                        .placeholder {
                            Image(systemName: "person.fill")
                                .font(.system(size: 25))
                                .foregroundColor(Color.loginMutedText)
                                .frame(width: 62, height: 62)
                                .background(Color.loginCardBackground)
                                .clipShape(Circle())
                        }
                        .resizable()
                        .scaledToFill()
                        .frame(width: 62, height: 62)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.aquamarine, lineWidth: 2))

                    Button(action: onProfileImageSelected) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 24, height: 24)
                            .background(Color.loginCardBackground)
                            .overlay(Circle().stroke(Color.aquamarine, lineWidth: 1))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                    .offset(x: 4, y: 4)
                }
            }

            Divider().background(Color.loginDivider)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("home.profile.level")
                    Spacer()
                    Text("home.profile.progress")
                        .foregroundColor(Color.loginBrandPurple)
                }
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .foregroundColor(Color.loginMutedText)

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Capsule().fill(Color.loginDivider)
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [Color.aquamarine, Color.loginBrandPurple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .frame(width: geometry.size.width * 0.78)
                    }
                }
                .frame(height: 5)
            }
        }
        .padding(20)
        .background(Color.loginCardBackground)
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.loginCardBorder, lineWidth: 1))
        .cornerRadius(22)
    }
}

private struct HomeProfileBadge: View {
    let title: String
    let color: Color
    let icon: String

    var body: some View {
        Label(title, systemImage: icon)
            .font(.system(size: 11, weight: .bold, design: .rounded))
            .foregroundColor(color)
            .padding(.horizontal, 9)
            .padding(.vertical, 5)
            .background(color.opacity(0.13))
            .overlay(Capsule().stroke(color.opacity(0.55), lineWidth: 1))
            .clipShape(Capsule())
    }
}
