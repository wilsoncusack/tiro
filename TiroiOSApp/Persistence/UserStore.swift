//
//  UserStore.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/14/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
import CoreData
import Combine
import SwiftUI

class UserStore : NSObject {
    
    
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<User> = {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "first_name", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    private var users: [User] {
       return fetchedResultsController.fetchedObjects ?? []
    }
    public var user : User? {
        users.count > 0 ? users[0] : nil
    }
    
    
    override init() {
        super.init()
        fetchUsers()
    }
    
    public func fetchUsers() {
        do {
            try fetchedResultsController.performFetch()
            dump(fetchedResultsController.sections)
        } catch {
            fatalError()
        }
    }
    
    public func saveChanges() {
        guard self.persistenceManager.managedObjectContext.hasChanges else { return }
        do {
            try self.persistenceManager.managedObjectContext.save()
        } catch { fatalError() }
    }
    
    public func create(first_name: String, last_name : String) {
        User.create(first_name: first_name, last_name: last_name, in: persistenceManager.managedObjectContext)
        saveChanges()
        
    }
    
    public func delete(){
        if(user != nil) {
            self.persistenceManager.managedObjectContext.delete(user!)
            saveChanges()
        }
    }

}

extension UserStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
}
