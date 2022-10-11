//
//  HomeView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct HomeView: View {
    var data = Array(1...20)
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    var body: some View {
        CustomNavBarView(title: "Home"){
            ZStack{
                Color("Background").ignoresSafeArea()
                
                content
            }
        }
    }
    
    var content: some View {
        ScrollView {
            VStack{
                Text("Near You")
                    .font(.largeTitle.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                    ForEach(data, id: \.self){ item in
                        NavigationLink(destination: LostItemView()) {
                            HomeItem()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer()
                Text("Hello")
            }
            .padding()
            
        }
//        .searchable(text: .constant(""), placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search"))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
