//
//  Coordinator.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/17/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var isCoordinatorShown: Bool
    var onImageFromPickerSelected: (_ fileURL: UIImage) -> Void
    
    init(isShown: Binding<Bool>, onImageFromPickerSelected:  @escaping (_ fileURL: UIImage) -> Void) {
        _isCoordinatorShown = isShown
        self.onImageFromPickerSelected = onImageFromPickerSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        onImageFromPickerSelected(unwrapImage)
        isCoordinatorShown = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShown = false
    }
}
