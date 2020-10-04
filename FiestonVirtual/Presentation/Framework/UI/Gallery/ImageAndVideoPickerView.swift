//
//  ImagePickerView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/4/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SwiftUI

struct ImageAndVideoPickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?
    @Binding var fileURL: URL?
    @Binding var fileType: String
    
    var onImageFromPickerSelected: (_ isImageSelected: Bool, _ fileURL: URL) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageAndVideoPickerView>) -> UIViewController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        return pickerController
    }
    
    func makeCoordinator() -> ImageAndVideoCoordinator {
        return ImageAndVideoCoordinator(parent: self) { isImageSelected, fileURL in
            self.onImageFromPickerSelected(isImageSelected, fileURL)
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}
