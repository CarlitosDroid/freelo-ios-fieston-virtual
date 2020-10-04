//
//  CaptureImageView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/17/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct CaptureImageView: UIViewControllerRepresentable {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    
    var onImageFromPickerSelected: (_ fileURL: UIImage) -> Void
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, onImageFromPickerSelected: onImageFromPickerSelected)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
    
}
