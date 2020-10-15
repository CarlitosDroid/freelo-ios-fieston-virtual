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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
