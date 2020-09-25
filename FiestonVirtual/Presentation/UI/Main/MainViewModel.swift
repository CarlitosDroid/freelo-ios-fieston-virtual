
import Foundation
import Combine

class MainViewModel: ObservableObject {
    
    let getWelcomeUseCase: GetWelcomeUseCase
    let signOutUseCase: SignOutUseCase
    
    @Published var welcome = Welcome(title: "", description: "", subtitle: "", imageUrl: "")
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var hasWelcome = false
    
    @Published var uploadPhotoMessage = ""
    @Published var uploadPhotoHasFinished = false
    
    @Published var isClosedSession = false
    
    private var disposables = Set<AnyCancellable>()
    
    init(getWelcomeUseCase: GetWelcomeUseCase,
         signOutUseCase: SignOutUseCase ) {
        self.getWelcomeUseCase = getWelcomeUseCase
        self.signOutUseCase = signOutUseCase
    }
    
    func getWelcome() {
        getWelcomeUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    
                    break
                case .failure(let errorResponse):
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (welcome: Welcome) in
                self.hasWelcome=true
                self.welcome=welcome
            })
            .store(in: &disposables)
    }
    
    func uploadImage(data: Data) {
        self.isLoading = true
        let galleryApi = GalleryApiImpl()
        galleryApi.uploadImage(
            data: data,
            idUser: 17,
            idEvent: 3,
            
            postTitle: "Excelente Foto!!!!!")
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ExternalError>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    print("finished camera photo")
                    break
                case .failure(let errorResponse):
                    self.uploadPhotoHasFinished = true
                    self.uploadPhotoMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (uploadImageResponse: UploadImageResponse) in
                print("\(uploadImageResponse)")
                self.uploadPhotoHasFinished = true
                self.uploadPhotoMessage = uploadImageResponse.message
            })
            .store(in: &disposables)
        
    }
    
    func signOut() {
        self.isLoading = true
        self.signOutUseCase.invoke()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let errorResponse):
                    self.errorMessage = errorResponse.localizedDescription
                    self.isLoading = false
                    break
                }
            }, receiveValue: { (isClosedSession: Bool) in
                self.isClosedSession = isClosedSession
            })
            .store(in: &disposables)
    }
    
}
