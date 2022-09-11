//
//  AddViewModel.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import Foundation
import MapKit

enum AddType {
    case lost, found
}

class AddViewModel: ObservableObject {
    @Published var addType: AddType = .lost
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var phone: String = ""
    
    @Published var images: [UIImage] = []
    @Published var picker: Bool = false
    
    @Published var region = MKCoordinateRegion(
         center: CLLocationCoordinate2D(latitude: 37.334_900,
                                        longitude: -122.009_020),
         latitudinalMeters: 750,
         longitudinalMeters: 750
     )
}
