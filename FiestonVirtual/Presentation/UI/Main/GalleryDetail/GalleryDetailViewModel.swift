//
//  GalleryDetailViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/27/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine

class GalleryDetailViewModel: ObservableObject {
    
    private let getPostDetailUseCase: GetPostDetailUseCase
    
    @Published var getGalleryDetail: GetGalleryDetail?
    
    
    private var disposables = Set<AnyCancellable>()
    
    init(getPostDetailUseCase: GetPostDetailUseCase) {
        self.getPostDetailUseCase = getPostDetailUseCase
    }
    
    func getPostDetail(postId: Int) {
        getPostDetailUseCase.invoke(postId: postId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                switch completion {
                case .finished:
                    print("finished")
                    break
                case .failure(let errorResponse):
                    print("erroResponse")
                    //                    self.isLoading = false
                    //                    self.isError=true
                    //                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (getGalleryDetail: GetGalleryDetail) in
                print(getGalleryDetail)
                self.getGalleryDetail = getGalleryDetail
                //                self.isLoading = false
                //                self.inSession = true
            })
            .store(in: &disposables)
        
    }
    
}
