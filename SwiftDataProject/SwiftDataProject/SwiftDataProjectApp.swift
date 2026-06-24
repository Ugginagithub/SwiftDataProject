//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Tarun on 24/06/26.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
