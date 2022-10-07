//
//  LostItemView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 13.09.2022.
//

import Foundation
import MapKit

class LostItemViewModel: ObservableObject {
    @Published var region = MKCoordinateRegion(
         center: CLLocationCoordinate2D(latitude: 37.334_900,
                                        longitude: -122.009_020),
         latitudinalMeters: 750,
         longitudinalMeters: 750
     )
}
