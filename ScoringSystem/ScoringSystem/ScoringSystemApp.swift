//
//  ScoringSystemApp.swift
//  ScoringSystem
//
//  Created by Alex Wong on 27/11/2021.
//

import SwiftUI
import Firebase
@main
struct ScoringSystemApp: App {
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
