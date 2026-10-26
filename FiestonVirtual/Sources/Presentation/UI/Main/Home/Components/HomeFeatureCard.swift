import SwiftUI

struct HomeFeatureCard: View {
    let category: Category
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: category.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(category.accentColor)
                        .frame(width: 48, height: 48)
                        .background(category.accentColor.opacity(0.18))
                        .overlay(
                            RoundedRectangle(cornerRadius: 14)
                                .stroke(category.accentColor.opacity(0.75), lineWidth: 1)
                        )
                        .cornerRadius(14)

                    Spacer()

                    Image(systemName: "arrow.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color.loginIconMuted)
                }

                Spacer()

                Text(LocalizedStringKey(category.titleKey))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text(LocalizedStringKey(category.subtitleKey))
                    .font(.system(size: 13, weight: .regular, design: .rounded))
                    .foregroundColor(Color.loginMutedText)
                    .lineLimit(1)
                    .padding(.top, 4)

                Text(LocalizedStringKey(category.badgeKey))
                    .font(.system(size: 11, weight: .semibold, design: .rounded))
                    .foregroundColor(category.accentColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(category.accentColor.opacity(0.14))
                    .overlay(
                        Capsule().stroke(category.accentColor.opacity(0.55), lineWidth: 1)
                    )
                    .clipShape(Capsule())
                    .padding(.top, 9)
            }
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 196, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [category.accentColor.opacity(0.16), Color.loginCardBackground],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.loginCardBorder, lineWidth: 1)
            )
            .cornerRadius(22)
        }
        .buttonStyle(.plain)
    }
}

struct Category: Identifiable {
    let id = UUID()
    let titleKey: String
    let subtitleKey: String
    let badgeKey: String
    let icon: String
    let accentColor: Color
    let destinationIndex: Int
}
