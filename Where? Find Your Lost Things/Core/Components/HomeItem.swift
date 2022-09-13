//
//  HomeItem.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct HomeItem: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")) { image in
                      image
                          .resizable()
                          .aspectRatio(contentMode: .fill)
                          
                  } placeholder: {
                      ProgressView()
                  }
                  .frame(width: 170, height: 170)
                  .overlay(
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.green)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .shadow(color: Color("Shadow").opacity(0.5), radius: 10, x: 0, y: 0)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding()
                  )
            VStack(alignment: .leading, spacing: 5) {
                Text("Загубились ключі")
                    .font(.title3.bold())
                
                VStack(alignment: .leading){
                    Text("Тернопіль. Архипенка")
                    Text("04 вер. 20:24")
                }
                .foregroundColor(.gray)
                .font(.caption2)
            }
            .padding(10)
     
                
        }
        
        .background(Color("Secondary"))
        .cornerRadius(10)
        
    }
}

struct HomeItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeItem()
    }
}
