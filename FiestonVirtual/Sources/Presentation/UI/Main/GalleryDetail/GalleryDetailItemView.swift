//
//  GalleryDetailItemView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/27/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct GalleryDetailItemView: View {
    
    let comment: Comment
    
    var body: some View {
        HStack {
            KFImage(URL(string: comment.avatar))
                .resizable()
                .scaledToFit()
                .frame(width: 30.0, height: 30.0)
            VStack(alignment: .leading) {
                Text(comment.userName)
                    .foregroundColor(Color.aquamarine)
                Text(comment.text)
                    .padding(2)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
    }
}

struct GalleryDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryDetailItemView(
            comment: Comment(
                id: 0,
                text: "Excelente Imagen",
                avatar: "house.fill",
                userName: "Carlitos"
            )
        )
        .previewLayout(.sizeThatFits)
    }
}
