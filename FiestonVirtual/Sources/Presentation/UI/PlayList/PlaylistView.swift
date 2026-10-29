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
    @State private var nowPlayingSong: Song?
    @StateObject private var musicPlayer = MusicMediaPlayer()

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
        .onDisappear {
            musicPlayer.pause()
        }
        .onReceive(viewModel.$songs) { songs in
            self.songs = songs ?? []
            if nowPlayingSong == nil, let firstSong = songs?.first {
                nowPlayingSong = firstSong
                loadSong(firstSong)
            }
        }
        .onReceive(viewModel.$song) { requestedSong in
            guard let requestedSong else { return }
            guard let index = songs.firstIndex(where: { $0.id == requestedSong.id }) else { return }
            songs[index].requested = requestedSong.requested
            if nowPlayingSong?.id == requestedSong.id {
                nowPlayingSong = requestedSong
            }
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
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.loginBrandTurquoise)
                    .frame(width: 12, height: 12)
                Text(NSLocalizedString("playlist.live", comment: "Live playlist status"))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .foregroundColor(Color.loginBrandTurquoise)
            }

            HStack(spacing: 12) {
                Image(systemName: "opticaldisc.fill")
                    .font(.system(size: 34))
                    .foregroundColor(Color.loginBrandYellow)
                    .frame(width: 92, height: 92)
                    .background(
                        LinearGradient(
                            colors: [Color.loginBrandPurple, Color.loginBrandYellow],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 18))

                VStack(alignment: .leading, spacing: 4) {
                    Text(nowPlayingSong?.title ?? NSLocalizedString("playlist.now_playing", comment: "Now playing title"))
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundColor(Color.loginTextPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)

                    Text(nowPlayingSong?.band ?? NSLocalizedString("playlist.now_playing_artist", comment: "Now playing artist"))
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(Color.loginBrandTurquoise)
                        .lineLimit(1)
                        .minimumScaleFactor(0.75)

                    HStack(spacing: 8) {
                        Button(action: {
                            musicPlayer.togglePlayback()
                        }) {
                            Image(systemName: musicPlayer.isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color.loginButtonText)
                                .frame(width: 26, height: 26)
                                .background(Color.loginButtonBackground)
                                .clipShape(Circle())
                        }
                        .buttonStyle(.plain)

                        Text(formatTime(musicPlayer.currentTime))
                            .frame(width: 34, alignment: .leading)

                        ProgressView(value: musicPlayer.progress)
                            .tint(Color.loginBrandTurquoise)
                            .frame(maxWidth: .infinity)

                        Text(formatTime(musicPlayer.duration))
                            .frame(width: 34, alignment: .trailing)
                    }
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginMutedText)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: 4) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(Color.loginBrandYellow)
                    Text(NSLocalizedString("playlist.bpm", comment: "Beats per minute"))
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .foregroundColor(Color.loginMutedText)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                .frame(width: 48)
                .padding(.vertical, 8)
                .background(Color.loginBadgeBackground.opacity(0.7))
                .clipShape(Capsule())
            }
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
        HStack(spacing: 10) {
            Image(systemName: index.isMultiple(of: 2) ? "music.note" : "waveform")
                .font(.system(size: 27, weight: .bold))
                .foregroundColor(Color.loginTextPrimary)
                .frame(width: 62, height: 62)
                .background(songColor(index))
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(alignment: .leading, spacing: 3) {
                Text(song.title)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundColor(Color.loginTextPrimary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(song.band)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginBrandTurquoise)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)

                Text(NSLocalizedString("playlist.duration_unavailable", comment: "Unavailable song duration"))
                    .font(.system(size: 13, weight: .medium, design: .rounded))
                    .foregroundColor(Color.loginMutedText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

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
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                    .fixedSize(horizontal: false, vertical: true)
                }
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundColor(song.requested ? Color.loginBrandTurquoise : Color.loginButtonText)
                .padding(.horizontal, 10)
                .frame(width: 112)
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
        .padding(12)
        .background(Color.loginCardBackground.opacity(0.72))
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .stroke(
                    song.requested ? Color.loginBrandTurquoise.opacity(0.8) : Color.loginMutedText.opacity(0.25),
                    lineWidth: 1
                )
        )
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .contentShape(RoundedRectangle(cornerRadius: 22))
        .onTapGesture {
            loadSong(song)
        }
    }

    private func loadSong(_ song: Song) {
        nowPlayingSong = song
        guard let urlString = song.playListURL,
              let url = URL(string: urlString) else {
            musicPlayer.pause()
            return
        }
        musicPlayer.load(url: url)
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

    private func formatTime(_ seconds: Double) -> String {
        guard seconds.isFinite, seconds >= 0 else { return "0:00" }
        let totalSeconds = Int(seconds)
        return String(format: "%d:%02d", totalSeconds / 60, totalSeconds % 60)
    }
}

struct PlayListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView()
            .preferredColorScheme(.dark)
    }
}
