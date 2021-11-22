//
//  ToDosApp.swift
//  ToDos
//
//  Created by Rayan Taj on 06/11/2021.
//

import SwiftUI

@main
struct ToDosApp: App {
    
    let persistentContainer  = CoreDataManager.shared.persistentContainer

    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
