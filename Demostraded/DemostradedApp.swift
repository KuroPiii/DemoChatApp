//
//  DemostradedApp.swift
//  Demostraded
//
//  Created by MacOS on 26/02/2024.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct DemostradedApp: App {
    init() {
        FirebaseApp.configure()
        GIDSignIn.sharedInstance.handle(URL(string: "com.googleusercontent.apps.366221021470-vkfc8sdgoit9jsfserha6n1busc5vret") ?? URL(fileURLWithPath: ""))
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
