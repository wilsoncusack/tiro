//
//  Picker.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 12/6/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation

enum CoreDataChoiceTypes: String, Codable {
    case user
    case tag
}

struct PickerStruct: Codable {
    var selected: [String]
    var allowedChoices: Int
    var isCoreData: Bool
    var coreDataType: CoreDataChoiceTypes?
    var choices: [String]
}


struct ToDoElement: Codable {
    var done: Bool
    var what: String
    var when: Date
    var sendReminder: Bool
}
