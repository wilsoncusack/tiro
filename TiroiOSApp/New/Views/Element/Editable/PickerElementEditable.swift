//
//  PickerElementEditable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import SwiftUI
import CoreData

func getPickerEditView(editableElement: DocumentElementEditable,  pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
    if(pickerStruct.isCoreData){
        switch pickerStruct.coreDataType!{
        case .user:
            return getLearnerEditView(editableElement: editableElement, pickerStruct: pickerStruct, displayType: displayType, editType: editType)
        case .tag:
            return getTagEditView(editableElement: editableElement,pickerStruct: pickerStruct, displayType: displayType, editType: editType)
            
        }
    } else {
        return AnyView(EmptyView())
    }
}

//func getPickerEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
//    if(pickerStruct.isCoreData){
//        switch pickerStruct.coreDataType!{
//        case .learner:
//            return getLearnerEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
//        case .tag:
//            return getTagEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
//
//        }
//    } else {
//        return AnyView(EmptyView())
//    }
//}

func getTagEditView(editableElement: DocumentElementEditable, pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
         let tags = pickerStruct.selected
           .map {getTagByID(id: $0)}
           .filter {$0 != nil}
           .map {$0!}
           //let selectionManager = GenericSelectionManager(tags)
           let observed = ObservableValue<[Tag]>(value: tags){learnerSet in
               print("received new tag set")
               let new = Array(learnerSet).map {$0.id.description}
               editableElement.localValue = Value.picker(
                   value: PickerStruct(
                       selected: new,
                       allowedChoices: pickerStruct.allowedChoices,
                       isCoreData: pickerStruct.isCoreData,
                       coreDataType: pickerStruct.coreDataType,
                       choices: pickerStruct.choices),
                   displayType: displayType,
                   editType: editType)
             
           }
           return AnyView(TagPicker(editableObj: observed , choiceLimit: pickerStruct.allowedChoices))
//        return AnyView(TagPicker(pickerManager: selectionManager))
    }

func getLearnerEditView(editableElement: DocumentElementEditable, pickerStruct: PickerStruct,  displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
    let learners = pickerStruct.selected
    .map {getUserByID(id: $0)}
    .filter {$0 != nil}
    .map {$0!}
    let observed = ObservableValue<[User]>(value: learners){learnerSet in
        let new = Array(learnerSet).map {$0.id.description}
        editableElement.localValue = Value.picker(
            value: PickerStruct(
                selected: new,
                allowedChoices: pickerStruct.allowedChoices,
                isCoreData: pickerStruct.isCoreData,
                coreDataType: pickerStruct.coreDataType,
                choices: pickerStruct.choices),
            displayType: displayType,
            editType: editType)
      
    }
    return AnyView(LearnerPicker(editableObj: observed, choiceLimit: pickerStruct.allowedChoices, displayType: displayType))
}
    
    
//    func getLearnerEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
//        let learners = pickerStruct.selected
//            .map {getLearnerByID(id: $0)}
//            .filter {$0 != nil}
//            .map {$0!}
//        let selectionManager = GenericSelectionManager(learners)
//        selectionManager.$selected
//            .receive(on: RunLoop.main)
//            .sink { (learnerSet) in
//                let new = Array(learnerSet).map {$0.id.description}
//                self.value = Value.picker(
//                    value: PickerStruct(
//                        selected: new,
//                        allowedChoices: pickerStruct.allowedChoices,
//                        isCoreData: pickerStruct.isCoreData,
//                        coreDataType: pickerStruct.coreDataType,
//                        choices: pickerStruct.choices),
//                    displayType: displayType,
//                    editType: editType)
//        }
//        return AnyView(LearnerPicker(pickerManager: selectionManager))
//    }

struct LearnerPicker: View {
//    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
//    var learners: FetchedResults<Learner>
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \User.first_name, ascending: true)]
        )
    
       var learners: FetchedResults<User>
    @ObservedObject var editableObj: ObservableValue<[User]>
    var choiceLimit: Int
    var displayType: PickerDisplayType
    
    var title: String {
        switch displayType{
            
        case .basic:
            return "people"
        case .participants:
            return "participants"
        case .quoteAttribution, .conversationAttribution :
            return "Who said it?"
        
        }
    }
    
    var body: some View{
        MultiSelect3(title: title, observedSelected: editableObj, choiceLimit: choiceLimit, choices: learners.map {$0}, getName: {$0.first_name})
    }
}

func getUserByID(id: String) -> User? {
    let fetch = NSFetchRequest<User>(entityName: "User")
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


//func getLearnerByID(id: String) -> Learner? {
//    let fetch = NSFetchRequest<Learner>(entityName: "Learner")
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
//
struct TagPicker: View {
    @FetchRequest(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: true)])
    var tags: FetchedResults<Tag>
    
     @ObservedObject var editableObj: ObservableValue<[Tag]>
    
    var choiceLimit: Int
   
   
    
    var body: some View{
        MultiSelect3(title: "tags", observedSelected: editableObj, choiceLimit: choiceLimit, choices: tags.map {$0}, getName: {$0.name})
    }

    
}



func getTagByID(id: String) -> Tag? {
    let fetch = NSFetchRequest<Tag>(entityName: "Tag")
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
