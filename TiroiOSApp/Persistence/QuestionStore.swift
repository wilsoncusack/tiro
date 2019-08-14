//
//  QuestionStore.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import CoreData
import Combine
import SwiftUI

class QuestionStore : NSObject {
    
    //let context = AppDelegate.viewContext
    
    private let persistenceManager = PersistenceManager()
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Question> = {
        let fetchRequest: NSFetchRequest<Question> = Question.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date_created", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: self.persistenceManager.managedObjectContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    public var questions: [Question] {
        return fetchedResultsController.fetchedObjects ?? []
    }
    
    //let didChange = PassthroughSubject<QuestionStore, Never>()
    
    override init() {
        super.init()
        fetchQuestions()
    }
    
    
    private func fetchQuestions() {
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
    
    public func create(question_text: String, asker : Learner, answer_text : String?, created_by : User) {
        Question.create(question_text: question_text, asker: asker, answer_text : answer_text, created_by : created_by, in: persistenceManager.managedObjectContext)
        saveChanges()
    }
    
    public func delete(question : Question){
        self.persistenceManager.managedObjectContext.delete(question)
        saveChanges()
    }
    
    
    
}

extension QuestionStore: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //didChange.send(self)
    }
}
