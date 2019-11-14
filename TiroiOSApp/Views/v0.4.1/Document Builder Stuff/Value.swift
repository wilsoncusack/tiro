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
    case int(value: Int, displayType: IntDisplayType, editType: IntEditDisplayType)
    case date(value: Date, displayType: DateDisplayType, editType: DateEditDisplayType)
    case picker(value: PickerStruct, displayType: PickerDisplayType, editType: PickerEditDisplayType)
    case document(value: String, displayType: DocumentDisplayType, editType: DocumentEditDisplayType)
}


extension Value: Codable{
    private struct ValueParams<Value, DisplayType, EditType>: Codable where Value: Codable, DisplayType: Codable, EditType: Codable{
        let value: Value
        let displayType: DisplayType
        let editType: EditType
    }
    
    enum CodingKeys: String, CodingKey {
        case base, stringParams, intParams, dataParams, dateParams, documentParams, pickerParams
    }
    
    private enum Base: String, Codable {
        case string, date, int, data, document, picker
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base = try container.decode(Base.self, forKey: .base)
        //
               switch base {
               case .string:
                let params = try container.decode(ValueParams<String, StringDisplayType, StringEditDisplayType>.self, forKey: .stringParams)
                self = .string(value: params.value, displayType: params.displayType, editType: params.editType)
               case .date:
                let params = try container.decode(ValueParams<Date, DateDisplayType, DateEditDisplayType>.self, forKey: .dateParams)
                self = .date(value: params.value, displayType: params.displayType, editType: params.editType)
               case .int:
                let params = try container.decode(ValueParams<Int, IntDisplayType, IntEditDisplayType>.self, forKey: .intParams)
                self = .int(value: params.value, displayType: params.displayType, editType: params.editType)
               case .data:
                let params = try container.decode(ValueParams<Data, DataDisplayType, DataEditDisplayType>.self, forKey: .dataParams)
                self = .data(value: params.value, displayType: params.displayType, editType: params.editType)
               case .document:
                let params = try container.decode(ValueParams<String, DocumentDisplayType, DocumentEditDisplayType>.self, forKey: .documentParams)
                self = .document(value: params.value, displayType: params.displayType, editType: params.editType)
               case .picker:
                let params = try container.decode(ValueParams<PickerStruct, PickerDisplayType, PickerEditDisplayType>.self, forKey: .pickerParams)
                self = .picker(value: params.value, displayType: params.displayType, editType: params.editType)
        }
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .string(let value, let displayType, let editType):
            try container.encode(Base.string, forKey: .base)
            try container.encode(ValueParams(value: value, displayType: displayType, editType: editType), forKey: .stringParams)
   
        case .data(let value, let displayType, let editType):
            try container.encode(Base.string, forKey: .base)
            try container.encode(ValueParams(value: value, displayType: displayType, editType: editType), forKey: .dataParams)
        case .int(let value, let displayType, let editType):
            try container.encode(Base.string, forKey: .base)
            try container.encode(ValueParams(value: value, displayType: displayType, editType: editType), forKey: .intParams)
        case .picker(let value, let displayType, let editType):
            try container.encode(Base.picker, forKey: .base)
            try container.encode(ValueParams(value: value, displayType: displayType, editType: editType), forKey: .pickerParams)
        case .document(let value, let displayType, let editType):
            try container.encode(Base.document, forKey: .base)
            try container.encode(ValueParams(value: value, displayType: displayType, editType: editType), forKey: .documentParams)
        case .date(let value, let displayType, let editType):
            try container.encode(Base.date, forKey: .base)
            try container.encode(ValueParams(value: value, displayType: displayType, editType: editType), forKey: .dateParams)
        }
    }
}





enum StringDisplayType: String, Codable {
    case text
}

enum StringEditDisplayType: String, Codable{
    case textField
    case textView
}

enum DocumentDisplayType: String, Codable {
    case basic
}

enum DocumentEditDisplayType: String, Codable{
    case basic
}

enum DateDisplayType: String, Codable {
    case basic
}

enum DateEditDisplayType: String, Codable {
    case basic
}


enum DataDisplayType: String, Codable{
    case images
    case scan
    // could have number of allowed images 
}

enum DataEditDisplayType: String, Codable {
    case images
    case scan
}

enum IntDisplayType: String, Codable {
    case dollars
    case minutes
}

enum IntEditDisplayType: String, Codable {
    case dollars
    case minutes
}

enum PickerDisplayType: String, Codable{
    case basic
}

enum PickerEditDisplayType: String, Codable{
    case basic
}

