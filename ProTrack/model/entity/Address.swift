//
//  Address.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation
import CoreData

class Address: NSManagedObject {

    @NSManaged var area: String
    @NSManaged var city: String
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var street: String
    @NSManaged var task: Task

}
