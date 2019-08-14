//
//  TagType.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/30/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
import CoreData

class TagTypeStore : NSObject {
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<TagType> = {
        let fetchRequest: NSFetchRequest<TagType> = TagType.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    public var tagTypes: [TagType] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    //let didChange = PassthroughSubject<UserStore, Never>()
    
    override init() {
        super.init()
        fetchTagTypes()
    }
    
    private func fetchTagTypes() {
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
    
    public func create(name: String) {
        
        TagType.create(name: name, in: self.persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(tagType : TagType){
        self.persistenceManager.managedObjectContext.delete(tagType)
        saveChanges()
    }
    
}

extension TagTypeStore: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //didChange.send(self)
        // this seems like a waste. I think we need to find a way to make the main env obj the delegate. But probably not worth worrying about now.
    }
}
