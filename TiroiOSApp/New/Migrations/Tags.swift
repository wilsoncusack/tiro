//
//  Tags.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/8/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import Foundation
import CoreData

func createFirstTags(){
    let tagFetch = NSFetchRequest<Tag>(entityName: "Tag")
    do{
        let tags = try AppDelegate.viewContext.fetch(tagFetch)
        if(tags.count == 0 ){
            print("creating first tags")
            let subjectType = TagType(name: "Subject")
            var _ = Tag(name: "math", tag_type: subjectType)
            var _ = Tag(name: "science", tag_type: subjectType)
            var _ = Tag(name: "reading", tag_type: subjectType)
            var _ = Tag(name: "writing", tag_type: subjectType)
            var _ = Tag(name: "history", tag_type: subjectType)
            var _ = Tag(name: "foreign language", tag_type: subjectType)
            AppDelegate.shared.saveContext()
        }
    } catch {
        print(error)
    }
    
}
