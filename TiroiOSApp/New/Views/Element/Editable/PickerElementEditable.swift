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
        case .learner:
            return getLearnerEditView(editableElement: editableElement, pickerStruct: pickerStruct, displayType: displayType, editType: editType)
        case .tag:
            return AnyView(EmptyView())
                //getTagEditView(pickerStruct: pickerStruct, displayType: displayType, editType: editType)
            
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

//func getTagEditView(pickerStruct: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
//        let tags = pickerStruct.selected
//            .map {getTagByID(id: $0)}
//            .filter {$0 != nil}
//            .map {$0!}
//        let selectionManager = GenericSelectionManager(tags)
//        var editableGeneric = ValueEditableGeneric(value: selectionManager.$selected, update: { tags in
//            print("in nested update")
//
//             var new = Array(tags).map {$0.id.description}
//            print("new: \(new)")
//            self.value = Value.picker(
//                                value: PickerStruct(
//                                    selected: new,
//                                    allowedChoices: pickerStruct.allowedChoices,
//                                    isCoreData: pickerStruct.isCoreData,
//                                    coreDataType: pickerStruct.coreDataType,
//                                    choices: pickerStruct.choices),
//                                displayType: displayType,
//                                editType: editType)
//
//        })
//        return AnyView(TagPicker(obj: editableGeneric, pickerManager: selectionManager))
////        return AnyView(TagPicker(pickerManager: selectionManager))
//    }

func getLearnerEditView(editableElement: DocumentElementEditable, pickerStruct: PickerStruct,  displayType: PickerDisplayType, editType: PickerEditDisplayType) -> AnyView {
    let learners = pickerStruct.selected
    .map {getLearnerByID(id: $0)}
    .filter {$0 != nil}
    .map {$0!}
    let selectionManager = GenericSelectionManager(learners)
    let observed = ObservableValue<Set<Learner>>(value: selectionManager.selected){learnerSet in
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
    return AnyView(LearnerPicker(pickerManager: selectionManager, editableObj: observed))
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
    @FetchRequest(fetchRequest: Learner.allLearnersFetchRequest())
    var learners: FetchedResults<Learner>
    @ObservedObject var pickerManager: GenericSelectionManager<Learner>
    @ObservedObject var editableObj: ObservableValue<Set<Learner>>
    
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
//
struct TagPicker: View {
    @ObservedObject var obj: ValueEditableGeneric<Set<Tag>>
    @FetchRequest(entity: Tag.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Tag.name, ascending: true)])
    var tags: FetchedResults<Tag>
    @ObservedObject var pickerManager: GenericSelectionManager<Tag>
    
    var body: some View{
        MultiSelect(title: "tags", selectionManager: pickerManager, choices: tags.map {$0}, getName: {$0.name})
//        }
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
