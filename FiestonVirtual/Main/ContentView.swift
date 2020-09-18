//
//  ContentView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/9/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = DependencyProvider().assembler.resolver.resolve(CodeVerificationViewModel.self)!
    
    
    @State var imageData: Data = .init(capacity: 0)
    @State var show = false
    @State var imagePicker = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    
    
    var body: some View {
        CodeVerificationView(viewModel: viewModel)
        
//        NavigationView {
//            ZStack {
//                NavigationLink(
//                    destination: ImagePicker(show: $imagePicker, image: $imageData, source: source),
//                    isActive: $imagePicker,
//                    label: {
//                        Text("hOLA")
//                    })
//
//                VStack {
//                    if imageData.count != 0 {
//                        Image(uiImage: UIImage(data: self.imageData)!)
//                            .resizable()
//                            .clipShape(Circle())
//                            .frame(width: 250, height: 250)
//                            .overlay(Circle().stroke(Color.red, lineWidth: 5))
//                            .foregroundColor(Color.purple)
//                    } else {
//                        Image(systemName: "person.fill")
//                            .resizable()
//                            .clipShape(Circle())
//                            .frame(width: 250, height: 250)
//                            .overlay(Circle().stroke(Color.red, lineWidth: 5))
//                            .foregroundColor(Color.purple)
//                    }
//                    Button(action: {
//                        self.show.toggle()
//                    }, label: {
//                        Text("Take a Photo!")
//                            .frame(width: 150, height: 150, alignment: .center)
//                            .background(Color.green)
//                    })
//                }.actionSheet(isPresented: $show, content: {
//                    ActionSheet(title: Text("Take a photo or select a liurary"), message: Text(""), buttons: [ActionSheet.Button.default(Text("Photo Library"), action: {
//                        self.source = .photoLibrary
//                        self.imagePicker.toggle()
//                    }), .default(Text("Cmaera"), action: {
//                        self.source = .camera
//                        self.imagePicker.toggle()
//                    })])
//                })
//            }
//        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var show: Bool
    @Binding var image: Data
    
    var source: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent1: self)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.sourceType = source
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.show.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            let data = image.pngData()
            self.parent.image = data!
            self.parent.show.toggle()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
