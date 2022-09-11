//
//  ChatView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
            ScrollView{
                Text("Chat")
            }
            .navigationTitle("Anton")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    AsyncImage(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")) { image in
                              image
                                  .resizable()
                                  .aspectRatio(contentMode: .fill)
                                  
                          } placeholder: {
                              ProgressView()
                          }
                          .frame(width: 40, height: 40)
                          .clipShape(Circle())
                }
            }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChatView()
        }
    }
}
