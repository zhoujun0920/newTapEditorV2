//
//  Tab.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/19/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import Foundation
import CoreData

class Tab: NSManagedObject {

    @NSManaged var indexID: NSNumber
    @NSManaged var tab_name: String
    @NSManaged var tab_content: AnyObject
    @NSManaged var tabAtPosition: Position

}
