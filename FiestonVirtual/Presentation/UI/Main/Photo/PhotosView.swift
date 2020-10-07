//
//  PhotosView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct PhotosView: View {
    
    @EnvironmentObject var settings: UserSettings
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(PhotosViewModel.self)!
    
    @Binding var selectedTab: Int
    @Binding var notifyGallery: Bool
    
    @State var isShowingImagePicker = false
    @State var imageInBlackBox: UIImage?
    @State var fileURL: URL?
    @State private var postTitle: String = ""
    @State private var isImageSelected = false
    @State var fileType = ""
    
    var body: some View {
        LoadingView(isShowing: self.$viewModel.isLoading) {
            
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
                            TextField("Ingrese un título (opcional)", text: self.$postTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            Button(action: {
                                guard let fileURL = fileURL else { return }
                                print(fileURL)
                                self.viewModel.uploadFile(data: fileURL, postTitle: postTitle)
                                
                            }) {
                                Text("Publicar")
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .background(Color.orange_500.cornerRadius(8))
                                    .foregroundColor(Color.white)
                            }
                        }
                        
                    } else {
                        Image("alert")
                        informationView()
                        Button(action: {
                            self.isShowingImagePicker.toggle()
                        }) {
                            Text("Elegir")
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                .background(Color.deep_purple_500.cornerRadius(8))
                                .foregroundColor(Color.white)
                        }
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImageAndVideoPickerView(
                                isPresented: self.$isShowingImagePicker,
                                selectedImage: self.$imageInBlackBox,
                                fileURL: self.$fileURL,
                                fileType: self.$fileType
                            ) { isImageSelected, fileURL in
                                self.isImageSelected = isImageSelected
                            }
                        }
                    }
                    
                }.padding(.all, 10)
                
            }
        }.onAppear(perform: {
            isImageSelected = false
            postTitle = ""
        })
        .alert(isPresented: self.$viewModel.uploadPhotoHasFinished, content: {
            Alert(
                title: Text(self.viewModel.uploadPhotoMessage),
                dismissButton: .default(Text("Aceptar"), action: {
                    selectedTab = TAB_GALLERY_ID
                    settings.refreshGallery = true
                })
            )
        })
        
    }
    
    func informationView() -> some View {
        VStack(spacing: 10) {
            
            Text("1 - Presiona el botón ELEGIR para publicar una foto o video de la galería de tu celular.")
                .foregroundColor(Color.white)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .multilineTextAlignment(.center)
            
            
            Text("2 - Presiona el botón SUBIR y espera a que se publique tu foto o video.")
                .foregroundColor(Color.white)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .multilineTextAlignment(.center)
            
            
            Text("El video debe durar como máximo 40 segundos")
                .foregroundColor(Color.amber_600)
                .fixedSize(
                    horizontal: false,
                    vertical: true
                )
                .multilineTextAlignment(.center)
            
        }
        .padding(20)
        
    }
}

struct PhotosView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosView(selectedTab: .constant(1), notifyGallery: .constant(false))
    }
}
