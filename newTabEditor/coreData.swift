//
//  coreData.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/19/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import Foundation
import CoreData

class coreData: NSObject  {
    let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
    let fretsBoard: [[String]] = [["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"], ["B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], ["G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"], ["D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"], ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"], ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]]
    
    func initfingersString() -> [String: String] {
        var fingersString: [String: String] = [String: String]()
        //4th string
        fingersString["4000"] = "xx0232"
        fingersString["4030"] = "xx3211"
        fingersString["4001"] = "xx0231"
        fingersString["4002"] = "xx0212"
        fingersString["4003"] = "xx0211"
        
        //5th string
        for var i = 0; i < 4; i++ {
            for var j = 0; j < 25; j++ {
                var t: String = String()
                if i == 0 {
                    if j == 3 {
                        fingersString["5030"] = "x32010"
                    } else {
                        fingersString["\(500 + j)0"] = "x\(j)\(j + 2)\(j + 2)\(j + 2)\(j)"
                    }
                } else if i == 1 {
                    fingersString["\(500 + j)1"] = "x\(j)\(j + 2)\(j + 2)\(j + 1)\(j)"
                } else if i == 2 {
                    fingersString["\(500 + j)2"] = "x\(j)\(j + 2)\(j)\(j + 2)\(j)"
                } else if i == 3 {
                    fingersString["\(500 + j)3"] = "x\(j)\(j + 2)\(j)\(j + 1)\(j)"
                }
                
            }
            
        }
        
        //6th string
        for var i = 0; i < 3; i++ {
            for var j = 0; j < 25; j++ {
                if i == 0 {
                    if j == 3 {
                        fingersString["6030"] = "320003"
                    } else {
                        fingersString["\(600 + j)0"] = "x\(j)\(j + 2)\(j + 2)\(j + 1)\(j)\(j)"
                    }
                } else if i == 1 {
                    fingersString["\(600 + j)1"] = "x\(j)\(j + 2)\(j + 2)\(j)\(j)\(j)"
                } else if i == 2 {
                    if j == 3 {
                        fingersString["6032"] = "3x0001"
                    }
                    fingersString["\(600 + j)2"] = "\(j)\(j + 2)\(j)\(j + 1)\(j)\(j)"
                }
            }
        }
        fingersString["6003"] = "022030"
        return fingersString
    }

    func addDefaultDataToDatabase() {
        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: nil, managedObjectContext: moc)
        var results2: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: nil, managedObjectContext: moc)
        if results.count == 150 && results2.count == 181 {
            println("Database already exist")
            var positionDict: NSDictionary = NSDictionary()
            for position in results {
                let singlePosition: Position = position as! Position
                println("\(singlePosition.index) + \(singlePosition.note)")
            }
            var tabDict: NSDictionary = NSDictionary()
            for tab in results2 {
                let singleTab: Tab = tab as! Tab
                println("\(singleTab.index) + \(singleTab.tab_name) + \(singleTab.tab_content)")
            }
        } else {
            //delete all data from database
            removeAllFromDatabase()
            var dict = initfingersString()
            //insert default data for main tab
            for var i = 400; i < 700; i = i + 100 {
                for var j = 0; j < 25; j++ {
                    var index = NSNumber(integer: i + j)
                    var note = fretsBoard[i / 100 - 1][j]
                    insertPositionRow(index, note: note, dict: dict)
                }
            }
            
            // insert default data for tabs
            
        }
    }
    
    func insertPositionRow(index: NSNumber, note: String, dict: Dictionary<String, String>) {
        var position: Position = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Position),   managedObjectConect: moc) as! Position
        position.note = note
        position.index = index
        if Int(index) >= 400 {
            var tabSuffix: [String] = ["", "m", "7", "m7"]
            for var i = 0; i < 4; i++ {
                var temp = "\(index)\(i)"
                if dict[temp] != nil {
                    insertTabRow(index, position: position, noteName: "\(note)\(tabSuffix[i])", content: dict[temp]!)
                }
            }
        }
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
    func insertTabRow(indexPosition: NSNumber, position: Position, noteName: String, content: String) {
        println("\(position.note) + \(position.index)")
        
        var tab: Tab = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tab), managedObjectConect: moc) as! Tab
        tab.index = indexPosition
        tab.tab_name = noteName
        tab.tab_content = content
        tab.tabAtPosition = position
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }

    
    func removeAllFromDatabase() {
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: nil, managedObjectContext: moc)
        for result in results {
            let item = result as! NSManagedObject
            moc.deleteObject(item)
        }
        var results2: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: nil, managedObjectContext: moc)
        for result in results2 {
            let item = result as! NSManagedObject
            moc.deleteObject(item)
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
    func addTabToDatabase(indexPosition: NSNumber, noteName: String, content: String) {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: predicate, managedObjectContext: moc)
        
        let position: Position = results.lastObject as! Position
        println("\(position.note) + \(position.index)")
        
        var tab: Tab = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tab), managedObjectConect: moc) as! Tab
        tab.index = indexPosition
        tab.tab_name = noteName
        tab.tab_content = content
        tab.tabAtPosition = position
        
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
    func getMainTabFromDatabase(indexPosition: NSNumber) -> NSDictionary {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: predicate, managedObjectContext: moc)
        var positionDict: NSDictionary = NSDictionary()
        for position in results {
            let singlePosition: Position = position as! Position
            if singlePosition.index == indexPosition {
                positionDict = ["index": singlePosition.index, "note": singlePosition.note]
            }
        }
        return positionDict
    }
    
    func getTabFromDatabase(indexPosition: NSNumber, tabName: String) -> NSDictionary {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: predicate, managedObjectContext: moc)
        var tabDict: NSDictionary = NSDictionary()
        for tab in results {
            let singleTab: Tab = tab as! Tab
            if singleTab.tab_name == tabName {
                tabDict = ["index": singleTab.index, "tabName": singleTab.tab_name, "tabContent": singleTab.tab_content]
                break
            }
        }
        return tabDict
    }
    
    func updateTabFromDatabase(indexPosition: NSNumber, oldTabName: String, newTabName: String, tabContent: String) {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: predicate, managedObjectContext: moc)
        for tab in results {
            var singleTab: Tab = tab as! Tab
            if singleTab.tab_name == oldTabName {
                singleTab.tab_name = newTabName
                singleTab.tab_content = tabContent
            }
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
    func removeTabFromDatabase(indexPosition: NSNumber, noteName: String) {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: predicate, managedObjectContext: moc)
        for tab in results {
            let singleTab: Tab = tab as! Tab
            if singleTab.tab_name == noteName {
                let item = singleTab as NSManagedObject
                moc.deleteObject(item)
                break
            }
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
}