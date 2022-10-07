//
//  Image.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 07.10.2022.
//

import Foundation
import SwiftUI


struct ImageViewerModifier: ViewModifier {
    @State private var showViewer: Bool = false
    
    var image: UIImage
    let onDelete: (() -> Void)
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                showViewer = true
            }
            .fullScreenCover(isPresented: $showViewer) {
                ImageViewer(showViewer: $showViewer, image: image)
            }
    }
}

extension View {
    func showPreview(image: UIImage, onDelete onDeleteAction: @escaping () -> Void) -> some View {
        self.modifier(ImageViewerModifier(image: image, onDelete: {
            onDeleteAction()
        }))
    }
}
