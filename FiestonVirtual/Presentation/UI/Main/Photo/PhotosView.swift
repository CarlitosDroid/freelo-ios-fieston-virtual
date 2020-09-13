//
//  PhotosView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct PhotosView: View {
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox = UIImage()
    @State private var eventCode: String = ""
    @State private var isImageSelected = false
    
    let viewmodel = PhotosViewModel()
    
    var body: some View {
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                if(isImageSelected) {
                    VStack {
                        
                        ZStack {
                            Image(uiImage: self.imageInBlackBox)
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 300)
                            
                            Text("Image")
                            
                        }
                        TextField("Ingrese un título (opcional)", text: self.$eventCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                } else {
                    emptyView()
                }
                
                
                ZStack {
                    if(isImageSelected) {
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }) {
                            Text("Publicar")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.orange_500.cornerRadius(8))
                                .foregroundColor(Color.white)
                        }
                    } else {
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }) {
                            Text("Elegir")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.deep_purple_500.cornerRadius(8))
                                .foregroundColor(Color.white)
                        }.sheet(isPresented: $isShowingImagePicker) {
                            ImagePickerView(
                                isPresented: self.$isShowingImagePicker,
                                selectedImage: self.$imageInBlackBox) { isImageSelected, fileURL in
                                    self.isImageSelected = isImageSelected
                                    self.viewmodel.uploadFile(data: fileURL)
                            }
                        }
                    }
                    
                }
                
            }.padding(.bottom, 50)
        }
        
    }
    
    func emptyView() -> some View {
        VStack {
            Text("1 - Presiona el botón ELEGIR para publicar una\n foto o video de la galería de tu celular.")
                .foregroundColor(Color.white)
            Text("2 - Presiona el botón SUBIR y espera a que se\n publique tu foto o video.")
                .foregroundColor(Color.white)
            Text("El video debe durar como\n máximo 40 segundos")
                .foregroundColor(Color.amber_600)
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage
    
    var onImageFromPickerSelected: (_ isImageSelected: Bool, _ fileURL: URL) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        return pickerController
    }
    
    func makeCoordinator() -> ImagePickerView.Coordinator {
        return Coordinator(parent: self) { isImageSelected, fileURL in
            self.onImageFromPickerSelected(isImageSelected, fileURL)
        }
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        let parent: ImagePickerView
        var onImageFileSelected: (_ isImageSelected: Bool, _ fileUrl: URL) -> Void
        

        init(parent: ImagePickerView, onImageSelected: @escaping (_ isImageSelected: Bool, _ fileURL: URL) -> Void) {
            self.parent = parent
            self.onImageFileSelected = onImageSelected
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let mediaUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                onImageFileSelected(true, mediaUrl)
            }
            
            if let selectedImageFromPicker = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                onImageFileSelected(true, selectedImageFromPicker)
            }
            
            self.parent.isPresented = false
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView()
    }
}
