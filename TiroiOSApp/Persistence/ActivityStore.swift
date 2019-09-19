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
    
    //var tags : [TagCount] = []
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
    
    public func activitiesInDateRange(activities: [Activity], startDate: Date, endDate: Date) -> [Activity]{
        activities.filter { (activity) -> Bool in
            activity.activity_date.compare(startDate) == ComparisonResult.orderedDescending
                && (activity.activity_date.compare(endDate) == ComparisonResult.orderedAscending || activity.activity_date.compare(endDate) == ComparisonResult.orderedSame)
        }
    }
    
    public var activitiesLastSevenDays: [Activity] {
        let activities = fetchedResultsController.fetchedObjects ?? []
        return activitiesInDateRange(activities: activities, startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, endDate: Date())
    }
    
    struct TagCount : Hashable {
        var tag: Tag
        var count: Int
        var percentage : Double
    }
    
    public var mostCommonTagsLastSevenDays: [TagCount] {
        let activities = fetchedResultsController.fetchedObjects ?? []
        let activitiesLastSevenDays = activitiesInDateRange(activities: activities, startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, endDate: Date())
        
        
        var counter = [Tag: Int]()
        for a in activitiesLastSevenDays {
            let tags = a.tags?.allObjects as! [Tag]
            for tag in tags {
                let currentCount = counter[tag] ?? 0
                counter[tag] = currentCount + 1
            }
        }
        var tagTouples = [TagCount]()
        
        for (tag, count) in counter {
            tagTouples.append(TagCount(tag: tag, count: count, percentage: Double(count)/Double(activitiesLastSevenDays.count)))
            //tagTouples.append((tag, count))
        }
        tagTouples.sort { (touple1, touple2) -> Bool in
            return touple1.count - touple2.count > 0
        }
        let toReturn = tagTouples[..<min(tagTouples.count, 4)]
        return Array(toReturn)

    }
    
    public func getTags() {
        let activities = fetchedResultsController.fetchedObjects ?? []
        
        let activitiesLastSevenDays = activitiesInDateRange(activities: activities, startDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, endDate: Date())
        
        
        var counter = [Tag: Int]()
        for a in activitiesLastSevenDays {
            let tags = a.tags?.allObjects as! [Tag]
            for tag in tags {
                let currentCount = counter[tag] ?? 0
                counter[tag] = currentCount + 1
            }
        }
        var tagTouples = [TagCount]()
        
        for (tag, count) in counter {
            tagTouples.append(TagCount(tag: tag, count: count, percentage: Double(count)/Double(activitiesLastSevenDays.count)))
            //tagTouples.append((tag, count))
        }
        tagTouples.sort { (touple1, touple2) -> Bool in
            return touple1.count - touple2.count > 0
        }
        
        let toReturn = tagTouples[..<min(tagTouples.count, 4)]
        
       // tags =  Array(toReturn)

    }
    

    
    override init() {
        super.init()
        fetchActivities()
        getTags()
        
    }
    
    public func fetchActivities() {
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
    
    
    public func create(activity_date : Date, title: String?, notes: String?, image: Data?, created_by: User, image_name: String?, participants : NSSet?, tags: NSSet?) {
        Activity.create(activity_date: activity_date, title: title, notes: notes, image: image, created_by: created_by, image_name: image_name, participants: participants, tags: tags, in: self.persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(activity : Activity){
        self.persistenceManager.managedObjectContext.delete(activity)
        saveChanges()
    }
    
}

extension ActivityStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //getTags()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
}
