//
//  Document_Element.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/8/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import CoreData

@objc(Document_Element)
public class Document_Element: NSManagedObject {

}

enum DisplayType: String {
    case text
    case scan
    case image
    case video
    case picker
}

enum EditType: String {
    case textField
    case textView
    case image
    case video
    case scan
    case picker
}

// is text the only place where this matters?
// shouldn't value type define almost all of this?
// Or we could have different ways to display images
// because if just text could just have two different value types for text 


extension Document_Element: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document_Element> {
        return NSFetchRequest<Document_Element>(entityName: "Document_Element")
    }
    @NSManaged public var id: UUID
    @NSManaged public var order: Int16
  //  @NSManaged public var display_type: String
    //@NSManaged public var edit_type: String
    @NSManaged public var value_private: Data
    @NSManaged public var date_created: Date
    @NSManaged public var document: Document
    

    
//    var value: Value? {
//        get {
//
//            let k = JSONDecoder()
//            do{
//                let v : Value = try k.decode(Value.self, from: self.value_private)
//                return v
//            } catch {
//                print("error in get: \(error)")
//            }
//            return nil
//
//        }
//        set {
//
//            do{
//                let k = try JSONEncoder().encode(newValue)
//                self.value_private = k
//            }catch{
//                print("error in set: \(error)")
//            }
//
//        }
//    }
    
//    var displayType: DisplayType {
//        get {
//            DisplayType(rawValue: self.display_type)!
//        }
//        set {
//            self.display_type = newValue.rawValue
//        }
//    }
//
//    var editType: EditType {
//        get {
//            EditType(rawValue: self.edit_type)!
//        }
//        set {
//            self.edit_type = newValue.rawValue
//        }
//    }

}

extension Document_Element {
    convenience init(
        id: UUID = UUID(),
        order: Int,
        value: Value,
//        editType: EditType,
//        displayType: DisplayType,
        date_created: Date = Date(),
        document: Document
    ) {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.order = Int16(order)
       // self.valueType = valueType
        //self.value = value
//        self.editType = editType
//        self.displayType = displayType
        self.date_created = date_created
        self.document = document
    }
    
  
}


