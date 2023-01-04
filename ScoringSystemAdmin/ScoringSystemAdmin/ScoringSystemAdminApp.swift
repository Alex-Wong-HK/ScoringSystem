//
//  ScoringSystemAdminApp.swift
//  ScoringSystemAdmin
//
//  Created by Alex Wong on 28/11/2021.
//

import SwiftUI
import Firebase

@main
struct ScoringSystemAdminApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
