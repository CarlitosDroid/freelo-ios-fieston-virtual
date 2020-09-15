//
//  UserProfileView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/14/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct UserProfileView: View {
    var body: some View {
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
                Image("home_chat")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80.0, height: 80.0, alignment: .center)
                    .clipShape(Circle())
                Text("Cambiar foto")
            }
        }
        .padding(.all, 20)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}
