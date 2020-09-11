//
//  GalleryApiImpl.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/10/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class GalleryApiImpl: GalleryApi {
    
    func uploadImage(
        data: Data,
        idUser: Int,
        idEvent: Int,
        postType: Int,
        postTitle: String
    ) -> AnyPublisher<UploadImageResponse, ExternalError> {
        
        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            multipartFormData.append(String(idUser).data(using: .utf8)!, withName: "idUser")
            multipartFormData.append(String(idEvent).data(using: .utf8)!, withName: "idEvent")
            multipartFormData.append(String(postType).data(using: .utf8)!, withName: "postType")
            multipartFormData.append(String(postTitle).data(using: .utf8)!, withName: "postTitle")
            multipartFormData.append(data,
                                     withName: "file",
                                     fileName: "\(self.getCurrentTimeStamp()).jpg",
                                     mimeType: "image/jpeg")
        },
                         to: "http://fiestonvirtual.com/app/api/publicaciones.php",
                         method: .post,
                         interceptor: nil,
                         requestModifier: nil)
            .validate()
            .publishDecodable(type: UploadImageResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<UploadImageResponse, AFError>)-> AnyPublisher<UploadImageResponse, ExternalError> in
                Future<UploadImageResponse, ExternalError> { promise in
                    switch dataResponse.result {
                        
                    case .failure(let afError):
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let uploadImageResponse):
                        promise(.success(uploadImageResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
        
    }
    
    
//
//    func uploadVideo(data: URL, idUser: Int, idEvent: Int, postType: Int) -> AnyPublisher<UploadImageResponse, ExternalError> {
//        let timestamp = NSDate().timeIntervalSince1970 // just for some random name.
//
//            return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
//                multipartFormData.append(String(idUser).data(using: .utf8)!, withName: "idUser")
//                multipartFormData.append(String(idEvent).data(using: .utf8)!, withName: "idEvent")
//                multipartFormData.append(String(postType).data(using: .utf8)!, withName: "postType")
//                multipartFormData.append(data,
//                                         withName: "file",
//                                         fileName: "\(timestamp).mov",
//                                         mimeType: "video/quicktime")
//            },
//                             to: URL(string: "http://fiestonvirtual.com/app/api/publicaciones.php")!,
//                             method: .post,
//                             interceptor: nil,
//                             requestModifier: nil)
//                .validate()
//                .publishDecodable(type: UploadImageResponse.self)
//                .mapError({ (never : Never) -> ExternalError in
//                    ExternalError.UnknowError(description: never.localizedDescription)
//                })
//                .flatMap({ (dataResponse: DataResponse<UploadImageResponse, AFError>)-> AnyPublisher<UploadImageResponse, ExternalError> in
//                    Future<UploadImageResponse, ExternalError> { promise in
//                        switch dataResponse.result {
//
//                        case .failure(let afError):
//                            promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
//                            break
//
//                        case .success(let uploadImageResponse):
//                            promise(.success(uploadImageResponse))
//                            break
//                        }
//
//                    }.eraseToAnyPublisher()
//                }).eraseToAnyPublisher()
//
//    }
  
    private func getCurrentTimeStamp() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyyMMddHHmmss"
        return formatter.string(from: now)
    }
    
}
