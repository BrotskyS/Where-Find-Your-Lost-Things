//
//  ChatViewModel.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 13.09.2022.
//

import Foundation


class ChatViewModel: ObservableObject {
    @Published var messageText: String = ""
}
