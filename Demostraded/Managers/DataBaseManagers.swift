//
//  DataBaseManagers.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FetchMessagesError: Error {
    case snapshotError
}
final class DataBaseManagers {
   static let shared = DataBaseManagers()
    init() {
        let settings = FirestoreSettings()

        settings.isPersistenceEnabled = false
                
        let firestore = Firestore.firestore()

        firestore.settings = settings
        messageRef = firestore.collection("messages")
    }
    
    let messageRef: CollectionReference
    var messagesPublisher = PassthroughSubject<[Message], Error>()
    func fetchMessages(completion: @escaping (Result<[Message], FetchMessagesError>) -> Void) {
        messageRef.order(by: "createAt", descending: true).limit(to: 25).getDocuments { [weak self] querySnapshot, error in
            guard let querySnapshot = querySnapshot, error == nil, let self else {
                completion(.failure(.snapshotError))
                return
            }
            self.listenForNewMessageOnDatabase()
            let messages = self.createMessageFromFirebasSnapShot(querySnapshot: querySnapshot)
            completion(.success(messages))
        }
    }
    func sendMessageToDataBase(message: Message, completion: @escaping (Bool) -> Void) {
        let data = [
            "text": message.text,
            "userUid": message.userUid,
            "photoURL": message.photoURL,
            "createAt": Timestamp(date: message.createAt),
        ] as [String : Any]
        messageRef.addDocument(data: data) { [weak self] error in
            guard let self, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
    func listenForNewMessageOnDatabase() {
        messageRef.order(by: "createAt", descending: true).limit(to: 25).addSnapshotListener { [weak self] querySnapshot, error in
            guard let querySnapshot = querySnapshot, error == nil, let self else {
                return
            }
            let messages = self.createMessageFromFirebasSnapShot(querySnapshot: querySnapshot)
            self.messagesPublisher.send(messages)
        }
    }
    func createMessageFromFirebasSnapShot(querySnapshot: QuerySnapshot) -> [Message] {
        let docs = querySnapshot.documents
        var messages = [Message]()
        for doc in docs {
            let data = doc.data()
            let text = data["text"] as? String ?? "Error"
            let userUid = data["userUid"] as? String ?? "Error"
            let photoURL = data["photoURL"] as? String ?? "Error"
            let createAt = data["createAt"] as? Timestamp ?? Timestamp()
            
            let msg = Message(userUid: userUid, text: text, photoURL: photoURL, createAt: createAt.dateValue())
            messages.append(msg)
        }
        return messages.reversed()
    }
}
