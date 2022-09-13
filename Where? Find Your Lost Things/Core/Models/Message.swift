//
//  Message.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 13.09.2022.
//

import Foundation


struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
}
