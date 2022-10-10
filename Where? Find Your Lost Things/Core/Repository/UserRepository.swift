//
//  UserRepository.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 08.10.2022.
//

import Foundation
import FirebaseAuth

class UserRepository: ObservableObject {
    @Published var isUserLogin = false
    
    
    init(){
        checkIfUserLogin()
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed due to error:", err)
                return
            }
            print("Successfully logged in with ID: \(result?.user.uid ?? "")")
        }
    }
    
    func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { result, err in
            if let err = err {
                print("Failed due to error:", err)
                return
            }
            print("Successfully created account with ID: \(result?.user.uid ?? "")")
        })
    }
    
    func logout(){
        try? Auth.auth().signOut()
    }
    
    private func checkIfUserLogin(){
        Auth.auth().addStateDidChangeListener() { auth, user in
            print("user: \(user?.uid)")
              if user != nil {
                  self.isUserLogin = true
              }else{
                  self.isUserLogin = false
              }
          }
    }
}
