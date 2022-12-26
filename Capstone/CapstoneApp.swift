//
//  CapstoneApp.swift
//  Capstone
//
//  Created by Braulio Viveros on 9/10/22.
//

import SwiftUI

@main
struct CapstoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MenuView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

