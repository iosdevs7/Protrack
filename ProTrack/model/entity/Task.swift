//
//  Task.swift
//  ProTrack
//
//  Created by Sunny on 30/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var date: String
    @NSManaged var desp: String
    @NSManaged var priority: String?
    @NSManaged var reqId: String
    @NSManaged var status: String?
    @NSManaged var techAssigned: String?
    @NSManaged var time: String
    @NSManaged var address: Address
    @NSManaged var image: NSSet
    @NSManaged var login: Login

}
