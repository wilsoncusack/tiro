//
//  LearnerPickerEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

struct LearnerPicker: View {
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    @ObservedObject var pickerManager: GenericSelectionManager<Learner>
    
    var body: some View{
        MultiSelect(title: "learners", selectionManager: pickerManager, choices: learners.map {$0}, getName: {$0.name})
    }
}



func getLearnerByID(id: String) -> Learner? {
    let fetch = NSFetchRequest<Learner>(entityName: "Learner")
    let p = NSPredicate(format: "id == %@", id)
    fetch.predicate = p
    do {
        let fetched = try AppDelegate.viewContext.fetch(fetch)
        if(fetched.count > 0){
            print("found")
            return fetched[0]
        } else {
            print("couldn't find learner")
            return nil
            
        }
    } catch {
        fatalError("Failed to fetch learners: \(error)")
    }
}

