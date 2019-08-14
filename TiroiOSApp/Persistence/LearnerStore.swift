//
//  LearnerStore.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import CoreData
import Combine
import SwiftUI

class LearnerStore : NSObject {
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Learner> = {
        let fetchRequest: NSFetchRequest<Learner> = Learner.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    public var learners: [Learner] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    //let didChange = PassthroughSubject<UserStore, Never>()
    
    override init() {
        super.init()
        fetchLearners()
    }
    
    public func fetchLearners() {
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
    
    public func create(name: String, created_by : User, profile_image_name : String?) {
        Learner.create(name: name, created_by: created_by, profile_image_name : profile_image_name, in: self.persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(learner : Learner){
        self.persistenceManager.managedObjectContext.delete(learner)
        saveChanges()
    }
    
}

extension LearnerStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //didChange.send(self)
        // this seems like a waste. I think we need to find a way to make the main env obj the delegate. But probably not worth worrying about now.
    }
}
