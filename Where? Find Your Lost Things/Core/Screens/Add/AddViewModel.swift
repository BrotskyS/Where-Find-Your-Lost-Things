//
//  AddViewModel.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import Foundation
import MapKit
import FirebaseFirestore
import Combine


class AddViewModel: ObservableObject {
    @Published var itemType: AddType = .lost
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var phoneNumber: String = ""
    @Published var price: String = ""
    @Published var images: [UIImage] = []
    @Published var picker: Bool = false
    @Published var showFullMap: Bool = false
    
    @Published var region = MKCoordinateRegion(
         center: CLLocationCoordinate2D(latitude: 37.334_900,
                                        longitude: -122.009_020),
         latitudinalMeters: 750,
         longitudinalMeters: 750
     )
    
    @Published var canSubmit: Bool = false
    let maxDescriptionCountText: Int = 200
    let maxTitleCountText: Int = 60
    
    private var cancalable: Set<AnyCancellable> = []
    private let lostItemRepository = LostItemRepository()
    
    
    init(){
        Publishers.CombineLatest4($images, $title, $description, $phoneNumber)
            .map{images, title, description, phoneNumber in
                return (!images.isEmpty && !title.isEmpty && !description.isEmpty && !phoneNumber.isEmpty )
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancalable)
    }
    
    func save(){
//        lostItemRepository.add(
//            LostItem(
//                title: title,
//                description: description,
//                itemType: itemType,
//                phoneNumber: phoneNumber,
//                price: Int(price),
//                geo: GeoPoint(
//                    latitude: region.center.latitude,
//                    longitude: region.center.longitude
//                )
//            )
//        )
        if let image = images.first {
            lostItemRepository.uploadPhoto(image)
        }
        
    }
}
