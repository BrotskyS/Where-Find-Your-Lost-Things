//
//  CustomNavBarView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.10.2022.
//

import SwiftUI

struct CustomNavBarView<Content>: View where Content: View {
    var title: String = ""
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    var body: some View {
        content
            .safeAreaInset(edge: .top, content: {
                HStack{
                    Spacer()
                    Text(title)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding(.bottom, 10)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .overlay {
                    Divider()
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            })
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomNavBarView(title: "Title"){
            List{
                Text("Hello")
                Text("Hell02")
                Text("Hello3")
                
            }
        }
    }
}
