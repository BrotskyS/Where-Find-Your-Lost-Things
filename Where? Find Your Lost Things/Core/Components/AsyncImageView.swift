//
//  AsyncImageView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 13.09.2022.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    var body: some View {
        AsyncImage(url: url) { image in
                  image
                      .resizable()
                      .aspectRatio(contentMode: .fill)
                      
              } placeholder: {
                  ProgressView()
              }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg"))
    }
}
