//
//  ImageCoordinator.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 10/4/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SwiftUI

class ImageCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let parent: ImagePickerView
    var onFileSelected: (_ isImageSelected: Bool, _ fileUrl: URL) -> Void
    
    init(parent: ImagePickerView, onFileSelected: @escaping (_ isImageSelected: Bool, _ fileURL: URL) -> Void) {
        self.parent = parent
        self.onFileSelected = onFileSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //IMAGE
        if let selectedImageURLFromPicker = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            onFileSelected(true, selectedImageURLFromPicker)
            self.parent.fileURL = selectedImageURLFromPicker
            self.parent.fileType = "Imagen"
   
            if let selectedImageFromPicker = info[.originalImage] as? UIImage {
                self.parent.selectedImage = selectedImageFromPicker
            }
        }
        
        self.parent.isPresented = false
    }
    
}
