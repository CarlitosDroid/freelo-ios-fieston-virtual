import AVFoundation
import Combine

final class MusicMediaPlayer: ObservableObject {

    @Published private(set) var isPlaying = false
    @Published private(set) var progress = Float.zero
    @Published private(set) var currentTime = Double.zero
    @Published private(set) var duration = Double.zero

    private var player = AVPlayer()
    private var timeObserverToken: Any?

    init() {
        configureAudioSession()
        addPeriodicObserver()
    }

    deinit {
        if let timeObserverToken {
            player.removeTimeObserver(timeObserverToken)
        }
    }

    func play() {
        guard player.currentItem != nil else { return }
        player.play()
        isPlaying = true
    }

    func pause() {
        player.pause()
        isPlaying = false
    }

    func togglePlayback() {
        isPlaying ? pause() : play()
    }

    func load(url: URL) {
        pause()
        player.replaceCurrentItem(with: AVPlayerItem(url: url))
        currentTime = 0
        duration = 0
        progress = 0
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            assertionFailure("Unable to configure audio playback: \(error.localizedDescription)")
        }
    }

    private func addPeriodicObserver() {
        let interval = CMTime(seconds: 0.5, preferredTimescale: 1000)
        timeObserverToken = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self else { return }
            currentTime = time.seconds.isFinite ? time.seconds : 0

            let loadedDuration = player.currentItem?.duration.seconds ?? 0
            duration = loadedDuration.isFinite ? loadedDuration : 0
            progress = duration > 0 ? min(max(Float(currentTime / duration), 0), 1) : 0
            isPlaying = player.rate > 0
        }
    }
}
