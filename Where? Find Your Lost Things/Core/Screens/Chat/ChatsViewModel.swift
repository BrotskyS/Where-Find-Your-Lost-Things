//
//  ChatViewModel.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import Foundation


class ChatsViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var title: String = ""
    @Published var isChatOpen: Bool = false
}
