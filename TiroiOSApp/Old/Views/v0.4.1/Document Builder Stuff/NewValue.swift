//
//  NewValue.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/25/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import PDFKit

//enum NewValue {
//    case string(value: String)
//    case date(value: Date)
//    case int(value: Int)
//    case double(value: Double)
//    case picker(value: PickerStruct)
//    case pdf(value: PDFDocumentWrapper)
//    case images(value: [ImageWrapper])
//    case document(value: DocumentWrapper)
//    case quote(value: Quote)
//    case conversation(value: Conversation)
//}
//
//
//
//extension NewValue: Codable{
//    enum CodingKeys: String, CodingKey {
//        case base, stringParams, dateParams, intParams, doubleParams, pickerParams, pdfParams, imagesParams, documentParams, quoteParams, conversationParams
//    }
//
//
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        let base = try container.decode(ElementValueType.self, forKey: .base)
//        switch base {
//        case .string:
//            let params = try container.decode(String.self, forKey: .stringParams)
//            self = .string(value: params)
//        case .date:
//            let params = try container.decode(Date.self, forKey: .dateParams)
//            self = .date(value: params)
//        case .int:
//            let params = try container.decode(Int.self, forKey: .intParams)
//            self = .int(value: params)
//        case .double:
//            let params = try container.decode(Double.self, forKey: .doubleParams)
//            self = .double(value: params)
//        case .picker:
//            let params = try container.decode(PickerStruct.self, forKey: .pickerParams)
//            self = .picker(value: params)
//        case .pdf:
//            let params = try container.decode(PDFDocumentWrapper.self, forKey: .pdfParams)
//            self = .pdf(value: params)
//        case .images:
//            let params = try container.decode([ImageWrapper].self, forKey: .imagesParams)
//            self = .images(value: params)
//        case .document:
//            let params = try container.decode(DocumentWrapper.self, forKey: .documentParams)
//            self = .document(value: params)
//        case .quote:
//            let params = try container.decode(Quote.self, forKey: .quoteParams)
//            self = .quote(value: params)
//        case .conversation:
//            let params = try container.decode(Conversation.self, forKey: .conversationParams)
//            self = .conversation(value: params)
//        }
//
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        switch self {
//        case .string(let value):
//            try container.encode(ElementValueType.string, forKey: .base)
//            try container.encode(value, forKey: .stringParams)
//        case .date(let value):
//            try container.encode(ElementValueType.date, forKey: .base)
//            try container.encode(value, forKey: .dateParams)
//        case .int(let value):
//            try container.encode(ElementValueType.int, forKey: .base)
//            try container.encode(value, forKey: .intParams)
//        case .double(let value):
//            try container.encode(ElementValueType.double, forKey: .base)
//            try container.encode(value, forKey: .doubleParams)
//        case .picker(let value):
//            try container.encode(ElementValueType.picker, forKey: .base)
//            try container.encode(value, forKey: .pickerParams)
//        case .pdf(let value):
//            try container.encode(ElementValueType.pdf, forKey: .base)
//            try container.encode(value, forKey: .pdfParams)
//        case .images(let value):
//            try container.encode(ElementValueType.images, forKey: .base)
//            try container.encode(value, forKey: .imagesParams)
//        case .document(let value):
//            try container.encode(ElementValueType.document, forKey: .base)
//            try container.encode(value, forKey: .documentParams)
//        case .quote(let value):
//            try container.encode(ElementValueType.quote, forKey: .base)
//            try container.encode(value, forKey: .quoteParams)
//        case .conversation(let value):
//            try container.encode(ElementValueType.conversation, forKey: .base)
//            try container.encode(value, forKey: .conversationParams)
//        }
//    }
//}
//
//    struct Quote: Codable{
//        let quote: String
//        let picker: PickerStruct
//    }
//
//
//    struct Conversation: Codable{
//        let quotes: [Quote]
//    }
//
    
//}

//class PDFDocumentWrapper: Codable{
//private enum CodingKeys: String, CodingKey{
//    case pdfDocumentData
//}
//let pdfDocument: PDFDocument
//
//    init(data: Data){
//         pdfDocument = PDFDocument(data: data)!
//
//    }
//
//    init(){
//        pdfDocument = PDFDocument()
//    }
//
//func encode(to encoder: Encoder) throws {
//    var container = encoder.container(keyedBy: CodingKeys.self)
//    try container.encode(self.pdfDocument.dataRepresentation()!, forKey: .pdfDocumentData)
//}
//
//required init(from decoder: Decoder) throws {
//    let container = try decoder.container(keyedBy: CodingKeys.self)
//
//    if let data : Data = try container.decodeIfPresent(Data.self, forKey: .pdfDocumentData)
//    {
//        if let document : PDFDocument = PDFDocument(data: data){
//            self.pdfDocument = document
//        } else {
//            print("this error")
//            throw SDKError.pdfConversionError
//        }
//    } else {
//        print("that error")
//        throw SDKError.pdfConversionError
//    }
//
//}
//}
