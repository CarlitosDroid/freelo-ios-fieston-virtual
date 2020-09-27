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
    
    var galleryItem: GalleryItem
    
    @State private var eventCode: String = ""
    
    @State var text: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "house.fill")
                Text("Placeholder")
                Spacer()
            }
            .background(Color.red)
            KFImage(URL(string:galleryItem.file))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .background(Color.green)
                .padding(10)
                
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
    }
}

struct GalleryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryDetailView(galleryItem: GalleryItem(id: 0, type: 0, file: "", status: 0, preview: ""))
        
    }
}
