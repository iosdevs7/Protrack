//
//  TechnicianData.swift
//  ProTrack
//
//  Created by Sunny on 30/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import UIKit
import CoreData

class TechnicianData: NSObject {
    func createProduct() -> Technician?{
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        let entityDescripition = NSEntityDescription.entityForName("Technician", inManagedObjectContext: managedObjectContext!)
        let LoginObj = Technician(entity: entityDescripition!, insertIntoManagedObjectContext: managedObjectContext)
        return LoginObj
        
    }
    
    func insertUser() {
        
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        var error: NSError? = nil
        managedObjectContext?.save(&error)
        println("Any Error \(error)")
    }
    func userFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Technician")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        return fetchRequest
    }
    
}
