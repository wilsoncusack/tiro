//
//  Tag+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 7/30/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData

public class Tag: NSManagedObject {

}

extension Tag: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var tag_type: TagType
    @NSManaged public var activities: NSSet?

}

extension Tag {
    static func create(name: String, tag_type: TagType, in context: NSManagedObjectContext){
        let tag = Tag(context: context)
        tag.id = UUID()
        tag.name = name
        tag.tag_type = tag_type
    }
}

extension Tag{
    convenience init(
        id : UUID = UUID(),
    name: String,
    tag_type: TagType
    ){
        self.init(context: AppDelegate.shared.persistentContainer.viewContext)
        self.id = id
        self.name = name
        self.tag_type = tag_type
    }
}

// MARK: Generated accessors for activities
extension Tag {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: Activity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: Activity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}
