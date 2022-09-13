//
//  ChatView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 11.09.2022.
//

import SwiftUI

struct ChatsView: View {
    @ObservedObject var vm = ChatsViewModel()
    
    init() {
       UITableView.appearance().separatorStyle = .none
       UITableViewCell.appearance().backgroundColor = UIColor(Color("Background"))
       UITableView.appearance().backgroundColor = UIColor(Color("Background"))
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color("Background").ignoresSafeArea()
                
                content
            }
            .navigationTitle("All Chats")
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .automatic), prompt: Text("Search"))
        }
    }
    
    var content: some View {
        List{
            ForEach(0...10, id: \.self) { item in
                NavigationLink(destination: ChatView()) {
                    HStack(spacing: 0){
                        AsyncImage(url: URL(string: "https://swiftanytime-content.s3.ap-south-1.amazonaws.com/SwiftUI-Beginner/Async-Image/TestImage.jpeg")) { image in
                                  image
                                      .resizable()
                                      .aspectRatio(contentMode: .fill)
                                      
                              } placeholder: {
                                  ProgressView()
                              }
                              .frame(width: 65, height: 65)
                              .clipShape(Circle())
                              .padding(.trailing)
                        
                        VStack(alignment: .leading, spacing: 20) {
                            Text("Anton")
                                .font(.title3)
                                .bold()

                            Text("Ок. Домовились. Завтра зустрінемося")
                                .font(.callout)
                        }
                        
                        Spacer()
                        VStack(alignment: .trailing, spacing: 20) {
                            Text("19:24")
                                .font(.footnote)
                                .foregroundColor(.gray)
                            

                            Text("24")
                                .foregroundColor(.gray)
                                .padding(5)
                                .padding(.horizontal, 7)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                                .shadow(color: Color("Shadow").opacity(0.2), radius: 10, x: 0, y: 0)
                            
                        }
                    }
                    
                    .listRowBackground(Color("Secondary"))
                }
            }
        }
    }
}

struct ChatsView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsView()
    }
}
