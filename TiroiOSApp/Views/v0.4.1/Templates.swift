//
//  Templates.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

func makeTextViewElement(order: Int, document: Document) -> Document_Element{
    return Document_Element(order: order, value: Value.string(value: "", displayType: .text, editType: .textView), document: document)
  //  (order: order, value: .string(""), editType: .textView, displayType: .text, document: document)
}

func makeDay(date: Date){
    //    Document(title: longDateFormatter.string(from: date), type: .day, elements: nil, tags: nil, associated_users: nil, created_by: <#T##User#>, date: nil)
    // maybe should do the user query on save? Or we're passing state around everywhere
}

func makeTextTemplate(creator: User){
    var document = Document(title: "Text", type: .text, is_template: true, elements: nil, tags: nil, associated_users: nil, created_by: creator, date: nil)
    var tagsPicker = Document_Element(order: 0,
                                      value: .picker(value:
                                        PickerStruct(
                                            selected: [],
                                            allowedChoices: Int.max,
                                            isCoreData: true,
                                            coreDataType: .tag,
                                            choices: []),
                                        displayType: .basic,
                                      editType: .basic),
                                      document: document)
    var userPicker = Document_Element(order: 1,
                                      value: .picker(value:
                                        PickerStruct(
                                            selected: [],
                                            allowedChoices: Int.max,
                                            isCoreData: true,
                                            coreDataType: .learner,
                                            choices: []),
                                              displayType: .basic,
                                            editType: .basic),
                                            document: document)
    
    var textView = makeTextViewElement(order: 2, document: document)
        //Document_Element(order: 2, value: .string(""), editType: .textView, displayType: .text, document: document)
    AppDelegate.shared.saveContext()
    //var textField = makeTextViewElement(order: 0, document: document)
}

// oh this is why we want Value it self to have a document type
// that's self referential
// because then we can create one in memory

// and we can have a save to core data method that saves, so that
// each thing knows how to save itself.
// nice!
// so you can create a whole document
// fuck this is cool 

/// hmm, how do we know where to position tags and learners. Really there's only one document element here.
// would be nice to just have one document render function and not have to adjust 
