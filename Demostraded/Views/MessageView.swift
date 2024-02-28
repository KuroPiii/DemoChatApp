//
//  MessageView.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import SwiftUI
import SDWebImageSwiftUI
struct MessageView: View {
    var message: Message
    var user: User
    
    var body: some View {
        if message.isFromCurrentUser() {
            HStack {
                HStack {
                    Text(message.text)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(maxWidth: 300, alignment: .leading)
                .background(.blue)
                .cornerRadius(20)
                
                if let photoURL = message.fetchPhotoURL() {
                    WebImage(url: photoURL)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 24, height: 24, alignment: .top)
                        .cornerRadius(12)
                        .padding(5)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24, alignment: .top)
                        .cornerRadius(12)
                        .padding(5)
                }
            }
            .frame(maxWidth: 500, alignment: .trailing)
        } else {
            HStack {
                Image(systemName: user.photoURL ?? "")
                    .resizable()
                    .frame(width: 24, height: 24, alignment: .top)
                    .cornerRadius(12)
                    .padding(5)
                HStack {
                    Text(message.text)
                        .multilineTextAlignment(.leading)
                        .padding()
                }
                .frame(maxWidth: 300, alignment: .leading)
                .background(.gray)
                .cornerRadius(20)
            }
            .frame(maxWidth: 500, alignment: .leading)
        }
    }
}

#Preview {
    MessageView(message: mockUpMessage[0], user: mockUpUsers[0])
}
