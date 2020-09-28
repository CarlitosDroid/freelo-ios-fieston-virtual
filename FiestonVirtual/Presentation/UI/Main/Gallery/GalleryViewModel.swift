
import Foundation
import Combine

class GalleryViewModel: ObservableObject {
    
    let getGalleryUseCase: GetGalleryUseCase
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var galleryItems = [GalleryItem]()
    
    private var disposables = Set<AnyCancellable>()
    
    init(getGalleryUseCase: GetGalleryUseCase ) {
        self.getGalleryUseCase = getGalleryUseCase
    }
    
    func getGallery() {
        self.isLoading = true
        getGalleryUseCase.invoke()
            .subscribe(on: DispatchQueue.global())
            
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    self.isLoading = false
                    break
                case .failure(let errorResponse):
                    self.isLoading = false
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (galleryItems: [GalleryItem]) in
                self.galleryItems = galleryItems
            })
            .store(in: &disposables)
    }
    
    
}
