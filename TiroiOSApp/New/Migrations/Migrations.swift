//
//  Migrations.swift
//  TiroiOSApp
//
//  Created by Wilson Cusack on 1/8/20.
//  Copyright © 2020 Wilson Cusack. All rights reserved.
//

import Foundation
import CoreData


var migrationsDict : [String: () -> Void] = [
    "tags": createFirstTags,
    "templates": createTemplates,
    "7.1.19": migration1
]

func checkMigrations(){
    print("check migration called")
    var migrations = getAllMigrations()
    
    
    var keys = migrationsDict.keys
    for k in keys{
        print("checking keys")
        if(!migrationHasRuns(name: k, migrations: migrations)){
           print("running migration: \(k)")
            var f = migrationsDict[k]!
            f()
            Migration(name: k)
        } else {
            print("\(k) has already been run")
        }
    }
    AppDelegate.shared.saveContext()
}

func getAllMigrations() -> [Migration] {
    let fetch : NSFetchRequest<Migration> = Migration.fetchRequest()
    do{
        return try AppDelegate.viewContext.fetch(fetch)
    } catch {
        print(error)
    }
    return []
}

func migrationHasRuns(name: String, migrations: [Migration]) -> Bool {
    var occurences = migrations.filter {
        $0.name == name
    }
    return occurences.count > 0
}
