//
//  LostItemView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 13.09.2022.
//

import SwiftUI
import MapKit

struct LostItemView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = LostItemViewModel()
    
    var body: some View {
        ZStack{
            Color("Background").ignoresSafeArea()
            
            scrollContent
            
          
   
        }
        .safeAreaInset(edge: .bottom, content: {
            HStack{
                Text("Call")
                    .foregroundColor(.accentColor)
                    .font(.headline)
                    .padding(7)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.accentColor, lineWidth: 2)
                            
                     
                    )
                Text("Write")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding(7)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.accentColor)
                            
                     
                    )
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(10, corners: [.topLeft, .topRight])
            
        })
        .navigationTitle("Lost")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    
    var scrollContent: some View {
        ScrollView {
            VStack(alignment: .leading){
                header
                
                
              
                
                VStack(alignment: .leading, spacing: 5){
                    Text("\(Date.now.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                    
                    Text("Загубив ключі")
                        .font(.title2)
                        .bold()
                    
                    Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Suspendisse ultrices gravida dictum fusce. Id interdum velit laoreet id. A cras semper auctor neque. Ipsum nunc aliquet bibendum enim facilisis gravida neque convallis. Ornare lectus sit amet est placerat in egestas erat imperdiet. Duis tristique sollicitudin nibh sit. Habitasse platea dictumst vestibulum rhoncus est pellentesque elit. Eleifend donec pretium vulputate sapien nec sagittis aliquam malesuada bibendum. Nunc congue nisi vitae suscipit tellus mauris a. At consectetur lorem donec massa sapien. Cras ornare arcu dui vivamus.")
                    
                    
                    Divider()
                    VStack{
                        Text("Користувач")
                            .bold()
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(alignment: .bottom){
                            AsyncImageView(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg"))
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading){
                                Text("Сергій")
                                    .bold()
                                    .padding(.bottom, 3)
                                Text("з грудня 2018")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                Text("Online")
                                    .font(.caption)
                                    .foregroundColor(.accentColor)
                            }
                            
                            Spacer()
                            HStack{
                                Image(systemName: "flag")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                                
                                Text("Поскаржитися")
                                    .font(.caption2)
                                    .bold()
                                    .underline()
                            }
                        }
                    }
                    .padding(.vertical)
           
                    
                    Divider()
                    
                    VStack {
                        
                        Text("Локація")
                            .bold()
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack(alignment: .center){
                            Image(systemName: "location")
                                .padding(.top, 10)
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("Київ")
                                    .fontWeight(.bold)

                                Text("Соломянський район")
                                    .font(.subheadline)
                                    .padding(.bottom, 5)
                                
                                Text("За 1 км від вас")
                                    .foregroundColor(.gray)
                         
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Map(coordinateRegion: $vm.region)
                                .frame(width: 100, height: 100)
                                .cornerRadius(10)
                        }
                       
                    }
                    .padding(.vertical)
                    
                    
                    
                }
                .padding()
            }
            
        }
    }
    var header: some View {
        ZStack{
            TabView{
                AsyncImage(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                AsyncImage(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                } placeholder: {
                    ProgressView()
                }
                
            }
            
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
        }
        
        .frame(height: 200)
        
    }
}

struct LostItemView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LostItemView()
        }
    }
}
