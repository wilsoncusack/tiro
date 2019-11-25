//
//  Value.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/13/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import SwiftUI


enum CoreDataChoiceTypes: String, Codable {
    case learner
    case tag
}

struct PickerStruct: Codable {
    var selected: [String]
    var allowedChoices: Int
    var isCoreData: Bool
    var coreDataType: CoreDataChoiceTypes?
    var choices: [String]
}



enum Value {
    case string(value: String, displayType: StringDisplayType, editType: StringEditDisplayType)
    case data(value: Data, displayType: DataDisplayType, editType: DataEditDisplayType)
    case dataArray(value: [Data], displayType: DataArrayDisplayType, createType: DataArrayCreateDisplayType, editType: DataArrayEditDisplayType)
    case int(value: Int, displayType: IntDisplayType, editType: IntEditDisplayType)
    case date(value: Date, displayType: DateDisplayType, editType: DateEditDisplayType)
    case picker(value: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType)
   // case document(value: String, displayType: DocumentDisplayType, editType: DocumentEditDisplayType)
    case documentWrapper(value: DocumentWrapper, displayType: DocumentDisplayType, editType: DocumentEditDisplayType)
    case images(value: [ImageWrapper], displayType: DataArrayDisplayType, createType: DataArrayCreateDisplayType, editType: DataArrayEditDisplayType)
}


////
enum ImageEncodingQuality: CGFloat {
    case png = 0
    case jpegLow = 0.2
    case jpegMid = 0.5
    case jpegHigh = 0.75
}

extension KeyedEncodingContainer {

    mutating func encode(_ value: UIImage,
                         forKey key: KeyedEncodingContainer.Key,
                         quality: ImageEncodingQuality = .png) throws {
        var imageData: Data!
        if quality == .png {
            imageData = value.pngData()
        } else {
            imageData = value.jpegData(compressionQuality: quality.rawValue)
        }
        try encode(imageData, forKey: key)
    }

}

extension KeyedDecodingContainer {

    public func decode(_ type: UIImage.Type, forKey key: KeyedDecodingContainer.Key) throws -> UIImage {
        let imageData = try decode(Data.self, forKey: key)
        if let image = UIImage(data: imageData) {
            return image
        } else {
            throw SDKError.imageConversionError
        }
    }

}
class ImageWrapper: Codable {

    private enum CodingKeys: String, CodingKey {
        case uiImage
    }

    let uiImage: UIImage
    
    init(uiImage: UIImage){
        self.uiImage = uiImage
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uiImage = try container.decode(UIImage.self, forKey: .uiImage)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(uiImage, forKey: .uiImage, quality: .png)
    }
}
enum SDKError: Error {
    case imageConversionError
    case pdfConversionError
    case documentFindError
}

////


extension Value: Codable{
//    func x(){
//        var x = ValueParams<UIImage, StringDisplayType, StringCreateDisplayType, StringEditDisplayType>
//    }
    
    private struct ValueParams<Value, DisplayType, CreateType, EditType>: Codable where Value: Codable, DisplayType: Codable, CreateType: Codable, EditType: Codable{
        let value: Value
        let displayType: DisplayType
        let createType: CreateType?
        let editType: EditType
        
        init(value: Value, displayType: DisplayType, createType: CreateType? = nil, editType: EditType) {
            self.value = value
            self.displayType = displayType
            self.createType = createType
            self.editType = editType
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case base, stringParams, intParams, dataParams, dataArrayParams, dateParams, documentParams, pickerParams, documentWrapperParams, imagesParams
    }
    
    private enum Base: String, Codable {
        case string, date, int, data, picker, dataArray, documentWrapper, images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(Base.self, forKey: .base)
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
               case .data:
                let params = try container.decode(ValueParams<Data, DataDisplayType, DataCreateDisplayType, DataEditDisplayType>.self, forKey: .dataParams)
                self = .data(value: params.value, displayType: params.displayType, editType: params.editType)
               case .dataArray:
                let params = try container.decode(ValueParams<[Data], DataArrayDisplayType, DataArrayCreateDisplayType, DataArrayEditDisplayType>.self, forKey: .dataArrayParams)
                self = .dataArray(value: params.value, displayType: params.displayType, createType: params.createType!, editType: params.editType)
                
                case .documentWrapper:
                               let params = try container.decode(ValueParams<DocumentWrapper, DocumentDisplayType, DocumentCreateDisplayType, DocumentEditDisplayType>.self, forKey: .documentWrapperParams)
                               self = .documentWrapper(value: params.value, displayType: params.displayType, editType: params.editType)
//               case .document:
//                let params = try container.decode(ValueParams<String, DocumentDisplayType, DocumentCreateDisplayType, DocumentEditDisplayType>.self, forKey: .documentParams)
//                self = .document(value: params.value, displayType: params.displayType, editType: params.editType)
               case .picker:
                let params = try container.decode(ValueParams<PickerStruct, PickerDisplayType, PickerCreateDisplayType, PickerEditDisplayType>.self, forKey: .pickerParams)
                self = .picker(value: params.value, displayType: params.displayType, editType: params.editType)
               case .images:
                let params = try container.decode(ValueParams<[ImageWrapper], DataArrayDisplayType, DataArrayCreateDisplayType, DataArrayEditDisplayType>.self, forKey: .imagesParams)
                self = .images(value: params.value, displayType: params.displayType, createType: params.createType!, editType: params.editType)
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value, let displayType, let editType):
            try container.encode(Base.string, forKey: .base)
            try container.encode(ValueParams<String, StringDisplayType, StringCreateDisplayType, StringEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .stringParams)
   
        case .data(let value, let displayType, let editType):
            try container.encode(Base.data, forKey: .base)
            try container.encode(ValueParams<Data, DataDisplayType, DataCreateDisplayType, DataEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .dataParams)
        case .dataArray(let value, let displayType, let createType, let editType):
        try container.encode(Base.dataArray, forKey: .base)
        try container.encode(ValueParams(value: value, displayType: displayType, createType: createType, editType: editType), forKey: .dataArrayParams)
        case .int(let value, let displayType, let editType):
            try container.encode(Base.string, forKey: .base)
            try container.encode(ValueParams<Int, IntDisplayType, IntCreateDisplayType, IntEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .intParams)
        case .picker(let value, let displayType, let editType):
            try container.encode(Base.picker, forKey: .base)
            try container.encode(ValueParams<PickerStruct, PickerDisplayType, PickerCreateDisplayType, PickerEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .pickerParams)
            case .documentWrapper(let value, let displayType, let editType):
                       try container.encode(Base.documentWrapper, forKey: .base)
                       try container.encode(ValueParams<DocumentWrapper, DocumentDisplayType, DocumentCreateDisplayType, DocumentEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .documentWrapperParams)
//        case .document(let value, let displayType, let editType):
//            try container.encode(Base.document, forKey: .base)
//            try container.encode(ValueParams<String, DocumentDisplayType, DocumentCreateDisplayType, DocumentEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .documentParams)
        case .date(let value, let displayType, let editType):
            try container.encode(Base.date, forKey: .base)
            try container.encode(ValueParams<Date, DateDisplayType, DateCreateDisplayType, DateEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .dateParams)
        case .images(let value, let displayType, let createType, let editType):
            try container.encode(Base.images, forKey: .base)
            try container.encode(ValueParams<[ImageWrapper], DataArrayDisplayType, DataArrayCreateDisplayType, DataArrayEditDisplayType>(value: value, displayType: displayType, createType: createType, editType: editType), forKey: .imagesParams)
        }
    }
}





enum StringDisplayType: String, Codable {
    case text
}

enum StringCreateDisplayType: String, Codable{
    case textField
    case textView
}

enum StringEditDisplayType: String, Codable{
    case textField
    case textView
}
///

enum DocumentDisplayType: String, Codable {
    case basic
}

enum DocumentCreateDisplayType: String, Codable{
    case basic
}

enum DocumentEditDisplayType: String, Codable{
    case basic
}
///

enum DateDisplayType: String, Codable {
    case basic
}

enum DateCreateDisplayType: String, Codable {
    case basic
}

enum DateEditDisplayType: String, Codable {
    case basic
}

///

enum DataDisplayType: String, Codable{
    case images
    case scan
    // could have number of allowed images 
}

enum DataCreateDisplayType: String, Codable {
    case images
    case scan
}


enum DataEditDisplayType: String, Codable {
    case images
    case scan
}

///
enum DataArrayDisplayType: String, Codable{
    case images
}

enum DataArrayEditDisplayType: String, Codable {
    case images
}

enum DataArrayCreateDisplayType: String, Codable {
    case camera
    case photoLibrary
}

//

enum IntDisplayType: String, Codable {
    case dollars
    case minutes
}

enum IntCreateDisplayType: String, Codable {
    case dollars
    case minutes
}

enum IntEditDisplayType: String, Codable {
    case dollars
    case minutes
}

//
enum PickerDisplayType: String, Codable{
    case basic
}

enum PickerCreateDisplayType: String, Codable{
    case basic
}

enum PickerEditDisplayType: String, Codable{
    case basic
}

