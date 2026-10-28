import SwiftUI
import KingfisherSwiftUI

struct RankingView: View {

    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(RankingViewModel.self)!

    @State private var ranking = [Ranking]()
    @State private var userTotalScore = "0"

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

            LoadingView(isShowing: $viewModel.isLoading) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        rankingHeader
                        rankingContent
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getRanking()
        }
        .onReceive(viewModel.$getRankingResponse) { response in
            guard let response else { return }
            ranking = response.ranking.sorted { $0.position < $1.position }
            userTotalScore = response.userTotalScore
        }
    }

    private var rankingHeader: some View {
        HStack(spacing: 14) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color.rankingPrimaryText)
                    .frame(width: 40, height: 40)
                    .background(
                        Circle()
                            .fill(Color.rankingHeaderBackground)
                            .overlay(
                                Circle()
                                    .stroke(Color.white.opacity(0.16), lineWidth: 1)
                            )
                    )
            }
            .buttonStyle(.plain)

            VStack(spacing: 3) {
                Text("ranking.title")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.rankingPrimaryText)

                Text("ranking.subtitle")
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .tracking(1)
                    .foregroundColor(Color.rankingSecondaryText)
            }

            Spacer()

            HStack(spacing: 6) {
                Image(systemName: "gift.fill")
                    .font(.system(size: 13, weight: .bold))
                Text("ranking.prizes")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
            }
            .foregroundColor(Color.rankingYellow)
            .padding(.horizontal, 12)
            .frame(height: 34)
            .background(
                Capsule()
                    .fill(Color.rankingHeaderBackground)
                    .overlay(
                        Capsule()
                            .stroke(Color.rankingYellow.opacity(0.2), lineWidth: 1)
                    )
            )
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 10)
    }

    private var rankingContent: some View {
        VStack(spacing: 0) {
            Image("MainRanking")
                .resizable()
                .scaledToFit()
                .frame(width: 72, height: 72)
                .shadow(color: Color.rankingYellow.opacity(0.7), radius: 18)
                .padding(.top, 20)

            Text("ranking.honor_title")
                .font(.system(size: 40, weight: .black, design: .rounded))
                .foregroundColor(Color.rankingPrimaryText)
                .multilineTextAlignment(.center)
                .padding(.top, 10)

            Text("ranking.description")
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .foregroundColor(Color.rankingSecondaryText)
                .multilineTextAlignment(.center)
                .padding(.top, 6)

            HStack(spacing: 6) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 13, weight: .bold))
                Text(
                    String(
                        format: NSLocalizedString("ranking.score_badge", comment: ""),
                        userTotalScore
                    )
                )
                .font(.system(size: 12, weight: .bold, design: .rounded))
            }
            .foregroundColor(Color.rankingTurquoise)
            .padding(.horizontal, 14)
            .frame(height: 36)
            .background(
                Capsule()
                    .fill(Color.rankingBadgeBackground)
                    .overlay(
                        Capsule()
                            .stroke(Color.rankingTurquoise.opacity(0.55), lineWidth: 1)
                    )
            )
            .padding(.top, 16)

            LazyVStack(spacing: 10) {
                ForEach(ranking) { item in
                    RankingRow(ranking: item)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 28)
        }
    }
}

private struct RankingRow: View {

    let ranking: Ranking

    private var accentColor: Color {
        switch ranking.position {
        case 1: return .rankingYellow
        case 3: return .rankingTurquoise
        default: return .rankingPurple
        }
    }

    @ViewBuilder
    var body: some View {
        if ranking.position == 1 {
            leaderCard
        } else {
            regularCard
        }
    }

    private var leaderCard: some View {
        HStack(spacing: 8) {
            Text(String(ranking.position))
                .font(.system(size: 27, weight: .black, design: .rounded))
                .foregroundColor(Color.rankingYellow)
                .frame(width: 25)

            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: ranking.userLogo))
                    .placeholder {
                        Image(systemName: "person.fill")
                            .font(.system(size: ranking.position == 2 ? 24 : 22))
                            .foregroundColor(Color.rankingMutedText)
                            .frame(
                                width: ranking.position == 2 ? 68 : 52,
                                height: ranking.position == 2 ? 68 : 52
                            )
                            .background(Circle().fill(Color.rankingAvatarBackground))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: ranking.position == 2 ? 68 : 52,
                        height: ranking.position == 2 ? 68 : 52
                    )
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.rankingYellow, lineWidth: 2)
                    )

                Image(systemName: "crown.fill")
                    .font(.system(size: 12, weight: .black))
                    .foregroundColor(Color.rankingSelectedText)
                    .frame(width: 25, height: 25)
                    .background(
                        Circle()
                            .fill(Color.rankingYellow)
                            .overlay(
                                Circle()
                                    .stroke(Color.rankingYellow.opacity(0.7), lineWidth: 1)
                            )
                    )
                    .offset(x: 5, y: -5)
            }
            .frame(width: 68, height: 68)

            VStack(alignment: .leading, spacing: 3) {
                Text(ranking.userName)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.rankingPrimaryText)
                    .lineLimit(2)
                    .minimumScaleFactor(0.75)

                HStack(spacing: 7) {
                    Circle()
                        .fill(Color.rankingTurquoise)
                        .frame(width: 8, height: 8)

                    Text("ranking.online_status")
                        .font(.system(size: 11, weight: .medium, design: .rounded))
                        .foregroundColor(Color.rankingSecondaryText)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack(spacing: 8) {
                Text("ranking.current_leader")
                    .font(.system(size: 9, weight: .black, design: .rounded))
                    .tracking(0.3)
                    .foregroundColor(Color.rankingYellow)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 8)
                    .frame(width: 68, height: 42, alignment: .leading)
                    .background(
                        Capsule()
                            .fill(Color.rankingYellow.opacity(0.15))
                            .overlay(
                                Capsule()
                                    .stroke(Color.rankingYellow.opacity(0.6), lineWidth: 1)
                            )
                    )

                VStack(alignment: .trailing, spacing: 0) {
                    Text(String(ranking.totalScore))
                        .font(.system(size: 23, weight: .black, design: .rounded))
                        .foregroundColor(Color.rankingYellow)

                    Text("ranking.points")
                        .font(.system(size: 9, weight: .medium, design: .rounded))
                        .foregroundColor(Color.rankingYellow)
                }
                .frame(width: 45)
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .frame(height: 108)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.rankingLeaderStart,
                            Color.rankingRowBackground
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.rankingYellow.opacity(0.75), lineWidth: 1.5)
                )
                .overlay(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.rankingYellow)
                        .frame(width: 7)
                }
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }

    private var regularCard: some View {
        HStack(spacing: 12) {
            Text(String(ranking.position))
                .font(.system(size: 25, weight: .black, design: .rounded))
                .foregroundColor(accentColor)
                .frame(width: 30)

            ZStack(alignment: .topTrailing) {
                KFImage(URL(string: ranking.userLogo))
                    .placeholder {
                        Image(systemName: "person.fill")
                            .font(.system(size: 24))
                            .foregroundColor(Color.rankingMutedText)
                            .frame(width: 68, height: 68)
                            .background(Circle().fill(Color.rankingAvatarBackground))
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 68, height: 68)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(accentColor, lineWidth: ranking.position == 3 ? 2 : 1)
                    )

                if ranking.position == 1 {
                    Image(systemName: "crown.fill")
                        .font(.system(size: 13, weight: .black))
                        .foregroundColor(Color.rankingSelectedText)
                        .frame(width: 23, height: 23)
                        .background(
                            Circle()
                                .fill(Color.rankingYellow)
                                .overlay(
                                    Circle()
                                        .stroke(Color.rankingYellow.opacity(0.65), lineWidth: 1)
                                )
                        )
                        .offset(x: 7, y: -7)
                }
            }
            .frame(
                width: ranking.position == 2 ? 74 : 59,
                height: ranking.position == 2 ? 74 : 59
            )

            VStack(alignment: .leading, spacing: 4) {
                Text(ranking.userName)
                    .font(.system(size: ranking.position == 2 ? 18 : 17, weight: .bold, design: .rounded))
                    .foregroundColor(Color.rankingPrimaryText)
                    .lineLimit(2)

                Text(
                    String(
                        format: NSLocalizedString("ranking.level", comment: ""),
                        max(1, ranking.totalScore / 20)
                    )
                )
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(ranking.position == 3 ? Color.rankingTurquoise : Color.rankingSecondaryText)

            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text(String(ranking.totalScore))
                    .font(.system(size: 23, weight: .black, design: .rounded))
                    .foregroundColor(accentColor)

                Text("ranking.points")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundColor(Color.rankingSecondaryText)
            }
        }
        .padding(.horizontal, 16)
        .frame(minHeight: ranking.position == 2 ? 108 : 82)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.rankingRowBackground.opacity(0.88))
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(accentColor.opacity(ranking.position == 1 || ranking.position == 3 ? 0.8 : 0.2), lineWidth: ranking.position == 1 || ranking.position == 3 ? 1.5 : 1)
                )
        )
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
            .preferredColorScheme(.dark)
    }
}
