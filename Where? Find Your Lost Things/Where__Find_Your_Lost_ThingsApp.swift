//
//  Where__Find_Your_Lost_ThingsApp.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI
import Firebase

@main
struct Where__Find_Your_Lost_ThingsApp: App {
    @StateObject var locationManager = LocationManager()
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
                ContentView()
                    .environmentObject(locationManager)
        }
    }
}
