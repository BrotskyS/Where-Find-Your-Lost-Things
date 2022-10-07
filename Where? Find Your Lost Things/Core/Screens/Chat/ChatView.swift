//
//  ChatView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var vm = ChatViewModel()
    
    var title: String = "Anton"
    
    var messageArray = ["Hi", "How are you?", "Lets come to me"]
    
    var body: some View {
        VStack{
            ScrollView{
                ScrollViewReader { value in
                    ForEach(messageArray, id: \.self) { message in
                        MessageView(message: Message(id: "123", text: message, received: false, timestamp: Date()))
                    }
                    .onAppear{
                        value.scrollTo(messageArray.last,  anchor: .center)
                    }
                }
            }
            textField
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.body.bold())
                        .foregroundColor(.accentColor)
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    
                    AsyncImageView(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg"))
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "phone")
                    .font(.body.bold())
                    .foregroundColor(.accentColor)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    var textField: some View {
        HStack{
            TextField("Message", text: $vm.messageText)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color("Secondary"))
                .cornerRadius(20)
            Image(systemName: "arrow.up")
                .padding(10)
                .foregroundColor(.white)
                .background(Color.accentColor)
                .clipShape(Circle())
        }
        .padding()
        .background(.ultraThinMaterial)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ChatView()
        }
    }
}


