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
import SwiftyJSON

class GalleryApiImpl: GalleryApi {
    
    func uploadFile(
        data: URL,
        idUser: Int,
        idEvent: Int,
        
        postTitle: String
    ) -> AnyPublisher<UploadImageResponse, ExternalError> {
        
        print(data.pathExtension)
        
        let mimeType: String
        let postType: Int
        
        switch data.pathExtension {
        case "jpeg":
            postType = 1
            mimeType = "image/jpeg"
            break
        case "jpg":
            postType = 1
            mimeType = "image/jpg"
            break
        case "png":
            postType = 1
            mimeType = "image/png"
            break
        case "MOV":
            postType = 2
            mimeType = "video/quicktime"
            break
        case "mov":
            postType = 2
            mimeType = "video/quicktime"
            break
        case "mp4":
            postType = 2
            mimeType = "video/mp4"
            break
        default:
            postType = 0
            mimeType = "image/jpeg"
            break
        }
        
        
        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            multipartFormData.append(String(idUser).data(using: .utf8)!, withName: "idUser")
            multipartFormData.append(String(idEvent).data(using: .utf8)!, withName: "idEvent")
            multipartFormData.append(String(postType).data(using: .utf8)!, withName: "postType")
            multipartFormData.append(String(postTitle).data(using: .utf8)!, withName: "postTitle")
            multipartFormData.append(data,
                                     withName: "file",
                                     fileName: "\(getCurrentTimeStamp()).\(data.pathExtension)",
                                     mimeType: mimeType)
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
    
    func uploadImage(data: Data, idUser: Int, idEvent: Int, postTitle: String) -> AnyPublisher<UploadImageResponse, ExternalError> {
        return AF.upload(multipartFormData: { (multipartFormData: MultipartFormData) in
            multipartFormData.append(String(idUser).data(using: .utf8)!, withName: "idUser")
            multipartFormData.append(String(idEvent).data(using: .utf8)!, withName: "idEvent")
            multipartFormData.append("1".data(using: .utf8)!, withName: "postType")
            multipartFormData.append(String(postTitle).data(using: .utf8)!, withName: "postTitle")
            multipartFormData.append(data,
                                     withName: "file",
                                     fileName: "\(getCurrentTimeStamp()).jpeg",
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
                    guard let errorDescription = afError.errorDescription else { return }
                    promise(.failure(ExternalError.NetworkError(description: "\(errorDescription)")))
                    break
                    
                case .success(let uploadImageResponse):
                    promise(.success(uploadImageResponse))
                    break
                }
                
            }.eraseToAnyPublisher()
        }).eraseToAnyPublisher()
    }
    
    func getGallery(
        galleryRequest: GetGalleryRequest
    ) -> AnyPublisher<GetGalleryResponse, ExternalError> {
        
        guard let url = getGalleryComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: galleryRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: GetGalleryResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<GetGalleryResponse, AFError>)-> AnyPublisher<GetGalleryResponse, ExternalError> in
                Future<GetGalleryResponse, ExternalError> { promise in
                    switch dataResponse.result {
                    
                    case .failure(let afError):
                        if let data = dataResponse.data {
                            if let json = try? JSON(data: data) {
                                let message = json["message"].stringValue
                                promise(.failure(ExternalError.NetworkError(description: "\(message)")))
                            }
                        }
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let codeVerificationResponse):
                        promise(.success(codeVerificationResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
    }
    
    func getGalleryDetail(
        getGalleryDetailRequest: GetGalleryDetailRequest
    ) -> AnyPublisher<GetGalleryDetailResponse, ExternalError> {
        
        guard let url = getGalleryDetailComponents().url else {
            let error = ExternalError.NetworkError(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return AF.request(url,
                          method: .post,
                          parameters: getGalleryDetailRequest,
                          encoder: JSONParameterEncoder.default,
                          headers: nil,
                          interceptor: nil,
                          requestModifier: nil)
            .validate()
            .publishDecodable(type: GetGalleryDetailResponse.self)
            .mapError({ (never : Never) -> ExternalError in
                ExternalError.UnknowError(description: never.localizedDescription)
            })
            .flatMap({ (dataResponse: DataResponse<GetGalleryDetailResponse, AFError>)-> AnyPublisher<GetGalleryDetailResponse, ExternalError> in
                Future<GetGalleryDetailResponse, ExternalError> { promise in
                    switch dataResponse.result {
                    
                    case .failure(let afError):
                        if let data = dataResponse.data {
                            if let json = try? JSON(data: data) {
                                let message = json["message"].stringValue
                                promise(.failure(ExternalError.NetworkError(description: "\(message)")))
                            }
                        }
                        promise(.failure(ExternalError.NetworkError(description: "\(afError.localizedDescription)")))
                        break
                        
                    case .success(let codeVerificationResponse):
                        promise(.success(codeVerificationResponse))
                        break
                    }
                    
                }.eraseToAnyPublisher()
            }).eraseToAnyPublisher()
    }
    
}

private extension GalleryApiImpl {
    
    struct FiestonVirtualAPI {
        static let scheme = "http"
        static let host = "fiestonvirtual.com"
        static let path = "/app/api"
    }
    
    func getGalleryComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/galeria.php"
        return urlComponents
    }
    
    func getGalleryDetailComponents() -> URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = FiestonVirtualAPI.scheme
        urlComponents.host = FiestonVirtualAPI.host
        urlComponents.path = FiestonVirtualAPI.path + "/detalle_publicacion.php"
        return urlComponents
    }
    
}
