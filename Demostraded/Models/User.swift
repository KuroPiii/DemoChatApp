//
//  User.swift
//  Demostraded
//
//  Created by MacOS on 27/02/2024.
//

import Foundation
struct User: Decodable, Identifiable, Hashable {
    var id = UUID()
    let userID: String
    let userName: String
    let email: String?
    let photoURL: String?
    let createAt: Date
    
    func isCurrentUser() -> Bool {
        false
    }
}

let mockUpUsers = [
    User(userID: "001", userName: "Kuro", email: "", photoURL: "figure.golf", createAt: Date()),
    User(userID: "002", userName: "ToTo", email: "", photoURL: "figure.gymnastics", createAt: Date()),
    User(userID: "003", userName: "MiHo", email: "", photoURL: "figure.indoor.cycle", createAt: Date()),
    User(userID: "004", userName: "King", email: "", photoURL: "figure.handball", createAt: Date()),
]
