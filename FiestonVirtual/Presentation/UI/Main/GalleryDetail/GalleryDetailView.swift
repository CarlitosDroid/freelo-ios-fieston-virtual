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
    
    //User
    @State private var userName: String = ""
    @State private var userImage: String = ""
    
    @State private var postFile: String = ""
    
    @State private var totalLikes: String = ""
    @State private var postTitle: String = ""
    
    @State private var comments: [Comment] = []
    @State private var writtenComment: String = ""
    
    var body: some View {
        
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            if(!self.userName.isEmpty) {
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
                    
                    if(galleryItem.type == 1) {
                        KFImage(URL(string: postFile))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } else {
                        VideoView(videoUrl: postFile)
                    }
                    
                    HStack {
                        if(totalLikes == "0"){
                            Button(action:{
                                self.viewModel.makeLike(idPost: galleryItem.id)
                            }){
                                Image(systemName: "heart")
                                    .foregroundColor(Color.white)
                            }
                        } else {
                            Image(systemName: "heart.fill")
                                .foregroundColor(Color.white)
                        }
                        Text(totalLikes)
                            .foregroundColor(Color.white)
                        Spacer()
                    }
                    HStack {
                        if(!postTitle.isEmpty) {
                            Text(postTitle)
                                .foregroundColor(Color.white)
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
                                .frame(width: 30.0)
                        }
                    }
                }
                .padding(5)
                
            } else {
                Text("Loading...")
                    .foregroundColor(.white)
//                LoadingView(isShowing: self.$viewModel.isLoading) {
//                    EmptyView()
//                }
            }
            
        }.onAppear(perform: {
            viewModel.getComments(postId: galleryItem.id)
            viewModel.getPostDetail(postId: galleryItem.id)
        })
        .onReceive(self.viewModel.$getGalleryDetail, perform: { getGalleryDetail in
            
            guard let getGalleryDetailNoNull = getGalleryDetail else { return }
            
            self.userName = getGalleryDetailNoNull.userName
            self.userImage = getGalleryDetailNoNull.userImage
            
            self.postFile = getGalleryDetailNoNull.postFile
            
            self.totalLikes = String(getGalleryDetailNoNull.postLikeCount)
            
            self.postTitle = getGalleryDetailNoNull.postTitle
            
        })
        .onReceive(self.viewModel.$comments, perform: { comments11 in
            
            guard let commentsNonNull = comments11 else { return }
            
            self.comments.append(contentsOf: commentsNonNull)
        })
        .onReceive(self.viewModel.$comment, perform: { comment in
            
            guard let commentNonNull = comment else { return }
            
            self.comments.append(commentNonNull)
            self.writtenComment = ""
        })
        .onReceive(self.viewModel.$makeLikeResponse) { makeLikeResponse in
            
            guard let totalLikesNonNull = makeLikeResponse else { return }
            
            self.totalLikes = String(totalLikesNonNull.likes)
        }
        
        .alert(isPresented: .constant(self.viewModel.isError), content:{
            Alert(
                title: Text(self.viewModel.errorMessage),
                dismissButton: .default(Text("Aceptar"))
            )
        })
    }
    
}
