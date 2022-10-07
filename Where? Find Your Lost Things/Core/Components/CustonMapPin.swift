//
//  CustonMapPin.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 03.10.2022.
//

import SwiftUI

struct CustonMapPin: View {
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 5, height: 5)

                .rotation3DEffect(.degrees(45), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .black, radius: 5, x: 0, y: 5)
                .shadow(color: .black, radius: 5, x: 0, y: 5)
                .foregroundColor(.accentColor)
                
            
            Image(systemName: "mappin")
                .font(.largeTitle)
                .offset(y: -15)
                .foregroundColor(.accentColor)
        }
    }
}

struct CustonMapPin_Previews: PreviewProvider {
    static var previews: some View {
        CustonMapPin()
    }
}
