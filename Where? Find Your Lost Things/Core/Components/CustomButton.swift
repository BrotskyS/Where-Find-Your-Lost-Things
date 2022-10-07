//
//  CustomButton.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 07.10.2022.
//

import SwiftUI

struct CustomButton: View {
    var text: String
    var leftIcon: Image?
    var isLoading: Bool = false
    var loadingText: String = ""
    var isDisabled: Bool = false
    var backgroundColor: Color = Color.accentColor
    

    var body: some View {
        Button{
            
        } label: {
            HStack{
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    
                    Text(loadingText)
                        .padding()
                        .foregroundColor(.white)
                        .font(.body.bold())
                } else{
                    Text(text)
                        .padding()
                        .foregroundColor(.white)
                        .font(.body.bold())
                }
             
                    
            }
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(15)
            
            .opacity(isDisabled ? 0.7 : 1)
            .animation(.default, value: isDisabled)
            .overlay {
                ZStack{
                    if let icon = leftIcon {
                        icon
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
        .disabled(isDisabled)
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton(text: "Login", leftIcon: Image("Google"), isLoading: true, loadingText: "Loading...")
            .padding()
    }
}
