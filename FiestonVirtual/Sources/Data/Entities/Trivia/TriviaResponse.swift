//
//  RespuestaTriviaResponse.swift
//  FiestonVirtual
//
//  Created by Ronaldo Andre Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation

struct TriviaResponse: Decodable {
    let message: String
    let data: ChildTriviaResponse
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case data = "data"
    }
}

struct ChildTriviaResponse: Decodable {
    let question: [ChildQuestion]
}

struct ChildQuestion: Decodable {
    let idQuestion: Int
    let question: String
    let questionAlternative: [ChildQuestionAlternative]
    let questionImage: String
    let questionName: String
    let questionScore: Int
    let questionStatus: Int
    let questionType: String
    
}

struct ChildQuestionAlternative : Decodable{
    let alternativeAnswer: Bool
    let alternativeDescription: String
    let idAlternative: Int
}
