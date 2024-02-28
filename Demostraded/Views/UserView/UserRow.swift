//
//  UserRow.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import SwiftUI

struct UserRow: View {
    var user: User
    var body: some View {
        HStack
        {
            Image(systemName: user.photoURL ?? "")
                .resizable()
                .frame(width:30, height:30)
                .cornerRadius(25)
                .padding(5)
                .overlay {
                    Circle()
                        .stroke()
                        .foregroundColor(.primary)
                }
                .padding()
            
            VStack (alignment: .leading)
            {
                Text(user.userName )
                    .fontWeight(.bold)
                    .padding(5)
            }
            Spacer()
        }
    }
}
