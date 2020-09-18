
import Foundation
import Combine

class WelcomeViewModel: ObservableObject {
    
    let getWelcomeUseCase: GetWelcomeUseCase
    
    @Published var welcome = Welcome(title: "", description: "", subtitle: "", imageUrl: "")
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var hasWelcome = false
    
    
    @Published var uploadPhotoMessage = ""
    @Published var uploadPhotoHasFinished = false
    @Published var isUploadingPhoto = false
    
    private var disposables = Set<AnyCancellable>()
    
    init(getWelcomeUseCase: GetWelcomeUseCase) {
        self.getWelcomeUseCase = getWelcomeUseCase
    }
    
    func getWelcome() {
        self.isLoading = true
        getWelcomeUseCase.invoke()
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
            }, receiveValue: { (welcome: Welcome) in
                self.hasWelcome=true
                self.welcome=welcome
            })
            .store(in: &disposables)
    }
    
    func uploadImage(data: Data) {
        self.isUploadingPhoto = true
        let galleryApi = GalleryApiImpl()
        galleryApi.uploadImage(
            data: data,
            idUser: 17,
            idEvent: 3,
     
            postTitle: "Excelente Foto!!!!!")
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ExternalError>) in
                switch completion {
                case .finished:
                    print("finish")
                    break
                case .failure(let errorResponse):
                    self.isUploadingPhoto = false
                    self.uploadPhotoHasFinished = true
                    self.uploadPhotoMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (uploadImageResponse: UploadImageResponse) in
                print("\(uploadImageResponse)")
                self.isUploadingPhoto = false
                self.uploadPhotoHasFinished = true
                self.uploadPhotoMessage = uploadImageResponse.message
            })
            .store(in: &disposables)
        
    }
}
