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


extension Document_Element: Identifiable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document_Element> {
        return NSFetchRequest<Document_Element>(entityName: "Document_Element")
    }
    @NSManaged public var id: UUID
    @NSManaged public var order: Int16
    //  @NSManaged public var display_type: String
    //@NSManaged public var edit_type: String
    @NSManaged private var value_raw: Data?
    @NSManaged private var type_private: String
    @NSManaged public var date_created: Date
    @NSManaged public var document: Document
    
    var type: ElementValueType{
        get {
           ElementValueType(rawValue: type_private)!
       }
       set {
           type_private = newValue.rawValue
       }
    }
}

extension Document_Element {
    convenience init(
        id: UUID = UUID(),
        order: Int,
        value: Value,
                type: ElementValueType,
        date_created: Date = Date(),
        document: Document
    ) {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.order = Int16(order)
        self.value_raw = try? JSONEncoder().encode(value)
        // self.valueType = valueType
        //self.value = value
        self.type = type
        self.date_created = date_created
        self.document = document
    }
    
    func updateValue(value: Value){
        self.value_raw = try? JSONEncoder().encode(value)
    }
    
    func decodeValue() -> Value?{
        if(self.value_raw == nil){
            return nil
        }
        return try? JSONDecoder().decode(Value.self, from: self.value_raw!)
    }
    
}


