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

public class TagTypes: NSManagedObject {

}

extension TagTypes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TagTypes> {
        return NSFetchRequest<TagTypes>(entityName: "Tag_Type")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var instances: NSSet?

}

// MARK: Generated accessors for instances
extension TagTypes {

    @objc(addInstancesObject:)
    @NSManaged public func addToInstances(_ value: Tag)

    @objc(removeInstancesObject:)
    @NSManaged public func removeFromInstances(_ value: Tag)

    @objc(addInstances:)
    @NSManaged public func addToInstances(_ values: NSSet)

    @objc(removeInstances:)
    @NSManaged public func removeFromInstances(_ values: NSSet)

}
