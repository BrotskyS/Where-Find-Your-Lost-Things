//
//  CustomTextInput.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 07.10.2022.
//

import SwiftUI

struct CustomTextInput: View {
    @Binding var text: String
    @State var showSecureFiled: Bool = true
    
    var placeholder: String
    var icon: String
    var isSecureFiled: Bool = false
    var isError: Bool = false
    
    
    
    /// TextFiled with secure option
    init(text: Binding<String>, placeholder: String, icon: String, isSecureFiled: Bool, isError: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isSecureFiled = isSecureFiled
        self.isError = isError
        
    }
    
    
    ///  TextFiled without secure option
    init(text:  Binding<String>, placeholder: String, icon: String, isError: Bool) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isError = isError
    }
    
    var body: some View {
        VStack (alignment: .trailing){
            HStack(alignment: .center, spacing: 0){
                Image(systemName: icon)
                    .font(.title3)
                    .frame(minWidth: 50, alignment: .leading)
                
                VStack{
                    HStack{
                        if isSecureFiled && showSecureFiled {
                            SecureField(placeholder, text: $text)
                        }else {
                            TextField(placeholder, text: $text)
                        }
                        
                        
                        if isSecureFiled {
                            Button{
                                showSecureFiled.toggle()
                            } label: {
                                Image(systemName: showSecureFiled ? "eye.slash": "eye")
                                    .animation(.default, value: showSecureFiled)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        
                    }
                    
                    
                    Divider()
                        .frame(height: isError ?  2 : 1)
                        .background(isError ? .red : .secondary)
                }
            }
        }
        
    }
}

struct CustomTextInput_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextInput(text: .constant(""), placeholder: "Email", icon: "eye.slash",isError: true)
            .padding()
    }
}
