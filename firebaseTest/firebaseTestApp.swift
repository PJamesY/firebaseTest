//
//  firebaseTestApp.swift
//  firebaseTest
//
//  Created by james on 2021/11/16.
//

import SwiftUI
import Firebase

@main
struct firebaseTestApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
