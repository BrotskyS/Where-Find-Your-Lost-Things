//
//  SetPinMapView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 03.10.2022.
//

import SwiftUI
import MapKit

struct SetPinMapView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var currentRegion: MKCoordinateRegion
    @State var region: MKCoordinateRegion
    
    var body: some View {
        ZStack{
            
            Group{
                Map(coordinateRegion: $region)
                    .frame(maxWidth: .infinity, minHeight: 200)
              
                
                
                
                CustonMapPin()
            }
            .ignoresSafeArea()
           
            
            Button{
                currentRegion = region
                presentationMode.wrappedValue.dismiss()
            } label: {
                saveButton
                
            }
            .buttonStyle(.plain)
            
        }
     
        
    }
    
    
    var saveButton: some View {
        Text("Save")
            .fontWeight(.semibold)
            .font(.subheadline)
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(10)
            .padding()
            .frame(maxHeight: .infinity, alignment: .bottom)
        
            .zIndex(1)
        
    }
}

struct SetPinMapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SetPinMapView(currentRegion: .constant(MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.334_900,
                                               longitude: -122.009_020),
                latitudinalMeters: 750,
                longitudinalMeters: 750
            )), region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.334_900,
                                               longitude: -122.009_020),
                latitudinalMeters: 750,
                longitudinalMeters: 750
            ))
        }
    }
}
