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
 
    var videoUrl = ""
    
    var body: some View {
        VStack {
            PlayerPickerView(videoUrl: videoUrl)
            Spacer()
        }
    }
}

struct PlayerPickerView : UIViewControllerRepresentable {
    
    private var videoUrl = ""
    
    init(videoUrl: String) {
        self.videoUrl = videoUrl
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = AVPlayerViewController()
        let player1 = AVPlayer(url: URL(string: self.videoUrl)!)
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
