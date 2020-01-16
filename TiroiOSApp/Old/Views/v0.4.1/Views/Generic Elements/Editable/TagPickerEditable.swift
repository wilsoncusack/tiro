//
//  TagPickerEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/15/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
//import CoreData
//
//struct TagPicker: View {
//    @ObservedObject var obj: ValueEditableGeneric<Set<Tag>>
//    @FetchRequest(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: true)])
//    var tags: FetchedResults<Tag>
//    @ObservedObject var pickerManager: GenericSelectionManager<Tag>
//    
//    var body: some View{
//        MultiSelect(title: "tags", selectionManager: pickerManager, choices: tags.map {$0}, getName: {$0.name})
////        .onDisappear(){
////            print("disappear")
////            self.obj.listener!.cancel()
////        }
//    }
//}
//
//
//
//func getTagByID(id: String) -> Tag? {
//    let fetch = NSFetchRequest<Tag>(entityName: "Tag")
//    let p = NSPredicate(format: "id == %@", id)
//    fetch.predicate = p
//    do {
//        let fetched = try AppDelegate.viewContext.fetch(fetch)
//        if(fetched.count > 0){
//            print("found")
//            return fetched[0]
//        } else {
//            print("couldn't find learner")
//            return nil
//            
//        }
//    } catch {
//        fatalError("Failed to fetch learners: \(error)")
//    }
//}
