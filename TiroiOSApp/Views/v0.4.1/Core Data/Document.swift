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
     case book = "book"
     case event
     case activity
    
    case day
    case text 
    case quote
    case image
    case camera
    case scan
    case video
    case question
    case reflection
}

func getDocumentTypeString(type: DocumentType) -> String{
    return type.rawValue.capitalized
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
    
    
//    var x : MyValueParams<NSSet, StringDisplayType, StringCreateDisplayType, StringEditDisplayType>

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

//extension Document: Codable{
//
//    enum CodingKeys: String, CodingKey {
//        case id
//    }
//
//    convenience init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        var id = try container.decodeIfPresent(String.self, forKey: .id)
//        if(id != nil){
//            var document = getDocumentFromID(id: id!)!
//
//            self.title = document.title
//
//        }
//        }
//
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        switch self {
//        case .string(let value, let displayType, let editType):
//            try container.encode(Base.string, forKey: .base)
//            try container.encode(ValueParams<String, StringDisplayType, StringCreateDisplayType, StringEditDisplayType>(value: value, displayType: displayType, editType: editType), forKey: .stringParams)
//}
import SwiftUI
class  DocumentWrapper: ObservableObject, Codable {
    @ObservedObject public var document: Document
    
    var loading: Bool {
        var elements = document.elements?.allObjects as! [Document_Element]
        for e in elements{
            if e.value == nil{
                return true
            }
        }
        return false 
    }

     public enum CodingKeys: String, CodingKey {
       case id
     }
    
    public init(document: Document) {
      self.document = document
    }
    
    required public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
    
            let id = try container.decodeIfPresent(String.self, forKey: .id)
            
        if let document = getDocumentFromID(id: id!) {
                self.document = document
        } else {
            throw SDKError.documentFindError
        }
    
            
            }
    
        

public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.document.id.description, forKey: .id)
    }
}
