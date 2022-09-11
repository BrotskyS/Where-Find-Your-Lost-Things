//
//  MapView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI
import MapKit

struct PlaceAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(.red)
            
            Image(systemName: "arrowtriangle.down.fill")
                .font(.caption)
                .foregroundColor(.red)
                .offset(x: 0, y: -5)
        }
    }
}


struct MapView: View {
    @ObservedObject var vm = MapViewModel()
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        NavigationView{
            ZStack{
                Map(coordinateRegion: $locationManager.region, showsUserLocation: true, annotationItems: vm.annotations) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        PlaceAnnotationView()
                            .scaleEffect(item.name == vm.selectedAnotation ? 1 : 0.7)
                            .animation(.default, value: vm.selectedAnotation)
                            .onTapGesture {
                                vm.setSelectedAnotation(name: item.name)
                            }
                    }
                    
                }
                .onAppear{
                    locationManager.checkIfLocatinServicesIsEnable()
                }
                .ignoresSafeArea()
                
                
                if vm.selectedAnotation != nil {
                    selectedItem
                }
                
                
              
            }
        }
    }
    
    
    var selectedItem: some View {
        HStack{
            AsyncImage(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(5)
                
            } placeholder: {
                ProgressView()
            }
            .frame(width: 70, height: 70)
            
            VStack(alignment: .leading){
                Text(vm.selectedAnotation ?? "")
                    .bold()
                Text("Загубив ключі в парку, на центральносу проході між кримським мостос")
                    .lineLimit(2)
                    .font(.caption)
            }
            
            Image(systemName: "xmark")
                .padding(7)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
                .shadow(color: Color("Shadow").opacity(0.2), radius: 10, x: 0, y: 0)
                .onTapGesture {
                    vm.setSelectedAnotation(name: nil)
                }
            
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        .padding()
        .frame(maxHeight: .infinity, alignment: .bottom)
        .transition(.move(edge: .bottom))
        .zIndex(1)
    }
    
    
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(LocationManager())
    }
}
