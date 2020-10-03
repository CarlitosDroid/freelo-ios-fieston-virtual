
import Foundation
import Combine

class GalleryViewModel: ObservableObject {
    
    let getGalleryUseCase: GetGalleryUseCase
    
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var galleryItems: [GalleryItem]?
    
    private var disposables = Set<AnyCancellable>()
    
    init(getGalleryUseCase: GetGalleryUseCase ) {
        self.getGalleryUseCase = getGalleryUseCase
    }
    
    func getGallery() {
        self.isLoading = true
        getGalleryUseCase.invoke()
            .receive(on: DispatchQueue.main)
            
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    
                    break
                case .failure(let errorResponse):
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (galleryItems: [GalleryItem]) in
                self.galleryItems = galleryItems
            })
            .store(in: &disposables)
    }
    
    
}
