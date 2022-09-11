//
//  TabView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            
            AddView()
                .tabItem {
                    Label("Add", systemImage: "plus.circle.fill")
                        .font(.largeTitle)
                }
            
            HomeView()
                .tabItem {
                    Label("Notification", systemImage: "bell")
                }
            
            HomeView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
