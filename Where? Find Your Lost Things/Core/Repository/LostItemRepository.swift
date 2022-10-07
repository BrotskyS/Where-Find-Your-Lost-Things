//
//  LostItemRepository.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 29.09.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine
import SwiftUI
import Firebase
import FirebaseStorage

class LostItemRepository: ObservableObject {
    private let db = Firestore.firestore()
    private let path = "items"
    
    private let storage = Storage.storage()
    
    @Published var lostItems = []
    
    
    
    func get(){
        
    }
    
    
    
    func add(_ lostItem: LostItem){
        do {
            try db.collection(path).addDocument(from: lostItem)
        } catch {
            print("FAIL to add to firestore")
        }
    }
    
    func uploadPhoto(_ image: UIImage){
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        // Convert the image into JPEG and compress the quality to reduce its size
        let data = image.jpegData(compressionQuality: 0.2)
        
        // Change the content type to jpg
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        
        // Upload the image
        if let data = data {
            storageRef.putData(data, metadata: metadata) { (metadata, error) in
                if let error = error {
                    print("Error while uploading file: ", error)
                }
                
                if let metadata = metadata {
                    print("Metadata: ", metadata)
                }
            }
        }
    }
}
