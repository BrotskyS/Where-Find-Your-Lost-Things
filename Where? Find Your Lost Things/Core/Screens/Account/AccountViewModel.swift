//
//  AccountViewModel.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 18.09.2022.
//

import Foundation


class AccountViewModel: ObservableObject {
    private let userRepository = UserRepository()
    
    func logout(){
        userRepository.logout()
    }
}
