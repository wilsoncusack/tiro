//
//  TagStore.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/30/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import CoreData

class TagStore : NSObject {
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Tag> = {
        let fetchRequest: NSFetchRequest<Tag> = Tag.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    public var tags: [Tag] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    //let didChange = PassthroughSubject<UserStore, Never>()
    
    override init() {
        super.init()
        fetchTags()
    }
    
    private func fetchTags() {
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
    
    public func create(name: String, tag_type : TagType) {
        Tag.create(name: name, tag_type: tag_type, in: self.persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(tag : Tag){
        self.persistenceManager.managedObjectContext.delete(tag)
        saveChanges()
    }
    
}

extension TagStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //didChange.send(self)
        // this seems like a waste. I think we need to find a way to make the main env obj the delegate. But probably not worth worrying about now.
    }
}
