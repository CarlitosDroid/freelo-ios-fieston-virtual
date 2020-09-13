//
//  VideoView.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/11/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI
import AVKit

struct VideoView: View {
 
    var body: some View {
        VStack {
            PlayerPickerView().frame(
                height: UIScreen.main.bounds.height / 3
            )
            Spacer()
        }
    }
}

struct PlayerPickerView : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()
        let url = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
        let player1 = AVPlayer(url: URL(string: url)!)
        controller.player = player1
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
