//
//  iTunes_SearchApp.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 5/18/21.
//

import SwiftUI

@main
struct iTunes_SearchApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}

