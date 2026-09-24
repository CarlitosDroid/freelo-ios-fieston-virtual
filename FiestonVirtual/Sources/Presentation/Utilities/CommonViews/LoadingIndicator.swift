//
//  LoadingIndicator.swift
//  FiestonVirtual
//
//  Created by Carlos Leonardo Camilo Vargas Huaman on 9/8/20.
//  Copyright © 2020 Spydevs. All rights reserved.
//

import SwiftUI

struct LoadingIndicator: UIViewRepresentable {

    typealias UIViewType = UIActivityIndicatorView

    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<LoadingIndicator>) -> LoadingIndicator.UIViewType {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ view: LoadingIndicator.UIViewType, context: UIViewRepresentableContext<LoadingIndicator>) {
        view.startAnimating()
    }
    
}
