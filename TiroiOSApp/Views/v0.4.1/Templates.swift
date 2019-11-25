//
//  Templates.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import UIKit

func makeTextViewElement(order: Int, document: Document) -> Document_Element{
    return Document_Element(order: order, value: Value.string(value: "", displayType: .text, editType: .textView), document: document)
}

func makeTagsPicker(order: Int, document: Document) -> Document_Element{
    return Document_Element(order: order,
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
}

func makeUserPicker(order: Int, document: Document) -> Document_Element {
    return Document_Element(order: order,
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
}

func makeDay(date: Date, user: User) -> Document{
    let document = Document(title: longDateFormatter.string(from: date), type: .day, elements: nil, tags: nil, associated_users: nil, created_by: user, date: nil)
    AppDelegate.shared.saveContext()
    return document
}

func uiImageToData(imgs: [UIImage]) -> [Data] {
    var imgArray = [UIImage]();

    var CDataArray = NSMutableArray();
    
    var dataArray = [Data]()

    for img in imgArray{
       // let data : NSData = NSData(data: img.pngData()!)
        let data = img.pngData()!
        dataArray.append(data)
    }
    //NSKeyedArchiver.archivedData(withRootObject: CDataArray);
    
    //CDataArray.encode(
    
    return dataArray//Data(
}

func makeImagePicker(order: Int, document: Document) -> Document_Element {
//    var emptyImageArray = [Data]()
//    return Document_Element(
//        order: order,
//        value: Value.dataArray(value: emptyImageArray, displayType: .images, createType: .photoLibrary,editType: .images),
//        document: document)
      var emptyImageArray = [ImageWrapper]()
        return Document_Element(
            order: order,
            value: Value.images(value: emptyImageArray, displayType: .images, createType: .photoLibrary,editType: .images),
            document: document)
}

func makeTextTemplate(creator: User){
    var document = Document(title: "Text", type: .text, is_template: true, elements: nil, tags: nil, associated_users: nil, created_by: creator, date: nil)
    var tagsPicker = makeTagsPicker(order: 0, document: document)
    var userPicker = makeUserPicker(order: 1, document: document)
    var textView = makeTextViewElement(order: 2, document: document)
    AppDelegate.shared.saveContext()
}

func makePhotoPickerDocument(creator: User){
    var document = Document(title: "Image", type: .image, is_template: true, elements: nil, tags: nil, associated_users: nil, created_by: creator, date: nil)
    var imagePicker = makeImagePicker(order: 0, document: document)
     var tagsPicker = makeTagsPicker(order: 1, document: document)
       var userPicker = makeUserPicker(order: 2, document: document)
       var textView = makeTextViewElement(order: 3, document: document)
       AppDelegate.shared.saveContext()
}
