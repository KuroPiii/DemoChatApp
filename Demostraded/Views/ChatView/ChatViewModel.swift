//
//  ChatViewModel.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var message = [Message]()
    var subscribers: Set<AnyCancellable> = []
    init() {
        fetchMessagesFromDatabase()
        subscribeToMessagePublisher()
    }
    func fetchMessagesFromDatabase() {
        DataBaseManagers.shared.fetchMessages { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let msgs):
                self.message = msgs
            case .failure(let error):
                print(error)
            }
        }
    }
    func sendMessage(_ message: String, completion: @escaping (Bool) -> Void) {
        guard let user = AuthManagers.shared.getCurrentUser() else {
            return
        }
        let msg = Message(userUid: user.userID, text: message, photoURL: user.photoURL, createAt: Date())
        DataBaseManagers.shared.sendMessageToDataBase(message: msg) { [weak self] success in
            guard let self else { return }
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    func refresh() {
        self.message = message
    }
    private func subscribeToMessagePublisher() {
        DataBaseManagers.shared.messagesPublisher.receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { messages in
                self.message = messages
            }
            .store(in: &subscribers)

    }
}
var mockUpMessage = [
    Message(userUid: "000001", text: "Do not show this again for this Smart Monitor.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "USB type may differ depending on the model.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Select the split screen layout for this monitor and adjust it to suit you.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Discover and set up your Smart Monitor", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Make sure your PC and Smart Monitor are connected to the same network.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Unable to discover any Smart Monitor with mouse control enabled.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Discover and set up your Smart Monitor", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
    Message(userUid: "000001", text: "Simply drag the window into the Quick Split menu to split the screen where you want it.", photoURL: "", createAt: Date()),
]
