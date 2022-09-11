//
//  ContentView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    var body: some View {
        TabsView()
            .environmentObject(locationManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
