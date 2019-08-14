//
//  PersistenceManager.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import CoreData

class PersistenceManager {
    lazy var managedObjectContext: NSManagedObjectContext = { AppDelegate.viewContext }()
    
    lazy var persistentContainer: NSPersistentContainer  = { AppDelegate.persistentContainer }()
}
