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
    
    private let getCommentsUseCase: GetCommentsUseCase
    private let getPostDetailUseCase: GetPostDetailUseCase
    private let addCommentUseCase: AddCommentUseCase
    private let makeLikeUseCase: MakeLikeUseCase
    
    @Published var getGalleryDetail: GetGalleryDetail?
    @Published var comments: [Comment] = []
    @Published var comment: Comment?
    @Published var totalLikes = 0
    @Published var showLike = false
    
    @Published var isLoading = false
    @Published var isError = false
    @Published var errorMessage = ""
    
    private var disposables = Set<AnyCancellable>()
    
    init(
        getCommentsUseCase: GetCommentsUseCase,
        getPostDetailUseCase: GetPostDetailUseCase,
        addCommentUseCase: AddCommentUseCase,
        makeLikeUseCase: MakeLikeUseCase
    ) {
        self.getCommentsUseCase = getCommentsUseCase
        self.getPostDetailUseCase = getPostDetailUseCase
        self.addCommentUseCase = addCommentUseCase
        self.makeLikeUseCase = makeLikeUseCase
    }
    
    func getComments(postId: Int) {
        self.isLoading = true
        getCommentsUseCase.invoke(getCommentsRequest: GetCommentsRequest(idPost: postId))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.isError = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (comments: [Comment]) in
                self.comments = comments
            })
            .store(in: &disposables)
    }
    
    func getPostDetail(postId: Int) {
        self.isLoading = true
        getPostDetailUseCase.invoke(postId: postId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.isError = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (getGalleryDetail: GetGalleryDetail) in
                self.getGalleryDetail = getGalleryDetail
                self.showLike = getGalleryDetail.postLike
            })
            .store(in: &disposables)
        
    }
    
    func addComment(postId: Int, comment: String) {
        self.isLoading = true
        addCommentUseCase.invoke(postId: postId, comment: comment)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.isError = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (comment: Comment) in
                self.comments.append(comment)
                self.comment=comment
            })
            .store(in: &disposables)
    }
    
    func makeLike(idPost: Int){
        self.isLoading = true
        makeLikeUseCase.invoke(idPost: idPost)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<ErrorResponse>) in
                self.isLoading = false
                switch completion {
                case .finished:
                    break
                case .failure(let errorResponse):
                    self.isError = true
                    self.errorMessage = errorResponse.localizedDescription
                    break
                }
            }, receiveValue: { (response: MakeLikeResponse) in
                self.totalLikes = response.likes
                self.showLike = true
            })
            .store(in: &disposables)
    }
    
    
    
}
