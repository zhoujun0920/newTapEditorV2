//
//  ViewController.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/10/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController{
    
    var chords: [Chord] = [Chord]()
    
    // core data delegate
//    var yourPosition: NSMutableArray = NSMutableArray()
//    var delegate: PositionSelectDelegate? = nil
    var core = coreData()
    
    //first view
    var backgroundImage: UIImageView = UIImageView()
    var guitarImage: UIImageView = UIImageView()
    var editButton: UIButton = UIButton()
    var removeButton: UIButton = UIButton()
    var previewButton: UIButton = UIButton()
    var previousButton: UIButton = UIButton()
    var backButton: UIButton = UIButton()
    var doneButton: UIButton = UIButton()
    var editViewBackgroundImage: UIImageView = UIImageView()
    var mainViewTitle: UILabel = UILabel()
    var menuView: UIView = UIView()
    var fretLabelView: UIView = UIView()
    
    //edit view
    var guitar3StringImage: UIImageView = UIImageView()
    var addExistTabOnScrollView: Bool = Bool()
    var existTabScrollView: UIScrollView = UIScrollView()
    var newTabName: UITextField = UITextField()
    var newTabAvaliable: UISwitch = UISwitch()
    var editView: UIView = UIView()
    var scrollView: UIScrollView = UIScrollView()
    var tabNameLabelEdit: [UILabel] = [UILabel]()
    var tabNameLabelNotEdit: [UILabel] = [UILabel]()
    var editViewNotes: [UIButton] = [UIButton]() // exist button we have
    var editAvaliable: Bool = Bool()
    var choosedNote: CGPoint = CGPoint()
    var editViewTempNoteButton: UIButton = UIButton() // only exist on edit process
    
    //string view
    var stringViewEdit: [UIView] = [UIView]()
    var stringViewNotEdit: [UIView] = [UIView]()
    var fretsLocation: [CGFloat] = [CGFloat]()
    var mainNoteButton: UIButton = UIButton() // add on the string
    var fingerPoint: [UIButton] = [UIButton]()
    
    var trueWidth: CGFloat = CGFloat()
    var trueHeight: CGFloat = CGFloat()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.rawValue)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.LandscapeLeft
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        core.addDefaultData()
        
        var tabs: NSDictionary = NSDictionary()
        
        if self.view.frame.height > self.view.frame.width {
            trueWidth = self.view.frame.height
            trueHeight = self.view.frame.width
        } else {
            trueWidth = self.view.frame.width
            trueHeight = self.view.frame.height
        }
        // background Image
        self.backgroundImage.frame = CGRectMake(0, 0, self.trueWidth, self.trueHeight)
        self.backgroundImage.image = UIImage(named: "background")
        self.backgroundImage.contentMode = UIViewContentMode.ScaleToFill
        self.view.addSubview(self.backgroundImage)
        
        // menu bar
        self.menuView.frame = CGRectMake(0, 0, trueWidth, 0.08 * trueHeight)
        self.menuView.backgroundColor = UIColor.darkGrayColor().colorWithAlphaComponent(0.6)
        self.view.addSubview(self.menuView)
        

        // add notes view
        editAvaliable = false
        addExistTabOnScrollView = false
        
        self.scrollView.frame = CGRectMake(0, self.trueHeight, self.trueWidth, -0.425 * self.trueHeight)
        self.scrollView.contentSize = CGSizeMake(self.trueWidth * 4.2, 0.425 * self.trueHeight)
        self.scrollView.layer.borderWidth = 1
        self.view.addSubview(self.scrollView)
    
        //guitar 6 string image
        guitarImage.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, 0.75 * self.trueHeight)
        guitarImage.image = UIImage(named: "6-strings-updated")
        self.scrollView.addSubview(guitarImage)
        
        //guitar 3 string image
        self.guitar3StringImage.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, 0.375 * self.trueHeight)
        self.guitar3StringImage.image = UIImage(named: "3-strings-updated")
        self.scrollView.addSubview(guitar3StringImage)
        
        //fret label view
        self.fretLabelView.frame = CGRectMake(0, 0.375 * self.trueHeight, self.scrollView.contentSize.width, 0.05 * trueHeight)
        self.fretLabelView.backgroundColor = UIColor(patternImage: UIImage(named: "fret-label")!)
        self.scrollView.addSubview(fretLabelView)
        
        addObjectsOnMainView()
        fretLocation()
        createStringView()
        createFretsLabel()
        addFretsLabel("tabNameLabelNotEdit")
//        addStringView("stringViewNotEdit")
        
        //tap recongnizer
        var singleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewSingleTapped:")
        singleTapRecognizer.numberOfTapsRequired = 1
        singleTapRecognizer.numberOfTouchesRequired = 1
        self.scrollView.addGestureRecognizer(singleTapRecognizer)
    }
    

    
    func addObjectsOnEditView() {
        if editAvaliable == true {
            self.newTabName.frame = CGRectMake(0.82 * self.trueWidth, 0.09 * self.trueHeight, 0.1 * self.trueWidth, 0.1 * self.trueHeight)
            self.newTabName.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            self.newTabName.layer.cornerRadius = 0.4
            self.newTabAvaliable.frame = CGRectMake(0.925 * self.trueWidth, 0.1 * self.trueHeight, 0.1 * self.trueWidth, 0.12 * self.trueHeight)
            self.newTabAvaliable.alpha = 0
            self.newTabAvaliable.setOn(false, animated: true)
            self.newTabAvaliable.alpha = 0
            self.existTabScrollView.frame = CGRectMake(0, 0.09 * self.trueHeight, 0.55 * self.trueWidth, 0.1 * self.trueHeight)
            self.existTabScrollView.contentSize = CGSizeMake(1 * self.trueWidth, 0.1 * self.trueHeight)
            self.existTabScrollView.backgroundColor = UIColor.brownColor().colorWithAlphaComponent(0.6)
            self.existTabScrollView.alpha = 0
            self.view.addSubview(self.existTabScrollView)
            self.view.addSubview(self.newTabName)
            self.view.addSubview(self.newTabAvaliable)
            UIView.animateWithDuration(0.5, animations: {
                self.newTabAvaliable.alpha = 1
                self.newTabName.alpha = 0.6
                self.existTabScrollView.alpha = 0.6
            })
        }
    }
    
    func removeObjectOnEditView() {
        if self.editAvaliable == false {
            newTabName.removeFromSuperview()
            newTabAvaliable.removeFromSuperview()
            existTabScrollView.removeFromSuperview()
        }
        if self.addExistTabOnScrollView == true {
            for views in self.existTabScrollView.subviews {
                views.removeFromSuperview()
            }
        }
    }
    
    func addObjectsOnMainView() {
        var buttonColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
        var buttonWidth = CGFloat(28)
        var centerPoint = 0.08 * self.trueHeight / 2
        self.backButton.frame = CGRectMake(16, centerPoint - 15, buttonWidth, buttonWidth)
        self.backButton.backgroundColor = buttonColor
        self.backButton.setTitle("B", forState: UIControlState.Normal)
        self.backButton.addTarget(self, action: "pressBackButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.backButton.setImage(UIImage(named: "icon-back"), forState: UIControlState.Normal)
        self.backButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.backButton.layer.cornerRadius = 0.5 * self.backButton.frame.width
        self.menuView.addSubview(backButton)
        
        self.doneButton.frame = CGRectMake(self.trueWidth - 16 - 30, centerPoint - buttonWidth / 2, buttonWidth, buttonWidth)
        self.doneButton.backgroundColor = buttonColor
        self.doneButton.setTitle("D", forState: UIControlState.Normal)
        self.doneButton.addTarget(self, action: "pressDoneButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.doneButton.setImage(UIImage(named: "icon-done"), forState: UIControlState.Normal)
        self.doneButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.doneButton.layer.cornerRadius = 0.5 * self.doneButton.frame.width
        self.menuView.addSubview(doneButton)
        
        self.editButton.frame = CGRectMake(self.trueWidth - 46 - 20 - 30, centerPoint - buttonWidth / 2, buttonWidth, buttonWidth)
        self.editButton.backgroundColor = buttonColor
        self.editButton.setTitle("+", forState: UIControlState.Normal)
        self.editButton.addTarget(self, action: "pressEditButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.editButton.setImage(UIImage(named: "icon-add"), forState: UIControlState.Normal)
        self.editButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.editButton.layer.cornerRadius = 0.5 * self.editButton.frame.width
        self.menuView.addSubview(editButton)
        
        self.removeButton.frame = CGRectMake(self.trueWidth - 96 - 20 - 30, centerPoint - buttonWidth / 2, buttonWidth, buttonWidth)
        self.removeButton.backgroundColor = buttonColor
        self.removeButton.setTitle("-", forState: UIControlState.Normal)
        self.removeButton.addTarget(self, action: "pressRemoveButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.removeButton.layer.cornerRadius = 0.5 * self.editButton.frame.width
        self.removeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.menuView.addSubview(removeButton)
        
        self.previewButton.frame = CGRectMake(self.trueWidth - 146 - 20 - 70, centerPoint - buttonWidth / 2, 70, buttonWidth)
        self.previewButton.backgroundColor = buttonColor
        self.previewButton.setTitle("preview", forState: UIControlState.Normal)
        self.previewButton.addTarget(self, action: "pressPreviewButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.previewButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.previewButton.layer.cornerRadius = 0.1 * self.editButton.frame.width
        self.menuView.addSubview(previewButton)
        
        self.previousButton.frame = CGRectMake(self.trueWidth - 16 - 50, 0.575 * self.trueHeight - 50 - 16, 50, 50)
        self.previousButton.backgroundColor = buttonColor
        self.previousButton.setTitle("P", forState: UIControlState.Normal)
        self.previousButton.addTarget(self, action: "pressPreviousButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.previousButton.setImage(UIImage(named: "icon-back"), forState: UIControlState.Normal)
        self.previousButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.previousButton.layer.cornerRadius = 0.5 * self.previousButton.frame.width
        self.view.addSubview(previousButton)
        
        self.mainViewTitle.frame = CGRectMake(16 + 30 + 16, centerPoint - 15, 100, 30)
        self.mainViewTitle.text = "Song Name"
        self.menuView.addSubview(self.mainViewTitle)

    }
    
    func fretLocation() {
        var fretStartPoint = 0
        var fretWidth = self.trueWidth / 6
        var stringStartPont = 0
        var stringWidth = self.scrollView.frame.height / 7
        for var index = 0; index < 26; index++ {
            if index == 0 {
                var temp = CGFloat(fretStartPoint)
                self.fretsLocation.append(temp)
            } else {
                var temp = fretsLocation[index - 1] + fretWidth
                self.fretsLocation.append(temp)
            }
        }
    }
    
    func createStringView() {
        for var index = 0; index < 6; index++ {
            var labelHeight = 0.05 * self.trueHeight
            var width = 0.75 * self.trueHeight / 6
            var tempView: UIView = UIView()
            tempView.frame = CGRectMake(0, width * CGFloat(index), self.scrollView.contentSize.width, width)
            if index % 2 == 1 {
                tempView.backgroundColor = UIColor.redColor()
            } else {
                tempView.backgroundColor = UIColor.blueColor()
            }
            //tempView.addTarget(self, action: "pressStringView:", forControlEvents: UIControlEvents.TouchUpInside)
            tempView.tag = index
            stringViewEdit.append(tempView)
        }
        for var index = 0; index < 3; index++ {
            var labelHeight = 0.05 * self.trueHeight
            var width = 0.375 * self.trueHeight / 3
            var tempView: UIView = UIView()
            tempView.frame = CGRectMake(0, width * CGFloat(index), self.scrollView.contentSize.width, width)
            if index % 2 == 1 {
                tempView.backgroundColor = UIColor.redColor()
            } else {
                tempView.backgroundColor = UIColor.blueColor()
            }
            //tempView.addTarget(self, action: "pressStringView:", forControlEvents: UIControlEvents.TouchUpInside)
            tempView.tag = index
            stringViewNotEdit.append(tempView)
        }
    }
    
    func addStringView(sender: String) {
        if sender == "stringViewEdit" {
            for var index = 0; index < stringViewEdit.count; index++ {
                self.scrollView.addSubview(stringViewEdit[index])
            }
        }
        if sender == "stringViewNotEdit" {
            for var index = 0; index < stringViewNotEdit.count; index++ {
                self.scrollView.addSubview(stringViewNotEdit[index])
            }
        }
    }
    
    func removeStringView(sender: String) {
        if sender == "stringViewEdit" {
            for var index = 0; index < stringViewEdit.count; index++ {
                stringViewEdit[index].removeFromSuperview()
            }
        }
        if sender == "stringViewNotEdit" {
            for var index = 0; index < stringViewNotEdit.count; index++ {
                stringViewNotEdit[index].removeFromSuperview()
            }
        }
    }
    
    func createFretsLabel() {
        var labelWidth = 0.05 * self.trueHeight
        var width = self.trueWidth / 6
        for var index = 0; index < 25; index++ {
            var temp: UILabel = UILabel()
            temp.frame = CGRectMake(width / 2 + CGFloat(index) * width - labelWidth, 0, labelWidth * 2, labelWidth)
            temp.textAlignment = NSTextAlignment.Center
            temp.text = "\(index)"
            temp.textColor = UIColor.blackColor()
            tabNameLabelNotEdit.append(temp)
        }
    }
    
    func addFretsLabel(sender: String) {
//        if sender == "tabNameLabelEdit" {
//            for var index = 0; index < tabNameLabelEdit.count; index++ {
//                self.fretLabelView.addSubview(tabNameLabelEdit[index])
//            }
//        } else
        if sender == "tabNameLabelNotEdit" {
            for var index = 0; index < tabNameLabelNotEdit.count; index++ {
                self.fretLabelView.addSubview(tabNameLabelNotEdit[index])
            }
        }
    }
    
    func removeFretsLabel(sender: String) {
        if sender == "tabNameLabelEdit" {
            for var index = 0; index < tabNameLabelEdit.count; index++ {
                self.tabNameLabelEdit[index].removeFromSuperview()
            }
        } else if sender == "tabNameLabelNotEdit" {
            for var index = 0; index < tabNameLabelNotEdit.count; index++ {
                self.tabNameLabelNotEdit[index].removeFromSuperview()
            }
        }
    }
    
    func scrollViewSingleTapped(sender: UITapGestureRecognizer) {
        if self.editAvaliable == true {
            let location = sender.locationInView(self.scrollView)
            //println("\(location.x) + \(location.y)")
            for var index = 0; index < fretsLocation.count; index++ {
                if location.x < fretsLocation[fretsLocation.count - 2] {
                    if location.x > fretsLocation[index] && location.x < fretsLocation[index + 1] {
                        choosedNote.y = CGFloat(index)
                        break
                    }
                }
            }
            for var index = 0; index < 6; index++ {
                if CGRectContainsPoint(stringViewEdit[index].frame, location) {
                    //println("\(stringView[index].tag)")
                    choosedNote.x = CGFloat(stringViewEdit[index].tag)
                    if choosedNote.x > 2 {
                       //createNoteButton(FretsBoard.fretsBoard[Int(choosedNote.x)][Int(choosedNote.y)], position: choosedNote)
                        var temp = Int((choosedNote.x + 1) * 10000 + choosedNote.y * 100)
                        var indexPosition = NSNumber(integer: temp)
                        var dict: NSDictionary = core.getExistTab(indexPosition)
                        var note = dict.objectForKey("name") as! String
                        createNoteButton(note, position: choosedNote)
                        removeSpecificNoteButton()
                        addSpecificNoteButton(indexPosition)
                    }
                    else {
                        self.editViewTempNoteButton.removeFromSuperview()
                        removeSpecificNoteButton()
                    }
                    println("\(FretsBoard.fretsBoard[Int(choosedNote.x)][Int(choosedNote.y)])")
                    break
                }
            }

        }
    }
    
    
    func removeSpecificNoteButton() {
        for view in self.existTabScrollView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func addSpecificNoteButton(index: NSNumber) {
        for var i = 0; i < 25; i++ {
            var dict: NSDictionary = core.getExistTab(NSNumber(integer: (Int(index) + i)))
            if dict.count > 0 {
                if dict.objectForKey("content") as! String != "" {
                    var buttonWidth = 0.08 * self.trueHeight
                    var tempButton: UIButton = UIButton()
                    tempButton.frame = CGRectMake(CGFloat(i) * (buttonWidth + 5) * 1.5, 0.01 * self.trueHeight, buttonWidth * 1.5, buttonWidth)
                    tempButton.setTitle(dict.objectForKey("name") as? String, forState: UIControlState.Normal)
                    tempButton.layer.cornerRadius = 3
                    tempButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
                    tempButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    tempButton.tag = Int((dict.objectForKey("index") as! NSNumber))
                    tempButton.addTarget(self, action: "pressSpecificNoteButton:", forControlEvents: UIControlEvents.TouchUpInside)
                    self.existTabScrollView.addSubview(tempButton)
                }
            }
        }
    }
    
    func pressSpecificNoteButton(sender: UIButton) {
        if self.fingerPoint.count > 0 {
            for item in fingerPoint {
                item.removeFromSuperview()
            }
        }
        println("press specific note button")
        var index = sender.tag as NSNumber
        var dict = core.getExistTab(index)
        var content = dict.objectForKey("content") as! String
        addFingerPrint(index, content: content)
    }
    
    func addFingerPrint(index: NSNumber, content: String) {
        var stringNumber = Int(index) / 10000
        var buttonWidth = 0.08 * self.trueHeight
        var buttonX = fretsLocation[1] - buttonWidth / 2
        var buttonY = stringViewEdit[5].center.y - buttonWidth / 2
        for var i = 5; i >= 0; i-- {
            var charAtIndex = content[advance(content.startIndex, 5 - i)]
            var fingerButton: UIButton = UIButton()
            var image: UIImage = UIImage()
            if charAtIndex == "x" {
                buttonX = fretsLocation[1] - buttonWidth / 2
                image = UIImage(named: "blackX")!
            } else {
                var temp = String(charAtIndex).toInt()
                image = UIImage(named: "grayButton")!
                buttonX = fretsLocation[temp! + 1] - buttonWidth / 2
                buttonY = stringViewEdit[i].center.y - buttonWidth / 2
            }
            if i != stringNumber - 1 {
                fingerButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
                fingerButton.setBackgroundImage(image, forState: UIControlState.Normal)
                fingerButton.addTarget(self, action: "pressFingerButton", forControlEvents: UIControlEvents.TouchUpInside)
                fingerPoint.append(fingerButton)
                self.scrollView.addSubview(fingerButton)
            }
            
        }
    }
    
    func pressFingerButton(sender: UIButton) {
        println("press finger button")
    }
    
    func createNoteButton(name: String, position: CGPoint) {
        var buttonWidth = 0.1 * self.trueHeight
        var buttonX = (fretsLocation[Int(position.y)] + fretsLocation[Int(position.y) + 1]) / 2 - buttonWidth / 2
        var buttonY = stringViewEdit[Int(position.x)].center.y - buttonWidth / 2
        self.editViewTempNoteButton.alpha = 0
        self.editViewTempNoteButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
        self.editViewTempNoteButton.setTitle(name, forState: UIControlState.Normal)
        self.editViewTempNoteButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Normal)
        self.editViewTempNoteButton.addTarget(self, action: "pressEditViewTempNoteButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.editViewTempNoteButton.layer.borderWidth = 1
        var red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        self.editViewTempNoteButton.layer.borderColor = red.CGColor
        self.editViewTempNoteButton.layer.cornerRadius = 0.5 * buttonWidth
        self.editViewTempNoteButton.accessibilityIdentifier = "TempNoteButtonExist"
        self.scrollView.addSubview(editViewTempNoteButton)
        UIView.animateWithDuration(0.5, animations: {
            self.editViewTempNoteButton.alpha = 1
        })
    }
    
    func pressEditViewTempNoteButton(sender: UIButton) {
        sender.removeFromSuperview()
        removeSpecificNoteButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pressBackButton(sender: UIButton) {
        if self.editAvaliable == true {
            self.editAvaliable = false
            //self.guitarImage.image = UIImage(named: "3-strings")
            //addStringView("stringViewNotEdit")
            //removeStringView("stringViewEdit")
            //addFretsLabel("tabNameLabelNotEdit")
            //removeFretsLabel("tabNameLabelEdit")
            self.editViewTempNoteButton.removeFromSuperview()
            println("press Back Button")
            self.view.addSubview(self.previousButton)
            self.fretLabelView.frame = CGRectMake(0, 0.375 * trueHeight, self.scrollView.contentSize.width, 0.05 * self.trueHeight)
            self.fretLabelView.alpha = 0
            removeObjectOnEditView()
            removeStringView("stringViewEdit")
            UIView.animateWithDuration(0.3, animations: {
                self.fretLabelView.alpha = 1
                self.scrollView.frame = CGRectMake(0, self.trueHeight, self.trueWidth, -0.425 * self.trueHeight)
                self.editView.frame = CGRectMake(0, 0.08 * self.trueHeight, self.trueWidth, 0)
                self.guitarImage.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, 0.75 * self.trueHeight)
                self.previousButton.alpha = 1
                self.guitar3StringImage.alpha = 1
            })
            self.guitar3StringImage.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, 0.375 * self.trueHeight)
        }
    }

    func pressEditButton(sender: UIButton) {
        self.editAvaliable = true
//        addStringView("stringViewEdit")
//        removeStringView("stringViewNotEdit")
        //addFretsLabel("tabNameLabelEdit")
        //removeFretsLabel("tabNameLabelNotEdit")
        addObjectsOnEditView()
        self.editViewTempNoteButton.accessibilityIdentifier = "TempNoteButton"
        //self.guitarImage.image = UIImage(named: "6-strings")
        println("press Edit Button")
        self.fretLabelView.frame = CGRectMake(0, 0.75 * self.trueHeight, self.scrollView.contentSize.width, 0.05 * self.trueHeight)
        self.view.addSubview(editViewBackgroundImage)
        self.view.addSubview(editView)
        self.previousButton.removeFromSuperview()
        self.previousButton.alpha = 0
        UIView.animateWithDuration(0.3, animations: {
            self.guitar3StringImage.alpha = 0
            self.scrollView.frame = CGRectMake(0, 0.2 * self.trueHeight, self.trueWidth, 0.8 * self.trueHeight)
            self.editView.frame = CGRectMake(0, 0.08 * self.trueHeight, self.trueWidth, 0.02 * self.trueHeight)
            self.guitarImage.frame = CGRectMake(0, 0, self.scrollView.contentSize.width, 0.75 * self.trueHeight)
        })
        self.guitar3StringImage.frame = CGRectMake(0, 0.375 * self.scrollView.frame.height, self.scrollView.contentSize.width, 0.375 * self.trueHeight)
    }
    
    func pressDoneButton(sender: UIButton) {
        println("press Done Button")
    }
    
    func pressPreviousButton(sender: UIButton) {
        println("press Previous Button")
    }
    
    func pressPreviewButton(sender: UIButton) {
        println("press Preview Button")
    }
    
    func pressRemoveButton(sender: UIButton) {
        println("press Remove Button")
    }
    
    func pressNoteButton(sender: UIButton) {
        
    }
}

