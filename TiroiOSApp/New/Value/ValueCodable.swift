//
//  ValueCodable.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

extension Value: Codable{
    
    enum CodingKeys: String, CodingKey {
        case base, stringParams, intParams, dataParams, dataArrayParams, dateParams, pickerParams, documentValueParams, imagesParams, pdfParams
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(ElementValueType.self, forKey: .base)
        //
        switch base {
        case .string:
            let params = try container.decode(ValueParams<String, StringDisplayType, StringCreateDisplayType, StringEditDisplayType>.self, forKey: .stringParams)
            self = .string(value: params.value, displayType: params.displayType, editType: params.editType)
        case .date:
            let params = try container.decode(ValueParams<Date, DateDisplayType, DateCreateDisplayType, DateEditDisplayType>.self, forKey: .dateParams)
            self = .date(value: params.value, displayType: params.displayType, editType: params.editType)
        case .int:
            let params = try container.decode(ValueParams<Int, IntDisplayType, IntCreateDisplayType,IntEditDisplayType>.self, forKey: .intParams)
            self = .int(value: params.value, displayType: params.displayType, editType: params.editType)
            
        case .document:
            let params = try container.decode(ValueParams<DocumentValue, DocumentDisplayType, DocumentCreateDisplayType, DocumentEditDisplayType>.self, forKey: .documentValueParams)
            self = .documentValue(value: params.value, displayType: params.displayType, editType: params.editType)
        case .picker:
            let params = try container.decode(ValueParams<PickerStruct, PickerDisplayType, PickerCreateDisplayType, PickerEditDisplayType>.self, forKey: .pickerParams)
            self = .picker(value: params.value, displayType: params.displayType, editType: params.editType)
        case .images:
            let params = try container.decode(ValueParams<[ImageWrapper], ImagesDisplayType, ImagesCreateDisplayType, ImagesEditDisplayType>.self, forKey: .imagesParams)
            self = .images(value: params.value, displayType: params.displayType, createType: params.createType!, editType: params.editType)
        
        
        case .pdf:
                  let params = try container.decode(ValueParams<PDFDocumentWrapper, PDFDisplayType, PDFCreateDisplayType, PDFEditDisplayType>.self, forKey: .pdfParams)
                  self = .pdf(value: params.value, displayType: params.displayType, createType: params.createType!, editType: params.editType)
              
    
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value, let displayType, let editType):
            try container.encode(ElementValueType.string, forKey: .base)
            try container.encode(ValueParams<String, StringDisplayType, StringCreateDisplayType, StringEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .stringParams)
        case .int(let value, let displayType, let editType):
            try container.encode(ElementValueType.string, forKey: .base)
            try container.encode(ValueParams<Int, IntDisplayType, IntCreateDisplayType, IntEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .intParams)
        case .picker(let value, let displayType, let editType):
            try container.encode(ElementValueType.picker, forKey: .base)
            try container.encode(ValueParams<PickerStruct, PickerDisplayType, PickerCreateDisplayType, PickerEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .pickerParams)
        case .documentValue(let value, let displayType, let editType):
            try container.encode(ElementValueType.document, forKey: .base)
            try container.encode(ValueParams<DocumentValue, DocumentDisplayType, DocumentCreateDisplayType, DocumentEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .documentValueParams)
        case .date(let value, let displayType, let editType):
            try container.encode(ElementValueType.date, forKey: .base)
            try container.encode(ValueParams<Date, DateDisplayType, DateCreateDisplayType, DateEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .dateParams)
        case .images(let value, let displayType, let createType, let editType):
            try container.encode(ElementValueType.images, forKey: .base)
            try container.encode(ValueParams<[ImageWrapper], ImagesDisplayType, ImagesCreateDisplayType, ImagesEditDisplayType>(value: value, displayType: displayType, createType: createType, editType: editType), forKey: .imagesParams)
            
            case .pdf(let value, let displayType, let createType, let editType):
            try container.encode(ElementValueType.pdf, forKey: .base)
            try container.encode(ValueParams<PDFDocumentWrapper, PDFDisplayType, PDFCreateDisplayType, PDFEditDisplayType>(value: value, displayType: displayType, createType: createType, editType: editType), forKey: .pdfParams)
        }
    }
}
