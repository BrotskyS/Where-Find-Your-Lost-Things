//
//  LoginViewModel.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 07.10.2022.
//

import Foundation
import SwiftUI
import Combine

enum LoginType {
    case login, register
}

class LoginViewModel: ObservableObject {
    @Published var loginType: LoginType = .login
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordRepeate: String = ""
    
    
    @Published var isEmailValid = false
    @Published var isPasswordValid = false
    @Published var isPasswordRepeateValid = false
    @Published var canSubmitLogin = false
    @Published var canSubmitRegister = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    
    private let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&])[A-Za-z\\d@$!%*#?&]{8,}$")
    
    private let userRepository = UserRepository()
    
    
    init(){
        $email
            .dropFirst()
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .sink(receiveValue: { value in
                withAnimation {
                    self.isEmailValid = value
                }
            })
            .store(in: &cancellableSet)
        
        
        $password
            .dropFirst()
            .map { password in
                return self.passwordPredicate.evaluate(with: password)
            }
            .sink(receiveValue: { value in
                withAnimation {
                    self.isPasswordValid = value
                }
            })
            
            .store(in: &cancellableSet)
        
        
        Publishers.CombineLatest($password, $passwordRepeate)
            .map { password, passwordRepeate in
                return password == passwordRepeate
            }
            .sink(receiveValue: { value in
                withAnimation {
                    self.isPasswordRepeateValid = value
                }
            })
            .store(in: &cancellableSet)
        
        
        Publishers.CombineLatest3($isEmailValid, $isPasswordValid, $isPasswordRepeateValid)
            .map {isEmailValid, isPasswordValid, isPasswordRepeateValid in
                return (isEmailValid && isPasswordValid && isPasswordRepeateValid)
            }
            .sink(receiveValue: { value in
                withAnimation {
                    self.canSubmitRegister = value
                }
            })
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest($isEmailValid, $isPasswordValid)
            .map {isEmailValid, isPasswordValid in
                return (isEmailValid && isPasswordValid)
            }
            .sink(receiveValue: { value in
                withAnimation {
                    self.canSubmitLogin = value
                }
            })
            .store(in: &cancellableSet)
        
    }
    
    var emailPrompt: String {
        !isEmailValid ? "Enter a valid email address" : ""
    }
    
    var confirmRepeatePrompt: String {
        !isPasswordRepeateValid ? "Password fields to not match" : ""
       }
    
    var passwordPrompt: String {
        !isPasswordValid ?  "Must be at least 8 characters containing at least one number and one letter and one special character." : ""
       }
    
    
    
    /// Reset all propersies to initial value
    private func sesetAllFields(){
        email = ""
        password = ""
        passwordRepeate = ""
        
        isEmailValid = true
        isPasswordValid = true
        isPasswordRepeateValid = true
    }
    
    func changeloginType(){
        withAnimation {
            loginType = loginType  == .login ? .register : .login
            
            sesetAllFields()
        }
    }
    
    func onAuth(){
        if loginType == .login {
            userRepository.loginUser(email: email, password: password)
        } else if loginType == .register {
            userRepository.createUser(email: email, password: password)
        }
    }
    
}
