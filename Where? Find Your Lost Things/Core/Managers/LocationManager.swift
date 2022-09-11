//
//  LocationManager.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import Foundation
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 37.334_900, longitude: -122.009_020)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 15, longitudeDelta: 15 )
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    
    
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingLocation , span: MapDetails.defaultSpan
     )
    
    func checkIfLocatinServicesIsEnable() {
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Please. Enable location services in phone")
        }
    }
    
    private func checkLocationAuth(){
        guard let locationManager = locationManager else {
            return
        }
        
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("You location is restricted")
        case .denied:
            print("You location is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            if let coordinate = locationManager.location {
                region = MKCoordinateRegion(center: coordinate.coordinate, span: MapDetails.defaultSpan )
            }
       
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }
}
