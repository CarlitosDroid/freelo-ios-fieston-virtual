//
//  PlayListView.swift
//  FiestonVirtual
//

import SwiftUI

struct PlaylistView: View {

    @Environment(\.presentationMode) private var presentationMode
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(PlaylistViewModel.self)!

    @State private var songs = [Song]()
    @State private var selectedCategory = 0

    private let categories = [
        "playlist.category.all",
        "playlist.category.reggaeton",
        "playlist.category.pop",
        "playlist.category.electronic"
    ]

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
                        header
                        nowPlayingCard
                        categorySelector
                        songList
                    }
                    .padding(.bottom, 28)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            viewModel.getSongs()
        }
        .onReceive(viewModel.$songs) { songs in
            self.songs = songs ?? []
        }
        .onReceive(viewModel.$song) { requestedSong in
            guard let requestedSong else { return }
            guard let index = songs.firstIndex(where: { $0.id == requestedSong.id }) else { return }
            songs[index].requested = requestedSong.requested
        }
        .alert(isPresented: $viewModel.showErrorMessage) {
            Alert(
                title: Text(viewModel.errorMessage),
                dismissButton: .default(Text(NSLocalizedString("common.accept", comment: "Accept button")))
            )
        }
        .alert(isPresented: $viewModel.requestSongShowErrorMessage) {
            Alert(
                title: Text(viewModel.errorMessage),
                dismissButton: .default(Text(NSLocalizedString("common.accept", comment: "Accept button")))
            )
        }
    }

    private var header: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(Color.loginTextPrimary)
                    .frame(width: 42, height: 42)
            }
            .buttonStyle(.plain)

            Spacer()

            VStack(spacing: 2) {
                Text(NSLocalizedString("playlist.title", comment: "Playlist title"))
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color.loginTextPrimary)

                Text(NSLocalizedString("playlist.subtitle", comment: "Playlist subtitle"))
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .tracking(1.5)
                    .foregroundColor(Color.loginBrandTurquoise)
            }

            Spacer()

            HStack(spacing: 14) {
                Image(systemName: "magnifyingglass")
                Image(systemName: "ellipsis")
                    .rotationEffect(.degrees(90))
            }
            .font(.system(size: 21, weight: .semibold))
            .foregroundColor(Color.loginTextPrimary)
            .frame(width: 72)
        }
        .padding(.horizontal, 12)
        .padding(.top, 8)
        .padding(.bottom, 18)
    }

    private var nowPlayingCard: some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.loginBrandTurquoise)
                        .frame(width: 12, height: 12)
                    Text(NSLocalizedString("playlist.live", comment: "Live playlist status"))
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                        .foregroundColor(Color.loginBrandTurquoise)
                }

                HStack(spacing: 14) {
                    Image(systemName: "opticaldisc.fill")
                        .font(.system(size: 38))
                        .foregroundColor(Color.loginBrandYellow)
                        .frame(width: 104, height: 104)
                        .background(
                            LinearGradient(
                                colors: [Color.loginBrandPurple, Color.loginBrandYellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 18))

                    VStack(alignment: .leading, spacing: 4) {
                        Text(NSLocalizedString("playlist.now_playing", comment: "Now playing title"))
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundColor(Color.loginTextPrimary)
                            .lineLimit(2)

                        Text(NSLocalizedString("playlist.now_playing_artist", comment: "Now playing artist"))
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(Color.loginBrandTurquoise)

                        HStack(spacing: 8) {
                            Text("0:00")
                            Capsule()
                                .fill(Color.loginBrandTurquoise)
                                .frame(height: 7)
                            Text("—")
                        }
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(Color.loginMutedText)
                    }
                }
            }

            VStack(spacing: 4) {
                Image(systemName: "chart.bar.fill")
                    .foregroundColor(Color.loginBrandYellow)
                Text(NSLocalizedString("playlist.bpm", comment: "Beats per minute"))
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginMutedText)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 8)
            .background(Color.loginBadgeBackground.opacity(0.7))
            .clipShape(Capsule())
        }
        .padding(16)
        .background(
            LinearGradient(
                colors: [Color.loginCardBackground, Color.loginLogoPanel.opacity(0.7)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.loginBrandPurple.opacity(0.65), lineWidth: 1)
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .padding(.horizontal, 16)
    }

    private var categorySelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(categories.indices, id: \.self) { index in
                    Button(action: {
                        selectedCategory = index
                    }) {
                        Text(NSLocalizedString(categories[index], comment: "Playlist category"))
                            .font(.system(size: 15, weight: .semibold, design: .rounded))
                            .foregroundColor(
                                selectedCategory == index
                                    ? Color.loginButtonText
                                    : Color.loginTextPrimary
                            )
                            .padding(.horizontal, 20)
                            .frame(height: 44)
                            .background(
                                Capsule()
                                    .fill(
                                        selectedCategory == index
                                            ? Color.loginButtonBackground
                                            : Color.loginCardBackground.opacity(0.7)
                                    )
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 16)
        }
        .padding(.top, 22)
    }

    private var songList: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text(NSLocalizedString("playlist.queue_title", comment: "Playlist queue title"))
                    .font(.system(size: 19, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginTextPrimary)

                Spacer()

                Text(
                    String(
                        format: NSLocalizedString("playlist.available", comment: "Available songs"),
                        songs.count
                    )
                )
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .foregroundColor(Color.loginBrandTurquoise)
            }

            ForEach(Array(songs.enumerated()), id: \.element.id) { index, song in
                songRow(song, index: index)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 28)
    }

    private func songRow(_ song: Song, index: Int) -> some View {
        HStack(spacing: 14) {
            Image(systemName: index.isMultiple(of: 2) ? "music.note" : "waveform")
                .font(.system(size: 27, weight: .bold))
                .foregroundColor(Color.loginTextPrimary)
                .frame(width: 70, height: 70)
                .background(songColor(index))
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 3) {
                Text(song.title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.loginTextPrimary)
                    .lineLimit(1)

                Text(song.band)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginBrandTurquoise)
                    .lineLimit(1)

                Text(NSLocalizedString("playlist.duration_unavailable", comment: "Unavailable song duration"))
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginMutedText)
            }

            Spacer(minLength: 4)

            Button(action: {
                viewModel.requestSongUseCase(idPlaylist: song.id)
            }) {
                HStack(spacing: 6) {
                    Image(systemName: song.requested ? "checkmark.circle" : "text.badge.plus")
                    Text(
                        NSLocalizedString(
                            song.requested ? "playlist.requested" : "playlist.request",
                            comment: "Request song button"
                        )
                    )
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(song.requested ? Color.loginBrandTurquoise : Color.loginButtonText)
                .padding(.horizontal, 14)
                .frame(height: 48)
                .background(song.requested ? Color.clear : Color.loginButtonBackground)
                .overlay(
                    Capsule()
                        .stroke(
                            song.requested ? Color.loginBrandTurquoise : Color.clear,
                            lineWidth: 1
                        )
                )
                .clipShape(Capsule())
            }
            .buttonStyle(.plain)
        }
        .padding(14)
        .background(Color.loginCardBackground.opacity(0.72))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    song.requested ? Color.loginBrandTurquoise.opacity(0.8) : Color.loginMutedText.opacity(0.25),
                    lineWidth: 1
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }

    private func songColor(_ index: Int) -> LinearGradient {
        let colors: [[Color]] = [
            [Color.loginBrandPurple, Color.chatPink],
            [Color.loginBrandTurquoise, Color.loginBrandPurple],
            [Color.loginBrandYellow, Color.orange_500],
            [Color.loginBrandTurquoise, Color.loginBrandPurple]
        ]
        let selected = colors[index % colors.count]
        return LinearGradient(colors: selected, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}

struct PlayListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
            .preferredColorScheme(.dark)
    }
}
