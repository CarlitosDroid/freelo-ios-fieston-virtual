//
//  HomeViewModel.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/15/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    let categories = [
        Category(
            name: CATEGORY_NAME_PHOTO,
            image: "home_fotos",
            description: "GALERÍA DE FOTOS Y",
            subDescription: "VIDEOS"),
        Category(
            name: CATEGORY_NAME_CHAT,
            image: "home_chat",
            description: "CHATEAR AHORA",
            subDescription: "ARMA LA CONVERSA"),
        Category(
            name: CATEGORY_NAME_TRIVIA,
            image: "home_trivia",
            description: "GANA PUNTOS",
            subDescription: "JUGAR AHORA"),
        Category(
            name: CATEGORY_NAME_PLAY_LIST,
            image: "home_playlist",
            description: "PARTICIPA DE LA FIESTA",
            subDescription: "PIDE UNA CANCIÓN")
    ]
    
}

let CATEGORY_NAME_PHOTO = "FOTOS"
let CATEGORY_NAME_CHAT = "CHAT"
let CATEGORY_NAME_PLAY_LIST = "PLAY LIST"
let CATEGORY_NAME_TRIVIA = "TRIVIAS"
