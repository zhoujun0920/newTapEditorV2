//
//  Tabs.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/23/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import Foundation
import CoreData

@objc(Tabs)
class Tabs: NSManagedObject {

    @NSManaged var index: NSNumber
    @NSManaged var name: String
    @NSManaged var content: String

}
