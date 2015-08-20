//
//  Position.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/19/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import Foundation
import CoreData

class Position: NSManagedObject {

    @NSManaged var index: NSNumber
    @NSManaged var note: String
    @NSManaged var positionForTab: NSSet

}
