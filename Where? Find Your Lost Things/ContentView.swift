//
//  ContentView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI
import FirebaseCore


struct ContentView: View {

    @StateObject var  userRepository = UserRepository()
    var body: some View {
        NavigationView {
            if userRepository.isUserLogin {
                TabsView()
            } else{
                LoginView()
            }
         
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
