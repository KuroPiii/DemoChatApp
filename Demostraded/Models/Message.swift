//
//  Message.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import SwiftUI

struct Message: Decodable, Identifiable, Equatable, Hashable {
    var id = UUID()
    let userUid: String
    let text: String
    let photoURL: String?
    let createAt: Date
    
    enum MessageError: Error {
        case noPhotoURL
    }
    func isFromCurrentUser() -> Bool {
        guard let curUser = AuthManagers.shared.getCurrentUser() else {
            return false
        }
        if curUser.userID == userUid {
            return true
        } else {
            return false
        }
    }
    func fetchPhotoURL() -> URL? {
        guard let photoURLString = photoURL, let url = URL(string: photoURLString) else {
            return nil
        }
        return url
    }
}
