//
//  Image.swift
//  ProTrack
//
//  Created by Sunny on 30/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation
import CoreData

class Image: NSManagedObject {

    @NSManaged var image: NSData
    @NSManaged var task: Task

}
