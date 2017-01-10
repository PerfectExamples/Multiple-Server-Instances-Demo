//
//  Database.swift
//  MultipleServerInstances
//
//  Created by Ryan Collins on 1/10/17.
//
//

import Foundation
import PerfectLib
import SQLite

struct Database {
    
    func create() {
        
        let dir = Dir("./db/")
        let database = "./db/database"
        
        if !dir.exists {
            do {
                try dir.create()
            } catch {
                print(error)
            }
        }
        
        do {
            let sqlite = try SQLite(database)
            
            dump(sqlite)
            
            defer {
                sqlite.close() // This makes sure we close our connection.
            }
            
            try sqlite.execute(statement: "CREATE TABLE IF NOT EXISTS shipments (id INTEGER PRIMARY KEY NOT NULL, tracking_number TEXT NOT NULL, last_hub TEXT NOT NULL, destination TEXT NOT NULL)")
        } catch {
            print("Failure creating database at \(database)")
        }
        
    }
    
}
