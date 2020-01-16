//
//  ValueParams.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/25/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

extension Value {

 struct ValueParams<Value, DisplayType, CreateType, EditType>: Codable where Value: Codable, DisplayType: Codable, CreateType: Codable, EditType: Codable{
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
}
