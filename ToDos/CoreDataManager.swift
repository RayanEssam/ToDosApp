//
//  CoreDataManager.swift
//  ToDos
//
//  Created by Rayan Taj on 06/11/2021.
//

import CoreData

class CoreDataManager{
    
    let persistentContainer : NSPersistentContainer
    static let shared : CoreDataManager = CoreDataManager()
    
    init() {
        
        persistentContainer = NSPersistentContainer(name: "Database")
        
        persistentContainer.loadPersistentStores { description, error  in
            
            
            if let error = error {
                
                fatalError("Unable to load data \( error.localizedDescription   )")
                
            }
            
            
        }
        
    }
    
    
}

