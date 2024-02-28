//
//  ContentView.swift
//  Demostraded
//
//  Created by MacOS on 26/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State var selectedUser: User = mockUpUsers[0]
    @State var showSignIn: Bool = true
    var body: some View {
        NavigationView {
            UserList(selectedUser: $selectedUser)
            if !showSignIn {
                ChatView(user: selectedUser)
                    .frame(width: 500, height: 700, alignment: .leading)
            }
        }
        .sheet(isPresented: $showSignIn, content: {
            SignInView(showSignIn: $showSignIn)
        })
    }
}

#Preview {
    ContentView()
}
