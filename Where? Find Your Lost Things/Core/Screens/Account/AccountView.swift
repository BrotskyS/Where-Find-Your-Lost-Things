//
//  AccountView.swift
//  Where? Find Your Lost Things
//
//  Created by Sergiy Brotsky on 18.09.2022.
//

import SwiftUI

struct AccountView: View {
    @StateObject var vm = AccountViewModel()
    var body: some View {
        Button{
            vm.logout()
        } label: {
            Text("Sign out")
        }
        
        .buttonStyle(.bordered)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
