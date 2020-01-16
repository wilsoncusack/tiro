//
//  Templates.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import UIKit

func makeIntElement(order: Int, editType: IntEditDisplayType, displayType: IntDisplayType, document: Document) -> Document_Element{
    return Document_Element(
        order: order,
        value: Value.int(value: -1, displayType: displayType, editType: editType),
        type: .int,
        document: document)
}

func makeTextViewElement(text: String, placeholder: String, order: Int, editType: StringEditDisplayType ,displayView: StringDisplayType, document: Document) -> Document_Element{
    return Document_Element(order: order, value: Value.string(value: StringElement(string: text, placeholder: placeholder), displayType: displayView, editType: editType), type: .string, document: document)
}

func makeTagsPicker(selected: [String], order: Int, document: Document) -> Document_Element{
    let picker = Value.picker(value:
    PickerStruct(
        selected: selected,
        allowedChoices: Int.max,
        isCoreData: true,
        coreDataType: .tag,
        choices: []),
               displayType: .basic,
               editType: .basic)
    return makePicker(order: order, picker: picker, displayType: .basic, editType: .basic, document: document)
}

func makePicker(order: Int, picker: Value, displayType: PickerDisplayType, editType: PickerEditDisplayType, document: Document) -> Document_Element{
    return Document_Element(
    order: order,
    value: picker,
    type: .picker,
    document: document)
}

func makeUserPicker(selected: [String], order: Int, allowedChoices: Int = Int.max, displayType: PickerDisplayType, document: Document) -> Document_Element {
    let picker = Value.picker(value:
    PickerStruct(
        selected: selected,
        allowedChoices: allowedChoices,
        isCoreData: true,
        coreDataType: .user,
        choices: []),
               displayType: displayType,
               editType: .basic)
    return makePicker(order: order, picker: picker, displayType: displayType,
                      editType: .basic, document: document)
    
}

func makeDay(date: Date, user: User) -> Document{
    print("in make day: \(date.description)")
    let document = Document(title: longDateFormatter.string(from: date), type: .day, elements: nil, tags: nil, associated_users: nil, created_by: user, date: date)
    AppDelegate.shared.saveContext()
    return document
}

func uiImageToData(imgs: [UIImage]) -> [Data] {
    let imgArray = [UIImage]();
    
    //var CDataArray = NSMutableArray();
    
    var dataArray = [Data]()
    
    for img in imgArray{
        let data = img.pngData()!
        dataArray.append(data)
    }
    
    return dataArray
}

func makeImagePicker(order: Int, displayType: ImagesDisplayType, createType: ImagesCreateDisplayType, editType: ImagesEditDisplayType, document: Document) -> Document_Element {
    var emptyImageArray = [ImageWrapper]()
    return Document_Element(
        order: order,
        value: Value.images(value: emptyImageArray, displayType: displayType, createType: .photoLibrary,editType: .images),
        type: .images,
        document: document)
}

func makeScanElement(order: Int, document: Document) -> Document_Element{
    var pdfWrapper = PDFDocumentWrapper()
    return Document_Element(
        order: order,
        value: Value.pdf(value: pdfWrapper, displayType: .basic, createType: .scan, editType: .basic),
        type: .pdf,
        document: document)
}

func makeBoolElement(value: Bool, order: Int, displayType: BoolDisplayType, document: Document) -> Document_Element{
    return Document_Element(
        order: order,
        value: Value.bool(value: value, displayType: displayType, createType: .basic, editType: .basic),
        type: .bool,
        document: document)
}

func makeTextTemplate(){
    var document = Document(title: "Text", type: .text, is_template: true, systemImage: "textformat", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var tagsPicker = makeTagsPicker(selected: [], order: 2, document: document)
    var userPicker = makeUserPicker(selected: [], order: 1,  displayType: .participants, document: document)
    var textView = makeTextViewElement(text: "", placeholder: "Type something...", order: 0, editType: .longText,displayView: .text, document: document)
    
}

func makePhotoPickerDocument(){
    var document = Document(title: "Image", type: .image, is_template: true, systemImage: "photo.on.rectangle", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var imagePicker = makeImagePicker(order: 0, displayType: .largeScroll, createType: .photoLibrary, editType: .images, document: document)
    var tagsPicker = makeTagsPicker(selected: [], order: 2, document: document)
    var userPicker = makeUserPicker(selected: [], order: 3,  displayType: .participants, document: document)
    var textView = makeTextViewElement(text: "", placeholder: "Add a caption...", order: 1, editType: .caption, displayView: .caption, document: document)
    
}

func makeQuoteTemplate(){
    var document = Document(title: "Quote", type: .quote, is_template: true, systemImage: "quote.bubble", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var tagsPicker = makeTagsPicker(selected: [], order: 2, document: document)
    var userPicker = makeUserPicker(selected: [], order: 1, allowedChoices: 1,  displayType: .quoteAttribution, document: document)
    var textView = makeTextViewElement(text: "", placeholder: "Type a quote", order: 0, editType: .quote,displayView: .quote, document: document)
    
}



func makeScanTemplate(){
    var document = Document(title: "Scan", type: .scan, is_template: true,  systemImage: "doc.text.viewfinder", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var tagsPicker = makeTagsPicker(selected: [], order: 2, document: document)
    var userPicker = makeUserPicker(selected: [], order: 1, displayType: .participants, document: document)
    var scan = makeScanElement(order: 0, document: document)
    var textView = makeTextViewElement(text: "", placeholder: "Add a caption",order: 3, editType: .caption, displayView: .caption, document: document)
    
}

func makeReadingTemplate(){
    
    // get reading tag
    let document = Document(title: "Reading", type: .reading, is_template: true,  systemImage: "book", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    
    var tagsPicker = makeTagsPicker(selected: [], order: 4, document: document)
    var userPicker = makeUserPicker(selected: [], order: 3,  displayType: .participants, document: document)
    var imagePicker = makeImagePicker(order: 2, displayType: .mediumScroll, createType: .photoLibrary, editType: .images, document: document)
    var textView = makeTextViewElement(text: "", placeholder: "Book title...", order: 0, editType: .shortText, displayView: .bookTitle, document: document)
    var duration = makeIntElement(order: 1, editType: .minutes, displayType: .minutes, document: document)
    
}

func makeQuestionTemplate(){
    let document = Document(title: "Question", type: .question, is_template: true,  systemImage: "questionmark.circle", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var _ = makeTextViewElement(text: "", placeholder: "Question...", order: 0, editType: .quote,displayView: .quote, document: document)
    var _ = makeUserPicker(selected: [], order: 1, allowedChoices: 1,  displayType: .quoteAttribution, document: document)
    var _ = makeTextViewElement(text: "", placeholder: "Answer...", order: 2, editType: .quote,displayView: .text, document: document)
    var imagePicker = makeImagePicker(order: 3, displayType: .mediumScroll, createType: .photoLibrary, editType: .images, document: document)
    var _ = makeTagsPicker(selected: [], order: 4, document: document)
    
}

func makeToDoTemplate(){
    let document = Document(title: "ToDo", type: .toDo, is_template: true,  systemImage: "checkmark.circle", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var _ = makeTextViewElement(text: "", placeholder: "What to do...", order: 0, editType: .shortText, displayView: .text, document: document)
    var _ = makeBoolElement(value: false, order: 1,  displayType: .ToDo, document: document)
    var _ = makeUserPicker(selected: [], order: 2,  displayType: .participants, document: document)
     
    var _ = makeTagsPicker(selected: [], order: 3, document: document)
}

func makeActivityReflectionTemplate(){
    let document = Document(title: "Activity Reflection", type: .activity, is_template: true,  systemImage: "text.badge.star", elements: nil, tags: nil, associated_users: nil, created_by: nil, date: nil)
    var _ = makeTextViewElement(text: "", placeholder: "What'd you do?", order: 0, editType: .shortText, displayView: .title, document: document)
    var _ = makeTextViewElement(text: "", placeholder: "Notes...", order: 1, editType: .longText, displayView: .text, document: document)
    var duration = makeIntElement(order: 2, editType: .minutes, displayType: .minutes, document: document)
    var imagePicker = makeImagePicker(order: 3, displayType: .mediumScroll, createType: .photoLibrary, editType: .images, document: document)
    var _ = makeUserPicker(selected: [], order: 4,  displayType: .participants, document: document)
    var _ = makeTagsPicker(selected: [], order: 5, document: document)
    // document
    // tags
    // participants
    // short text - activity
    // long text - description
    
}

func makeActivityAbstractTemplate(creator: User){
    // title
    // description
    // tags
}

func makeActivityReflectionLinkedTemplate(creator: User){
    //document
    // search activity
    //
    
}
