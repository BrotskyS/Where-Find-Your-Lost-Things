//
//  MessageView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 13.09.2022.
//

import SwiftUI

struct MessageView: View {
    var message: Message
    @State private var showTime: Bool = false
    
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing){
            HStack{
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(message.received ? Color.accentColor : .gray)
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                withAnimation {
                    showTime.toggle()
                }
            }
            
            if showTime {
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing, 25)
            }
            
        }
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(message: Message(id: "", text: "Hello, how are you?", received: true, timestamp: Date.now))
    }
}
