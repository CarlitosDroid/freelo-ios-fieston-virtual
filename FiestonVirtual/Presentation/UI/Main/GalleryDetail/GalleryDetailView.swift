//
//  GalleryDetailView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/27/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct GalleryDetailView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(GalleryDetailViewModel.self)!
    
    var galleryItem: GalleryItem
    
    
    @State var text: String = ""
    
    //User
    @State private var userName: String = ""
    @State private var userImage: String = ""
    
    @State private var postFile: String = ""
    
    @State private var showLike: Bool = false
    @State private var likeCounter: String = ""
    @State private var postTitle: String = ""
    
    @State private var comments: [Comment] = []
    @State private var writtenComment: String = ""
    
    var body: some View {
        
        LoadingView(isShowing: self.$viewModel.isLoading) {
            
            ZStack {
                
                Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 5) {
                    HStack {
                        KFImage(URL(string: userImage))
                            .placeholder{
                                Image(systemName: "person.fill")
                                    .foregroundColor(Color.white)
                            }
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30.0, height: 30.0)
                        Text(userName)
                            .foregroundColor(Color.aqua)
                        Spacer()
                    }
                    KFImage(URL(string: postFile))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                    HStack {
                        if(showLike) {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.white)
                        } else {
                            Image(systemName: "heart")
                                .foregroundColor(Color.white)
                        }
                        Text(likeCounter)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    HStack {
                        if(!postTitle.isEmpty) {
                            Text(postTitle)
                        }
                        Spacer()
                    }
                    ScrollView {
                        ForEach(comments, id: \.id) { comment in
                            GalleryDetailItemView(comment: comment)
                        }.listRowBackground(Color.deep_purple_intense)
                    }
                    HStack {
                        TextField("Comentar...", text: self.$writtenComment)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.default)
                        Button(action: {
                            
                            viewModel.addComment(postId: galleryItem.id, comment: writtenComment)
                            
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(Color.white)
                        }
                    }
                }
                .padding(5)
                .onAppear(perform: {
                    viewModel.getComments(postId: galleryItem.id)
                    viewModel.getPostDetail(postId: galleryItem.id)
                })
                .onReceive(self.viewModel.$getGalleryDetail, perform: { getGalleryDetail in
                    userName = getGalleryDetail?.userName ?? ""
                    userImage = getGalleryDetail?.userImage ?? ""
                    
                    postFile = getGalleryDetail?.postFile ?? ""
                    
                    showLike = getGalleryDetail?.postLike ?? false
                    likeCounter = String(getGalleryDetail?.postLikeCount ?? 0)
                    
                    postTitle = getGalleryDetail?.postTitle ?? ""
                    
                })
                .onReceive(self.viewModel.$comments, perform: { comments in
                    self.comments = comments
                })
                .onReceive(self.viewModel.$comment, perform: { comment in
                    guard let comment = comment else { return }
                    self.comments.append(comment)
                    self.writtenComment = ""
                })
                
            }
        }
    }
    
}

struct GalleryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryDetailView(
            galleryItem: GalleryItem(
                id: 0,
                type: 0,
                file: "",
                status: 0,
                preview: ""
            )
        )
    }
}
