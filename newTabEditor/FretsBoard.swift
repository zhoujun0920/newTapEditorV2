//
//  FretsBoard.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/14/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import Foundation

class FretsBoard {
    static  var fretsBoard: [[String]] = [["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"], ["B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"], ["G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G"], ["D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D"], ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A"], ["E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B", "C", "C#", "D", "D#", "E"]]
    
    // 0- 1-m 2-7 3-m7
    func initfingersString() -> [String: String] {
        var fingersString: [String: String] = [String: String]()
        //4th string
        fingersString["4000"] = "xx0232"
        fingersString["4030"] = "xx3211"
        fingersString["4000"] = "xx0231"
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
    
//    static var fretBoard: [[String]] = [["E", "B", "G", "D", "A", "E"],["F", "C", "G#", "D#", "A#", "F"], ["F#", "C#", "A", "E", "B", "F#"], ["G", "D", "A#", "F", "C", "G"], ["G#", "D#", "B", "F#", "C#", "G#"], ["A", "E", "C", "G", "D", "A"], ["A#", "F", "C#", "G#", "D#", "A#"], ["B", "F#", "D", "A", "E", "B"], ["C", "G", "D#", "A#", "F", "C"], ["C#", "G#", "E", "B", "F#", "C#"], ["D", "A", "F", "C", "G", "D"], ["D#", "A#", "F#", "C#", "G#", "D#"], ["E", "B", "G", "D", "A", "E"]]
}