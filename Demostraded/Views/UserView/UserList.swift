//
//  UserList.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import SwiftUI

struct UserList: View {
    @Binding var selectedUser: User
    var body: some View {
        NavigationView {
            List(mockUpUsers, id: \.self, selection: $selectedUser) { user in
                UserRow(user: user)
                    .onTapGesture {
                        selectedUser = user
                    }
            }.frame(minWidth: 300, maxWidth: 300)
        }
    }
}
