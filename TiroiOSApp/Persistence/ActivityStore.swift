//
//  ActivityStore.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import CoreData

class ActivityStore : NSObject {
    
    //let context = AppDelegate.viewContext
    
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Activity> = {
        let fetchRequest: NSFetchRequest<Activity> = Activity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "activity_date", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    public var activities: [Activity] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    //let didChange = PassthroughSubject<UserStore, Never>()
    
    override init() {
        super.init()
        fetchActivities()
    }
    
    private func fetchActivities() {
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
    
    public func create(activity_date : Date, title: String, notes: String?, created_by: User, image_name: String?, participants : NSSet?) {
        Activity.create(activity_date: activity_date, title: title, notes: notes, created_by: created_by, image_name: image_name, participants: participants, in: self.persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(activity : Activity){
        self.persistenceManager.managedObjectContext.delete(activity)
        saveChanges()
    }
    
}

extension ActivityStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //didChange.send(self)
        // this seems like a waste. I think we need to find a way to make the main env obj the delegate. But probably not worth worrying about now.
    }
}
