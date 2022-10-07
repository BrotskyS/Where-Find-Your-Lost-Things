//
//  LostItem.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 29.09.2022.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore


enum AddType: Codable {
    case lost, found
}

struct LostItem: Identifiable, Codable {
    @DocumentID var id: String?
    let title: String
    let description: String
    let itemType: AddType
    let phoneNumber: String
    let price: Int?
    let geo: GeoPoint
    let imageString: [String]
}
