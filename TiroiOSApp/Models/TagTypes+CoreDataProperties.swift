//
//  TagTypes+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/30/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData

public class TagType: NSManagedObject {
    
}

extension TagType: Identifiable  {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagType> {
        return NSFetchRequest<TagType>(entityName: "Tag_Type")
    }
    
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var instances: NSSet?
    
}

extension TagType {
    static func create(name: String, in context: NSManagedObjectContext){
        let tagType = TagType(context: context)
        tagType.id = UUID()
        tagType.name = name
    }
}

extension TagType{
    convenience init(
        id: UUID = UUID(),
        name: String
    ){
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.name = name
    }
    
}

// MARK: Generated accessors for instances
extension TagType {
    
    @objc(addInstancesObject:)
    @NSManaged public func addToInstances(_ value: Tag)
    
    @objc(removeInstancesObject:)
    @NSManaged public func removeFromInstances(_ value: Tag)
    
    @objc(addInstances:)
    @NSManaged public func addToInstances(_ values: NSSet)
    
    @objc(removeInstances:)
    @NSManaged public func removeFromInstances(_ values: NSSet)
    
}
