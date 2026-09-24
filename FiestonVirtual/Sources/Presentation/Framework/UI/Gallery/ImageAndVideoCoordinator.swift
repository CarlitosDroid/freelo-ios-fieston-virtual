//
//  GalleryCoordinator.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/22/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation

class ImageAndVideoCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let parent: ImageAndVideoPickerView
    var onFileSelected: (_ isImageSelected: Bool, _ fileUrl: URL) -> Void
    
    init(parent: ImageAndVideoPickerView, onFileSelected: @escaping (_ isImageSelected: Bool, _ fileURL: URL) -> Void) {
        self.parent = parent
        self.onFileSelected = onFileSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //VIDEO
        if let selectedMediaURLFromPicker = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            onFileSelected(true, selectedMediaURLFromPicker)
            self.parent.fileURL = selectedMediaURLFromPicker
            self.parent.fileType = "Video"
            
            self.parent.selectedImage = self.getThumbnailImage(forUrl: selectedMediaURLFromPicker)
        }
        
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
    
    func getThumbnailImage(forUrl url: URL) -> UIImage? {
        let asset: AVAsset = AVAsset(url: url)
        let imageGenerator = AVAssetImageGenerator(asset: asset)

        do {
            let thumbnailImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 1, timescale: 60) , actualTime: nil)
            return UIImage(cgImage: thumbnailImage)
        } catch let error {
            print(error)
        }

        return nil
    }
}
