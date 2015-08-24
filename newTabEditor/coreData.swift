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
    let fretsBoard: [[String]] = [
        ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"],
        ["B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"],
        ["G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"],
        ["D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"],
        ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"],
        ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]
    ]
    
    func initfingersString() -> [String: String] {
        var fingersString: [String: String] = [String: String]()
        //4th string
        fingersString["40000"] = "xxxx00020302"
        fingersString["40300"] = "xxxx03020101"
        fingersString["40001"] = "xxxx00020301"
        fingersString["40002"] = "xxxx00020102"
        fingersString["40003"] = "xxxx00020101"
        
        //5th string
        for var i = 0; i < 4; i++ {
            for var j = 0; j < 23; j++ {
                var t: String = String()
                if i == 0 {
                    if j == 3 {
                        fingersString["50300"] = "xx0302000100"
                    } else {
                        if j < 8 {
                            fingersString["\(500 + j)00"] = "xx0\(j)0\(j + 2)0\(j + 2)0\(j + 2)0\(j)"
                        } else if j >= 8 && j < 10 {
                            fingersString["\(500 + j)00"] = "xx0\(j)\(j + 2)\(j + 2)\(j + 2)0\(j)"
                        } else {
                            fingersString["\(500 + j)00"] = "xx\(j)\(j + 2)\(j + 2)\(j + 2)\(j)"
                        }
                    }
                } else if i == 1 {
                    if j < 8 {
                        fingersString["\(500 + j)01"] = "xx0\(j)0\(j + 2)0\(j + 2)0\(j + 1)0\(j)"
                    } else if j == 8 {
                        fingersString["\(500 + j)01"] = "xx0\(j)\(j + 2)\(j + 2)0\(j + 1)0\(j)"
                    } else if j == 9 {
                        fingersString["\(500 + j)01"] = "xx0\(j)\(j + 2)\(j + 2)\(j + 1)0\(j)"
                    }else {
                        fingersString["\(500 + j)01"] = "xx\(j)\(j + 2)\(j + 2)\(j + 1)\(j)"
                    }
                } else if i == 2 {
                    if j < 8 {
                        fingersString["\(500 + j)02"] = "xx0\(j)0\(j + 2)0\(j)0\(j + 2)0\(j)"
                    } else if j >= 8 && j < 10 {
                        fingersString["\(500 + j)02"] = "xx0\(j)\(j + 2)0\(j)\(j + 2)0\(j)"
                    } else {
                        fingersString["\(500 + j)02"] = "xx\(j)\(j + 2)\(j)\(j + 2)\(j)"
                    }
                } else if i == 3 {
                    if j < 8 {
                        fingersString["\(500 + j)03"] = "xx0\(j)0\(j + 2)0\(j)0\(j + 1)0\(j)"
                    } else if j == 8 {
                        fingersString["\(500 + j)03"] = "xx0\(j)\(j + 2)0\(j)0\(j + 1)0\(j)"
                    } else if j == 9 {
                        fingersString["\(500 + j)03"] = "xx0\(j)\(j + 2)0\(j)\(j + 1)0\(j)"
                    } else {
                        fingersString["\(500 + j)03"] = "xx\(j)\(j + 2)\(j)\(j + 1)\(j)"
                    }
                }
                
            }
            
        }
        
        //6th string
        for var i = 0; i < 3; i++ {
            for var j = 0; j < 23; j++ {
                if i == 0 {
                    if j == 3 {
                        fingersString["60300"] = "030200000003"
                    } else {
                        if j < 8 {
                            fingersString["\(600 + j)00"] = "0\(j)0\(j + 2)0\(j + 2)0\(j + 1)0\(j)0\(j)"
                        } else if j == 8 {
                            fingersString["\(600 + j)00"] = "0\(j)\(j + 2)\(j + 2)0\(j + 1)0\(j)0\(j)"
                        } else if j == 9 {
                            fingersString["\(600 + j)00"] = "x\(j)\(j + 2)\(j + 2)\(j + 1)0\(j)0\(j)"
                        }else {
                            fingersString["\(600 + j)00"] = "\(j)\(j + 2)\(j + 2)\(j + 1)\(j)\(j)"
                        }
                    }
                } else if i == 1 {
                    if j < 8 {
                        fingersString["\(600 + j)01"] = "0\(j)0\(j + 2)0\(j + 2)0\(j)0\(j)0\(j)"
                    } else if j >= 8 && j < 10 {
                        fingersString["\(600 + j)01"] = "0\(j)\(j + 2)\(j + 2)0\(j)0\(j)0\(j)"
                    } else {
                        fingersString["\(600 + j)01"] = "\(j)\(j + 2)\(j + 2)\(j)\(j)\(j)"
                    }
                } else if i == 2 {
                    if j == 3 {
                        fingersString["60302"] = "03xx00000001"
                    }
                    if j < 8 {
                        fingersString["\(600 + j)02"] = "0\(j)0\(j + 2)0\(j)0\(j + 1)0\(j)0\(j)"
                    } else if j == 8 {
                        fingersString["\(600 + j)02"] = "0\(j)\(j + 2)0\(j)0\(j + 1)0\(j)0\(j)"
                    } else if j == 9 {
                        fingersString["\(600 + j)02"] = "0\(j)\(j + 2)0\(j)\(j + 1)0\(j)0\(j)"
                    }else {
                        fingersString["\(600 + j)02"] = "\(j)\(j + 2)\(j)\(j + 1)\(j)\(j)"
                    }
                }
            }
        }
        fingersString["60003"] = "000202000300"
        return fingersString
    }
    
    func addDefaultData() {
        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: nil, managedObjectContext: moc)
        if results.count == 279 {
            println("Database already exist")
            for result in results {
                let singleTab: Tabs = result as! Tabs
                println("\(singleTab.index) + \(singleTab.name) + \(singleTab.content)")
            }
        } else {
            removeAllFromDatabase()
            var dict = initfingersString()
            for var i = 1; i < 7; i++ {
                for var j = 0; j < 25; j++ {
                    var count: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: nil, managedObjectContext: moc)
                    var index = NSNumber(integer: i * 10000 + j * 100)
                    var note = fretsBoard[i - 1][j]
                    println("\(note)")
                    insertInitialTabs(index, name: note, dict: dict)
                }
            }
        }
    }
    
    func insertInitialTabs(index: NSNumber, name: String, dict: Dictionary<String, String>) {
        if Int(index) < 40000 {
            var tab: Tabs = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tabs), managedObjectConect: moc) as! Tabs
            tab.name = name
            tab.index = index
            tab.content = ""
            SwiftCoreDataHelper.saveManagedObjectContext(moc)
        } else {
            var tabSuffix: [String] = ["", "m", "7", "m7"]
            for var i = 0; i < 4; i++ {
                var temp = "\(Int(index) + i)"
                if dict[temp] != nil {
                    var tab: Tabs = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tabs), managedObjectConect: moc) as! Tabs
                    var noteName = "\(name)\(tabSuffix[i])"
                    tab.name = noteName
                    tab.index = NSNumber(integer: (Int(index) + i))
                    tab.content = dict[temp]!
                } else if i == 0 {
                    var tab: Tabs = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tabs), managedObjectConect: moc) as! Tabs
                    tab.name = name
                    tab.index = index
                    tab.content = ""
                }
                SwiftCoreDataHelper.saveManagedObjectContext(moc)
            }
        }

    }
    
    func removeAllFromDatabase() {
        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: nil, managedObjectContext: moc)
        for result in results {
            let item = result as! NSManagedObject
            moc.deleteObject(item)
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    

    
    func addNewTab(index: NSNumber, name: String, content: String) {
        var tab: Tabs = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tabs), managedObjectConect: moc) as! Tabs
        tab.index = index
        tab.name = name
        tab.content = content
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
    func getExistTab(index: NSNumber) -> NSDictionary {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(index)'")
        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: predicate, managedObjectContext: moc)
        var tabDict: NSDictionary = NSDictionary()
        for result in results {
            let singleTab: Tabs = result as! Tabs
            if singleTab.index == index {
                tabDict = ["index": singleTab.index, "name": singleTab.name, "content": singleTab.content]
            }
        }
        return tabDict
    }
    
    func removeExistTab(index: NSNumber) {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(index)'")
        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: predicate, managedObjectContext: moc)
        for result in results {
            let singleTab: Tabs = result as! Tabs
            if singleTab.index == index {
                let item = singleTab as NSManagedObject
                moc.deleteObject(item)
            }
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
    func updateExistTab(index: NSNumber, name: String, content: String) {
        let predicate: NSPredicate = NSPredicate(format: "index == '\(index)'")
        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: predicate, managedObjectContext: moc)
        for result in results {
            var singleTab: Tabs = result as! Tabs
            if singleTab.index == index {
                singleTab.name = name
                singleTab.content = content
            }
        }
        SwiftCoreDataHelper.saveManagedObjectContext(moc)
    }
    
}
//    func addDefaultDataToDatabase() {
//        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: nil, managedObjectContext: moc)
//        var results2: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: nil, managedObjectContext: moc)
//        if results.count == 150 && results2.count == 181 {
//            println("Database already exist")
//            var positionDict: NSDictionary = NSDictionary()
//            for position in results {
//                let singlePosition: Position = position as! Position
//                println("\(singlePosition.index) + \(singlePosition.note)")
//            }
//            var tabDict: NSDictionary = NSDictionary()
//            for tab in results2 {
//                let singleTab: Tab = tab as! Tab
//                println("\(singleTab.index) + \(singleTab.tab_name) + \(singleTab.tab_content)")
//            }
//        } else {
//            //delete all data from database
//            removeAllFromDatabase()
//            var dict = initfingersString()
//            println("\(dict.count)")
//            //insert default data for main tab
//            var count = 0
//            for var i = 100; i < 700; i = i + 100 {
//                for var j = 0; j < 25; j++ {
//                    var index = NSNumber(integer: i + j)
//                    var note = fretsBoard[i / 100 - 1][j]
//                    println("\(note)")
//                    insertPositionRow(index, note: note, dict: dict)
//                    count++
//                }
//            }
//            println("\(count)")
//            // insert default data for tabs
//        }
//    }
//    
//    func insertPositionRow(index: NSNumber, note: String, dict: Dictionary<String, String>) {
//        var position: Position = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Position),   managedObjectConect: moc) as! Position
//        position.note = note
//        position.index = index
//        //println("\(note) + \(index)")
//        SwiftCoreDataHelper.saveManagedObjectContext(moc)
//        if Int(index) >= 400 {
//            var tabSuffix: [String] = ["", "m", "7", "m7"]
//            for var i = 0; i < 4; i++ {
//                var temp = "\(index)\(i)"
//                if dict[temp] != nil {
//                    var name = "\(note)\(tabSuffix[i])"
//                    insertTabRow(index, position: position, noteName: name, content: dict[temp]!)
//                }
//            }
//        }
//    }
//    
//    func insertTabRow(indexPosition: NSNumber, position: Position, noteName: String, content: String) {
//        var tab: Tab = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tab), managedObjectConect: moc) as! Tab
//        tab.index = indexPosition
//        tab.tab_name = noteName
//        tab.tab_content = content
//        tab.tabAtPosition = position
//        //println("\(noteName) + \(indexPosition)")
//        
//        SwiftCoreDataHelper.saveManagedObjectContext(moc)
//    }
//
//    
//    func removeAllFromDatabase() {
//        let moc: NSManagedObjectContext = SwiftCoreDataHelper.managedObjectContext()
//        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tabs), withPredicate: nil, managedObjectContext: moc)
//        for result in results {
//            let item = result as! NSManagedObject
//            moc.deleteObject(item)
//        }
////        var results2: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: nil, managedObjectContext: moc)
////        for result in results2 {
////            let item = result as! NSManagedObject
////            moc.deleteObject(item)
////        }
//        SwiftCoreDataHelper.saveManagedObjectContext(moc)
//    }
//    
//    func addTabToDatabase(indexPosition: NSNumber, noteName: String, content: String) {
//        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
//        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: predicate, managedObjectContext: moc)
//        
//        let position: Position = results.lastObject as! Position
//        println("\(position.note) + \(position.index)")
//        
//        var tab: Tab = SwiftCoreDataHelper.insertManagedObject(NSStringFromClass(Tab), managedObjectConect: moc) as! Tab
//        tab.index = indexPosition
//        tab.tab_name = noteName
//        tab.tab_content = content
//        tab.tabAtPosition = position
//        
//        SwiftCoreDataHelper.saveManagedObjectContext(moc)
//    }
//    
//    func getMainTabFromDatabase(indexPosition: NSNumber) -> NSDictionary {
//        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
//        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Position), withPredicate: predicate, managedObjectContext: moc)
//        var positionDict: NSDictionary = NSDictionary()
//        for position in results {
//            let singlePosition: Position = position as! Position
//            if singlePosition.index == indexPosition {
//                positionDict = ["index": singlePosition.index, "note": singlePosition.note]
//            }
//        }
//        return positionDict
//    }
//    
//    func getTabFromDatabase(indexPosition: NSNumber, tabName: String) -> NSDictionary {
//        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
//        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: predicate, managedObjectContext: moc)
//        var tabDict: NSDictionary = NSDictionary()
//        for tab in results {
//            let singleTab: Tab = tab as! Tab
//            if singleTab.tab_name == tabName {
//                tabDict = ["index": singleTab.index, "tabName": singleTab.tab_name, "tabContent": singleTab.tab_content]
//                break
//            }
//        }
//        return tabDict
//    }
//    
//    func updateTabFromDatabase(indexPosition: NSNumber, oldTabName: String, newTabName: String, tabContent: String) {
//        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
//        let results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: predicate, managedObjectContext: moc)
//        for tab in results {
//            var singleTab: Tab = tab as! Tab
//            if singleTab.tab_name == oldTabName {
//                singleTab.tab_name = newTabName
//                singleTab.tab_content = tabContent
//            }
//        }
//        SwiftCoreDataHelper.saveManagedObjectContext(moc)
//    }
//    
//    func removeTabFromDatabase(indexPosition: NSNumber, noteName: String) {
//        let predicate: NSPredicate = NSPredicate(format: "index == '\(indexPosition)'")
//        var results: NSArray = SwiftCoreDataHelper.fetchEntities(NSStringFromClass(Tab), withPredicate: predicate, managedObjectContext: moc)
//        for tab in results {
//            let singleTab: Tab = tab as! Tab
//            if singleTab.tab_name == noteName {
//                let item = singleTab as NSManagedObject
//                moc.deleteObject(item)
//                break
//            }
//        }
//        SwiftCoreDataHelper.saveManagedObjectContext(moc)
//    }
//}