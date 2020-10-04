//
//  UserProfileView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct UserProfileView: View {
    
    @State var showCaptureImageView: Bool = false
    
    @Binding var imageUrl: String
    var onUserProfileClicked: () -> Void
    
    var body: some View {
        
        ZStack {
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Andres Ramires")
                        .foregroundColor(Color.black)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    Text("Bienvenido")
                        .foregroundColor(Color.deep_purple_500)
                        .font(.system(size: 20))
                    HStack {
                        Text("Puntos")
                            .fontWeight(.bold)
                        
                        Text("177")
                        Text("Ranking")
                            .fontWeight(.bold)
                        Text("2")
                    }
                }
                Spacer()
                VStack {
                    KFImage(URL(string: imageUrl))
                        .placeholder{
                            Image(systemName: "person.fill")
                                .foregroundColor(Color.white)
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80.0, height: 80.0)
                        .clipShape(Circle())
                        .onTapGesture(perform: {
                            onUserProfileClicked()
                        })
                    
                }
            }
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 3)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(imageUrl: .constant("")) {
            
        }
    }
}
