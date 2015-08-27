//
//  NewTabs.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/25/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import Foundation
import CoreData

@objc(NewTabs)
class NewTabs: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var index: String
    @NSManaged var name: String

}
