//
//  ChatView.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import SwiftUI

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    let user: User
    @State var text: String = ""
    var body: some View {
        VStack {
            ScrollViewReader { scrollViewReader in
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 5) {
                        ForEach(Array(chatViewModel.message.enumerated()), id: \.element) {index, message in
                            MessageView(message: message, user: user)
                                .id(index)
                        }
                        .onChange(of: chatViewModel.message) { newValue in
                            scrollViewReader.scrollTo(chatViewModel.message.count - 1, anchor: .bottom)
                        }
                    }
                }
            }
            HStack {
                TextField("Hello There", text: $text, axis: .vertical)
                    .padding(.bottom, 8)
                    .frame(minHeight: 64)
                    .background(Color(.systemGray))
                    .cornerRadius(20)
                    .textFieldStyle(.plain)
                    .onSubmit {
                        chatViewModel.sendMessage(text, completion: { success in
                            if success {
                                text.removeAll()
                            } else {
                                print("error in sending message")
                            }
                        })
                    }
                Button(action: {
                    chatViewModel.sendMessage(text, completion: { success in
                        if success {
                            text.removeAll()
                        } else {
                            print("error in sending message")
                        }
                    })
                }, label: {
                    Text("Send")
                        .padding()
                        .background(.mint)
                        .cornerRadius(30)
                })
                .buttonStyle(.plain)
            }
            .padding()
        }
        .border(.red)
    }
}

#Preview {
    ChatView(user: mockUpUsers[0])
        .frame(width: 500, height: 700, alignment: .leading)
}
