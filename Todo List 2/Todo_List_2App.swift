//
//  Todo_List_2App.swift
//  Todo List 2
//
//  Created by 肇鑫 on 2022/5/7.
//

import SwiftUI

@main
struct Todo_List_2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
