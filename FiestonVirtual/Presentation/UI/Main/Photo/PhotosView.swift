//
//  PhotosView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct PhotosView: View {
    
    var onCategorySelected: (_ categoryIndex: Int) -> Void
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox: UIImage?
    @State var fileURL: URL?
    @State private var eventCode: String = ""
    @State private var isImageSelected = false
    @State var fileType = ""
    
    let viewmodel = PhotosViewModel()
    
    var body: some View {
        ZStack {
            
            Color.deep_purple_intense.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                if(isImageSelected) {
                    VStack {
                        
                        ZStack {

                            Image(uiImage: self.imageInBlackBox ?? UIImage())
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                            
                            VStack {
                                Spacer()
                                Text(self.fileType)
                                    .foregroundColor(.white)
                                
                            }
                            
                        }.frame(height: 280)
                        TextField("Ingrese un título (opcional)", text: self.$eventCode)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            guard let fileURL = fileURL else { return }
                            print(fileURL)
                            //self.viewmodel.uploadFile(data: fileURL)
                            self.onCategorySelected(1)
                        }) {
                            Text("Publicar")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.orange_500.cornerRadius(8))
                                .foregroundColor(Color.white)
                        }
                    }
                    
                } else {
                    informationView()
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
                            selectedImage: self.$imageInBlackBox,
                            fileURL: self.$fileURL,
                            fileType: self.$fileType
                        ) { isImageSelected, fileURL in
                            self.isImageSelected = isImageSelected
                            //                            self.viewmodel.uploadFile(data: fileURL)
                        }
                    }
                }
                
            }.padding(.all, 10)
        }
        
    }
    
    func informationView() -> some View {
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
    @Binding var selectedImage: UIImage?
    @Binding var fileURL: URL?
    @Binding var fileType: String
    
    var onImageFromPickerSelected: (_ isImageSelected: Bool, _ fileURL: URL) -> Void
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIViewController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        pickerController.allowsEditing = false
        pickerController.mediaTypes = ["public.image", "public.movie"]
        pickerController.sourceType = .photoLibrary
        return pickerController
    }
    
    func makeCoordinator() -> GalleryCoordinator {
        return GalleryCoordinator(parent: self) { isImageSelected, fileURL in
            self.onImageFromPickerSelected(isImageSelected, fileURL)
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView() {_ in
            
        }
    }
}
