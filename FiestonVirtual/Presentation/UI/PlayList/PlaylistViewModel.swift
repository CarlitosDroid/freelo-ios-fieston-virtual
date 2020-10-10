
import Foundation
import Combine

class PlaylistViewModel : ObservableObject {
    
    private let getPlaylistUseCase: GetPlaylistUseCase
    private let requestSongUseCase: RequestSongUseCase
    
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var showErrorMessage = false
    @Published var requestSongShowErrorMessage = false
    
    @Published var songs : [Song]?
    @Published var song : Song?
    
    private var disposables = Set<AnyCancellable>()
    
    init(
        getPlayListUseCase: GetPlaylistUseCase,
        requestSongUseCase: RequestSongUseCase
    ) {
        self.getPlaylistUseCase = getPlayListUseCase
        self.requestSongUseCase = requestSongUseCase
    }
    
    func getSongs() {
        self.isLoading = true
        self.getPlaylistUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.showErrorMessage = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (songs:[Song]) in
                self.songs = songs
            })
            .store(in: &disposables)
    }
    
    func requestSongUseCase(idPlaylist: Int) {
        self.isLoading = true
        self.requestSongUseCase.invoke(idPlaylist: idPlaylist)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.requestSongShowErrorMessage = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (song : Song) in
                self.song = song
            })
            .store(in: &disposables)
    }
    
}

