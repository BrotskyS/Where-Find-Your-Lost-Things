//
//  LoginView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 07.10.2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModel()
    var body: some View {
        VStack(alignment: .leading, spacing: 30){
            Circle()
            Spacer()
            
            Text(vm.loginType == .login ? "Login" : "Sign Up")
                .font(.largeTitle.bold())
            
            
            
            
            
            Section{
                VStack{
                    CustomTextInput(text: $vm.email, placeholder: "Email", icon: "envelope", isError: !vm.isEmailValid)
                        .autocapitalization(.none)
                        .background(.clear)
                        .clipped()
                    
                    if !vm.isEmailValid && !vm.email.isEmpty {
                        Text(vm.emailPrompt)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                }
                
                
                
                
                
                VStack{
                    CustomTextInput(text: $vm.password, placeholder: "Password", icon: "lock", isSecureFiled: true, isError: !vm.isPasswordValid)
                    
                    if !vm.isPasswordValid && !vm.password.isEmpty {
                        Text(vm.passwordPrompt)
                            .font(.footnote)
                            .foregroundColor(.red)
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    }
                }
                
                
                if vm.loginType == .register {
                    VStack{
                        CustomTextInput(text: $vm.passwordRepeate, placeholder: "Repeat Password", icon: "lock", isSecureFiled: true, isError: !vm.isPasswordRepeateValid)
                        
                        if !vm.isPasswordRepeateValid && !vm.passwordRepeate.isEmpty {
                            Text(vm.confirmRepeatePrompt)
                                .font(.footnote)
                                .foregroundColor(.red)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            
                        }
                    }
                    
                }
            }
            
            if vm.loginType == .login {
                Button{
                    
                } label: {
                    Text("Forgot Password?")
                        .foregroundColor(.accentColor)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }
            
            HStack(alignment: .top){
                Text("By signing up, you are agree to our ")
                
                    .foregroundColor(.gray)
                + Text("Terms & Conditions ")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.accentColor)
                + Text("and ")
                
                    .foregroundColor(.gray)
                + Text("Privacy Polisy")
                    .fontWeight(.semibold)
                    .foregroundColor(Color.accentColor)
            }
            .font(.caption2)
            
            
            
            VStack{
                let isDisabled = vm.loginType == .login ? !vm.canSubmitLogin : !vm.canSubmitRegister
                
                CustomButton(text:  vm.loginType == .login ? "Login" : "Continue", isDisabled: isDisabled){
                    vm.onAuth()
                }
            
                
                
                
                
                LabelledDivider(label: "OR",  horizontalPadding: 15, verticalPadding: 0)
                
                CustomButton(text: "Login with Google", leftIcon: Image("Google"), backgroundColor: Color("Secondary")){
                    
                }
            }
            
            
            HStack(spacing: 5){
                Text(vm.loginType == .login ?  "First Time?" : "Joined us before?")
                    .foregroundColor(.gray)
                
                
                Button {
                    vm.changeloginType()
                } label: {
                    Text(vm.loginType == .login ? "Register" : "Login")
                        .foregroundColor(.accentColor)
                        .fontWeight(.semibold)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
        }
        .padding()
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
