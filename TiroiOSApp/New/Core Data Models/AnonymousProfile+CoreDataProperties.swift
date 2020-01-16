//
//  AnonymousProfile+CoreDataProperties.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 10/9/19.
//  Copyright © 2019 Wilson Cusack. All rights reserved.
//
//

import Foundation
import CoreData


extension AnonymousProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnonymousProfile> {
        return NSFetchRequest<AnonymousProfile>(entityName: "AnonymousProfile")
    }

    @NSManaged public var id: UUID

}

extension AnonymousProfile{
    convenience init(id: UUID = UUID()) {
        self.init(context: AppDelegate.viewContext)
        self.id = id
    }
}
