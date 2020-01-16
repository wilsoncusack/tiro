//
//  Enum.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

enum ElementValueType: String, Codable {
    case string, date, int, picker, pdf, images, document, bool
}

enum Value {
    case string(
        value: StringElement,
        displayType: StringDisplayType,
        editType: StringEditDisplayType)
    
    
    case int(
        value: Int,
        displayType: IntDisplayType,
        editType: IntEditDisplayType)
    
    case bool(
    value: Bool,
    displayType: BoolDisplayType,
        createType: BoolCreateDisplayType,
    editType: BoolEditDisplayType)
    
    case date(
        value: Date,
        displayType: DateDisplayType,
        editType: DateEditDisplayType)
    
    case picker(
        value: PickerStruct,
        displayType: PickerDisplayType,
        editType: PickerEditDisplayType)
    
    case documentValue(
        value: DocumentValue,
        displayType: DocumentDisplayType,
        editType: DocumentEditDisplayType)
    
    case images(
        value: [ImageWrapper],
        displayType: ImagesDisplayType,
        createType: ImagesCreateDisplayType,
        editType: ImagesEditDisplayType)
    
    case pdf(
    value: PDFDocumentWrapper,
    displayType: PDFDisplayType,
    createType: PDFCreateDisplayType,
    editType: PDFEditDisplayType)
}
