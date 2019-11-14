//
//  Document.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 11/8/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//

import Foundation
import CoreData

@objc(Document)
public class Document: NSManagedObject {

}

// are these documents unique, or just standard reflection documents
// if situated in the day context, the data is set automatically
enum ReflectionType: String, Codable{
    case day
    case quote
    case image
    case scan
    case video
    case question
    case reflection
}

enum ActivityType: String, Codable{
    case book
    case event
    case activity
}

enum DocumentType: String {
     case book
     case event
     case activity
    
    case day
    case text 
    case quote
    case image
    case scan
    case video
    case question
    case reflection
}

extension Document: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Document> {
        return NSFetchRequest<Document>(entityName: "Document")
    }

    @NSManaged public var id: UUID
    @NSManaged private var type_private: String
    @NSManaged public var title: String
    @NSManaged public var is_template: Bool
    @NSManaged public var elements: NSSet?
    @NSManaged public var tags: NSSet?
    @NSManaged public var associated_users: NSSet?
    @NSManaged public var created_by: User
    @NSManaged public var date: Date
    @NSManaged public var date_created: Date
    
    var type: DocumentType{
        get {
            DocumentType(rawValue: type_private)!
        }
        set {
            type_private = newValue.rawValue
        }
    }

}

// MARK: Generated accessors for elements
extension Document {

    @objc(addElementsObject:)
    @NSManaged public func addToElements(_ value: Document_Element)

    @objc(removeElementsObject:)
    @NSManaged public func removeFromElements(_ value: Document_Element)

    @objc(addElements:)
    @NSManaged public func addToElements(_ values: NSSet)

    @objc(removeElements:)
    @NSManaged public func removeFromElements(_ values: NSSet)

}

extension Document {
    
    convenience init(
        id: UUID = UUID(),
        title: String,
        type: DocumentType,
        elements: NSSet?,
        tags: NSSet?,
        associated_users: NSSet?,
        created_by: User,
        date: Date?,
        date_created: Date = Date()
    ) {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.title = title
        self.type = type
        self.is_template = false
        self.elements = elements
        self.tags = tags
        self.associated_users = associated_users
        self.created_by = created_by
        self.date = date ?? date_created
        self.date_created = date_created
        
    }
    
    convenience init(
        id: UUID = UUID(),
        title: String,
        type: DocumentType,
        is_template: Bool,
        elements: NSSet?,
        tags: NSSet?,
        associated_users: NSSet?,
        created_by: User,
        date: Date?,
        date_created: Date = Date()
    ) {
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.title = title
        self.type = type
        self.is_template = is_template
        self.elements = elements
        self.tags = tags
        self.associated_users = associated_users
        self.created_by = created_by
        self.date = date ?? date_created
        self.date_created = date_created
        
    }
}
