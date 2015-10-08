//
//  Login.swift
//  ProTrack
//
//  Created by Sunny on 26/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation
import CoreData

class Login: NSManagedObject {

    @NSManaged var mobileNo: NSNumber
    @NSManaged var name: String
    @NSManaged var password: String
    @NSManaged var role: String
    @NSManaged var task: Task

}
