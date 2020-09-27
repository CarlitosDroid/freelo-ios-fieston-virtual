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
    
    @State private var eventCode: String = ""
    
    @State var text: String = ""
    
    //User
    @State private var userName: String = ""
    @State private var userImage: String = ""
    
    @State private var postFile: String = ""
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                KFImage(URL(string: userImage))
                    .placeholder{
                        Image(systemName: "house.fill")
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30.0, height: 30.0)
                Text(userName)
                Spacer()
            }
            KFImage(URL(string: postFile))
                .resizable()
                .aspectRatio(contentMode: .fill)
                
            HStack {
                Image(systemName: "house.fill")
                Text("Placeholder")
            }
            Text("Placeholder")
            List {
                Text("comment").background(Color.yellow)
            }
            
            HStack {
                TextField("Coloque su código", text: self.$eventCode)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                Button(action: {
                    
                }) {
                    Image(systemName: "house.fill")
                }
            }
        }
        .padding(5)
        .onAppear(perform: {
            viewModel.getPostDetail(postId: galleryItem.id)
        })
        .onReceive(self.viewModel.$getGalleryDetail, perform: { getGalleryDetail in
            userName = getGalleryDetail?.userName ?? ""
            userImage = getGalleryDetail?.userImage ?? ""
            
            postFile = getGalleryDetail?.postFile ?? ""
        })
    }
    
}

struct GalleryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryDetailView(galleryItem: GalleryItem(id: 0, type: 0, file: "", status: 0, preview: ""))
        
    }
}
