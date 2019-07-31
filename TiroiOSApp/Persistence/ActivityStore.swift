//
//  ActivityStore.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/16/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import CoreData
import SwiftUI
import Combine
//check to see if this needs to be serverable 
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
    
    //let willChange = PassthroughSubject<ActivityStore, Never>()
    
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
            print("saved successfully")
        } catch { fatalError() }
    }
    
//    func saveContext () {
//            let context = self.persistenceManager.managedObjectContext
//            if context.hasChanges {
//                do {
//                    try context.save()
//                } catch {
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//                }
//            }
//        }
    
    public func create(activity_date : Date, title: String?, notes: String?, image: Data?, created_by: User, image_name: String?, participants : NSSet?) {
        Activity.create(activity_date: activity_date, title: title, notes: notes, image: image, created_by: created_by, image_name: image_name, participants: participants, in: self.persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(activity : Activity){
        self.persistenceManager.managedObjectContext.delete(activity)
        saveChanges()
    }
    
}

extension ActivityStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //willChange.send(self)
    }
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        willChange.send(self)
//        //didChange.send(self)
//        // this seems like a waste. I think we need to find a way to make the main env obj the delegate. But probably not worth worrying about now.
//    }
}
