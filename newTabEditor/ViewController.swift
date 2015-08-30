//
//  ViewController.swift
//  newTabEditor
//
//  Created by Jun Zhou on 8/10/15.
//  Copyright (c) 2015 Jun Zhou. All rights reserved.
//

import UIKit
import CoreData
import MediaPlayer
import AVFoundation

class ViewController: UIViewController{
    var core = coreData()
    
    // count down view
    var countDownView: UIView = UIView()
    var countDownLabelImage: UIImageView = UIImageView()
    var countDownNumber: Float = Float()
    var timer: NSTimer = NSTimer()
    var timer2: NSTimer = NSTimer()
    var duringCountDown: Bool = Bool()
    
    //control music fire and stop
    var tapNumber: Int =  Int()
    
    //add tab to music view
    var musicView: UIView = UIView()
    var progressBlock: SoundWaveView!
    var blueLine: UIView = UIView()
    var allLocalSong: [MPMediaItem]!
    var uniqueSong: MPMediaItem!
    var currentTime: NSTimeInterval = NSTimeInterval()
    //var player: MPMusicPlayerController = MPMusicPlayerController.systemMusicPlayer()
    var player: AVAudioPlayer = AVAudioPlayer()
    var duration: NSTimeInterval = NSTimeInterval()
    var persent: CGFloat = CGFloat()
    
    //first view
    var backgroundImage: UIImageView = UIImageView()
    var guitarImage: UIImageView = UIImageView()
    var editButton: UIButton = UIButton()
    var removeButton: UIButton = UIButton()
    var previewButton: UIButton = UIButton()
    var resetButton: UIButton = UIButton()
    var previousButton: UIButton = UIButton()
    var backButton: UIButton = UIButton()
    var doneButton: UIButton = UIButton()
    var editViewBackgroundImage: UIImageView = UIImageView()
    var mainViewTitle: UILabel = UILabel()
    var menuView: UIView = UIView()
    var fretLabelView: UIView = UIView()
    var mainTabButton: [UIButton] = [UIButton]()
    //var deleteButton: [UIButton] = [UIButton]()
    var mainStatusTitle: UILabel = UILabel()
    
    //edit view
    var guitar3StringImage: UIImageView = UIImageView()
    var addExistTabOnScrollView: Bool = Bool()
    var existTabScrollView: UIScrollView = UIScrollView()
    var newTabName: UITextField = UITextField()
    var editView: UIView = UIView()
    var scrollView: UIScrollView = UIScrollView()
    var tabNameLabelEdit: [UILabel] = [UILabel]()
    var tabNameLabelNotEdit: [UILabel] = [UILabel]()
    var editViewNotes: [UIButton] = [UIButton]() // exist button we have
    var editAvaliable: Bool = Bool()
    var choosedNote: CGPoint = CGPoint()
    var editViewTempNoteButton: UIButton = UIButton() // only exist on edit process
    var addTabAvaliable: Bool = Bool() // allow to add new tab
    var currentButton: UIButton = UIButton()
    var newTabButton: [UIButton] = [UIButton]()
    var ExistTabButton: [UIButton] = [UIButton]()
    var choosedSpecificTab: Bool = Bool()
    
    //string view
    var stringViewEdit: [UIView] = [UIView]()
    var stringViewNotEdit: [UIView] = [UIView]()
    var fretsLocation: [CGFloat] = [CGFloat]()
    var mainNoteButton: UIButton = UIButton() // add on the string
    var fingerPoint: [UIButton] = [UIButton]() // store all the finger button on the scroll view
    
    //edit finger point struct
    struct editFingerPointStruct {
        static var location: [Int] = [Int]()
        static var fingerButton: [UIButton] = [UIButton]()
    }
    
    //screen height and width
    var trueWidth: CGFloat = CGFloat()
    var trueHeight: CGFloat = CGFloat()
    
    //landscape screen
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
    
    //init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(animated: Bool) {
        self.player.stop()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        core.addDefaultData()
        //core.removeAllNewTabFromDatabase()
        core.printAllNewTab()
        
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
        self.menuView.backgroundColor = UIColor(patternImage: UIImage(named: "navigation-bar")!).colorWithAlphaComponent(0.6)
        self.view.addSubview(self.menuView)
        

        // add notes view
        editAvaliable = false
        addExistTabOnScrollView = false
        var fretLength = self.trueWidth / 6
        
        self.scrollView.frame = CGRectMake(0, self.trueHeight, self.trueWidth, -0.425 * self.trueHeight)
        self.scrollView.contentSize = CGSizeMake(25 * fretLength, 0.425 * self.trueHeight)
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
        
        self.currentButton.accessibilityIdentifier = "NoCurrentButton"
        
        //tap recongnizer
        var singleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewSingleTapped:")
        singleTapRecognizer.numberOfTapsRequired = 1
        singleTapRecognizer.numberOfTouchesRequired = 1
        self.scrollView.addGestureRecognizer(singleTapRecognizer)
        
        //tap recongnizer
        self.tapNumber = 0
        var musicSingleTapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "singleTapOnMusicView:")
        musicSingleTapRecognizer.numberOfTapsRequired = 1
        musicSingleTapRecognizer.numberOfTouchesRequired = 1
        self.progressBlock.addGestureRecognizer(musicSingleTapRecognizer)
        
        //music play
        loadLocalSongs()
        var url: NSURL = allLocalSong[0].valueForProperty(MPMediaItemPropertyAssetURL) as! NSURL
        self.player = AVAudioPlayer(contentsOfURL: url, error: nil)
        self.duration = self.player.duration
        self.player.volume = 1
        //self.mainViewTitle.text = allLocalSong[0].title
        //self.menuView.addSubview(self.mainViewTitle)
    }
    
    func loadLocalSongs(){
        var songCollection = MPMediaQuery.songsQuery()
        self.allLocalSong = (songCollection.items as! [MPMediaItem]).filter({song in song.playbackDuration > 30 })
    }
    
    // objects on edit view
    func addObjectsOnEditView() {
        if editAvaliable == true {
            self.newTabName.frame = CGRectMake(0.82 * self.trueWidth, 0.09 * self.trueHeight, 0.17 * self.trueWidth, 0.1 * self.trueHeight)
            self.newTabName.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            self.newTabName.layer.cornerRadius = 0.4
            self.newTabName.autocorrectionType = UITextAutocorrectionType.No
            self.existTabScrollView.frame = CGRectMake(0.01 * self.trueWidth, 0.09 * self.trueHeight, 0.55 * self.trueWidth, 0.1 * self.trueHeight)
            self.existTabScrollView.contentSize = CGSizeMake(1 * self.trueWidth, 0.1 * self.trueHeight)
            self.existTabScrollView.backgroundColor = UIColor.brownColor().colorWithAlphaComponent(0.6)
            self.existTabScrollView.alpha = 0
            self.view.addSubview(self.existTabScrollView)
            self.view.addSubview(self.newTabName)
           // self.view.addSubview(self.newTabSwitch)
            UIView.animateWithDuration(0.5, animations: {
              //  self.newTabSwitch.alpha = 1
                self.newTabName.alpha = 0.6
                self.existTabScrollView.alpha = 0.6
            })
        }
    }
    func removeObjectOnEditView() {
        if self.editAvaliable == false {
            newTabName.removeFromSuperview()
           // newTabSwitch.removeFromSuperview()
            existTabScrollView.removeFromSuperview()
        }
        if self.addExistTabOnScrollView == true {
            for views in self.existTabScrollView.subviews {
                views.removeFromSuperview()
            }
        }
    }
    
    // objects on main view
    func singleTapOnMusicView(sender: UITapGestureRecognizer) {
        if self.duringCountDown == false {
            self.duringCountDown = true
            if self.tapNumber % 2 == 0 {
                self.countDownLabelImage.image = UIImage(named: "countdown-timer-3")
                self.countDownNumber = 0
                self.timer2 = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("countDownThree"), userInfo: nil, repeats: true)
            } else {
                self.duringCountDown = false
                self.player.stop()
                self.timer.invalidate()
            }
            self.tapNumber++
        }
    }
    
    func update() {
        self.currentTime = player.currentTime
        self.persent = CGFloat(self.currentTime / self.duration)
        progressBlock.setProgress(self.persent)
        progressBlock.frame = CGRectMake(0.667 * self.trueWidth - self.persent * (4 * self.trueWidth), 0, 4 * self.trueWidth, 0.4 * self.trueHeight)
    }
    
    func countDownThree() {
        if self.countDownNumber == 0.1 {
            self.view.addSubview(self.countDownView)
        } else if self.countDownNumber >= 0.9 && self.countDownNumber <= 1.0 {
            self.countDownLabelImage.image = UIImage(named: "countdown-timer-2")
        } else if self.countDownNumber >= 1.9 && self.countDownNumber <= 2.0 {
            self.countDownLabelImage.image = UIImage(named: "countdown-timer-1")
        } else if self.countDownNumber > 2.5{
            println("\(self.countDownNumber)")
            timer2.invalidate()
            self.duringCountDown = false
            self.countDownView.removeFromSuperview()
            self.player.currentTime = self.currentTime
            self.player.play()
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.2, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
           // NSRunLoop.mainRunLoop().addTimer(self.timer, forMode: NSRunLoopCommonModes)
        }
        self.countDownNumber = self.countDownNumber + 0.1
    }
    
    func pressResetButton(sender: UIButton) {
        let alertController = UIAlertController(title: "Reset Editing", message: "Are you sure you want to reset editing?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,handler: {
            (action: UIAlertAction!) in
            self.player.currentTime = 0
            for item in self.allTabsOnMusicLine {
                item.tab.removeFromSuperview()
            }
            self.allTabsOnMusicLine.removeAll(keepCapacity: false)
        }))
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func addObjectsOnMainView() {
        self.duringCountDown = false
        self.choosedSpecificTab = false
        
        var labelWidth = 0.3 * self.trueHeight
        var labelImageView: UIImageView = UIImageView()
        labelImageView.frame = CGRectMake(0, 0, labelWidth, labelWidth)
        labelImageView.layer.cornerRadius = 0.5 * labelWidth
        labelImageView.image = UIImage(named: "countdown-timer")
        labelImageView.alpha = 0.6
        self.countDownView.addSubview(labelImageView)
        
        self.countDownView.frame = CGRectMake(self.trueWidth / 2 - labelWidth / 2, self.trueHeight / 2 - labelWidth, labelWidth, labelWidth)
        self.countDownView.backgroundColor = UIColor(patternImage: UIImage(named: "countdown-timer")!)//.colorWithAlphaComponent(0.6)
        self.countDownView.layer.cornerRadius = 0.5 * labelWidth
        
        self.countDownLabelImage.frame = CGRectMake(0, 0, labelWidth, labelWidth)
        self.countDownLabelImage.image = UIImage(named: "countdown-timer-3")
        self.countDownLabelImage.layer.cornerRadius = 0.5 * labelWidth
        self.countDownLabelImage.backgroundColor = UIColor.clearColor()
        self.countDownView.addSubview(self.countDownLabelImage)
        self.countDownNumber = 0
        
        //music paly
        self.musicView.frame = CGRectMake(0, 0.1 * self.trueHeight, self.trueWidth, 0.45 * self.trueHeight)
        self.view.addSubview(self.musicView)
        createSoundWave()
        progressBlock.setProgress(CGFloat(0))
        self.musicView.addSubview(self.progressBlock)
        
        self.blueLine.frame = CGRectMake(0.667 * self.trueWidth, 0, 2, 0.2 * self.trueHeight)
        self.blueLine.backgroundColor = UIColor.blueColor()
        self.musicView.addSubview(self.blueLine)
        
        
        // control button
        var buttonColor = UIColor.clearColor()
        var buttonWidth = 0.15 * self.trueHeight
        var centerPoint = 0.08 * self.trueHeight / 2
        self.backButton.frame = CGRectMake(0, centerPoint - buttonWidth / 4, buttonWidth, buttonWidth / 2)
        self.backButton.backgroundColor = buttonColor
        //self.backButton.setTitle("B", forState: UIControlState.Normal)
        self.backButton.addTarget(self, action: "pressBackButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.backButton.setImage(UIImage(named: "icon-back"), forState: UIControlState.Normal)
        self.backButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        self.backButton.layer.cornerRadius = 0.5 * self.backButton.frame.width
        self.menuView.addSubview(backButton)
        
        self.doneButton.frame = CGRectMake(self.trueWidth - 0.015 * self.trueWidth - buttonWidth, centerPoint - buttonWidth / 4, buttonWidth, buttonWidth / 2)
        self.doneButton.backgroundColor = buttonColor
        //self.doneButton.setTitle("D", forState: UIControlState.Normal)
        self.doneButton.addTarget(self, action: "pressDoneButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.doneButton.setImage(UIImage(named: "icon-done"), forState: UIControlState.Normal)
        self.doneButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        self.doneButton.layer.cornerRadius = 0.5 * self.doneButton.frame.width
        self.menuView.addSubview(doneButton)
        
        self.editButton.frame = CGRectMake(self.trueWidth - 2 * (0.015 * self.trueWidth + buttonWidth), centerPoint - buttonWidth / 4, buttonWidth, buttonWidth / 2)
        self.editButton.backgroundColor = buttonColor
        //self.editButton.setTitle("+", forState: UIControlState.Normal)
        self.editButton.addTarget(self, action: "pressEditButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.editButton.setImage(UIImage(named: "icon-add"), forState: UIControlState.Normal)
        self.editButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        self.editButton.layer.cornerRadius = 0.5 * self.editButton.frame.width
        self.menuView.addSubview(editButton)
        
        self.removeButton.frame = CGRectMake(self.trueWidth - 3 * (0.015 * self.trueWidth + buttonWidth), centerPoint - buttonWidth / 4, buttonWidth, buttonWidth / 2)
        self.removeButton.backgroundColor = buttonColor
        //self.removeButton.setTitle("-", forState: UIControlState.Normal)
        self.removeButton.addTarget(self, action: "pressRemoveButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.removeButton.setImage(UIImage(named: "icon-delete"), forState: UIControlState.Normal)
//        self.removeButton.layer.cornerRadius = 0.5 * self.editButton.frame.width
        self.removeButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        self.menuView.addSubview(removeButton)
        
        self.resetButton.frame = CGRectMake(self.trueWidth - 4 * (0.015 * self.trueWidth + buttonWidth) - 10, centerPoint - buttonWidth / 4, buttonWidth + 10, buttonWidth / 2)
        self.resetButton.backgroundColor = buttonColor
        self.resetButton.setTitle("reset", forState: UIControlState.Normal)
        self.resetButton.addTarget(self, action: "pressResetButton:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.resetButton.layer.cornerRadius = 0.5 * self.editButton.frame.width
        self.menuView.addSubview(resetButton)
        
        self.previewButton.frame = CGRectMake(self.trueWidth - 5 * (0.015 * self.trueWidth + buttonWidth) - 50, centerPoint - buttonWidth / 4, 70, buttonWidth / 2)
        self.previewButton.backgroundColor = buttonColor
        self.previewButton.setTitle("preview", forState: UIControlState.Normal)
        self.previewButton.addTarget(self, action: "pressPreviewButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.previewButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        self.previewButton.layer.cornerRadius = 0.1 * self.editButton.frame.width
        self.menuView.addSubview(previewButton)
        
        self.previousButton.frame = CGRectMake(self.trueWidth - 16 - 50, 0.575 * self.trueHeight - 50 - 16, 50, 50)
        self.previousButton.backgroundColor = buttonColor
        //self.previousButton.setTitle("P", forState: UIControlState.Normal)
        self.previousButton.addTarget(self, action: "pressPreviousButton:", forControlEvents: UIControlEvents.TouchUpInside)
        self.previousButton.setImage(UIImage(named: "icon-back"), forState: UIControlState.Normal)
        self.previousButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
//        self.previousButton.layer.cornerRadius = 0.5 * self.previousButton.frame.width
        self.view.addSubview(previousButton)
        
        self.mainViewTitle.frame = CGRectMake(buttonWidth + 0.01 * self.trueHeight, centerPoint - buttonWidth / 4, 100, 30)
        //test
        self.mainViewTitle.text = "Song Name"
        //real

        
        self.mainStatusTitle.frame = CGRectMake(buttonWidth + 0.01 * self.trueHeight, centerPoint - buttonWidth / 2, 150, buttonWidth)
        self.mainStatusTitle.textAlignment = NSTextAlignment.Center
        self.mainStatusTitle.text = "Tab Editor"
        self.mainStatusTitle.backgroundColor = buttonColor
        self.menuView.addSubview(self.mainStatusTitle)
    }
    
    // all fret location
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
    
    // all string view
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
    
    // scroll view single tap
    func scrollViewSingleTapped(sender: UITapGestureRecognizer) {
        self.deleteButtonPressed = false
        changeDeleteButtonStatus(self.removeButton, back: true)
        if self.editAvaliable == true {
            let location = sender.locationInView(self.scrollView)
            for var index = 0; index < fretsLocation.count; index++ {
                if location.x < fretsLocation[fretsLocation.count - 2] {
                    if location.x > fretsLocation[index] && location.x < fretsLocation[index + 1] {
                        choosedNote.y = CGFloat(index)
                        break
                    }
                }
            }
            for var index = 0; index < 6; index++ {
                if self.addTabAvaliable == false {  // not add new tab
                    if CGRectContainsPoint(stringViewEdit[index].frame, location) {
                        choosedNote.x = CGFloat(stringViewEdit[index].tag)
                        if choosedNote.x > 2 && self.choosedSpecificTab == false {
                            var temp = Int((choosedNote.x + 1) * 10000 + choosedNote.y * 100)
                            var temp2 = Int((choosedNote.x + 1) * 100 + choosedNote.y)
                            var indexPosition = NSNumber(integer: temp)
                            var dict: NSDictionary = core.getExistTab(indexPosition)
                            var note = dict.objectForKey("name") as! String
                            createNoteButton(note, position: choosedNote)
                            removeSpecificNoteButton()
                            removeFingerPoint()
                            removeEditFingerButton()
                            self.addTabAvaliable = true
                            var count = addSpecificNoteButton(indexPosition)
                            addNewSpecificNoteButton("\(temp2)", count: count)
                            createEditFingerButton(Int(choosedNote.x))
                        } else if self.choosedSpecificTab == true {
                            moveExistFingerPointButton(choosedNote)
                        } else {
                            self.editViewTempNoteButton.removeFromSuperview()
                            removeSpecificNoteButton()
                            removeFingerPoint()
                            removeEditFingerButton()
                            moveEditFingerPointButton(choosedNote)
                        }
                        break
                    }
                } else {
                    if CGRectContainsPoint(stringViewEdit[index].frame, location) {
                        choosedNote.x = CGFloat(stringViewEdit[index].tag)
                        moveEditFingerPointButton(choosedNote)
                    }
                }
            }

        }
    }
    
    //change the exist finger point position
    func moveExistFingerPointButton(sender: CGPoint) {
        for item in self.fingerPoint {
            var indexString = item.tag / 100 - 1
            var indexFret = item.tag - indexString * 100
            var senderString = Int(sender.x)
            var senderFret = Int(sender.y)
            if indexString == senderString {
                var buttonWidth = 0.08 * self.trueHeight
                var buttonX = (fretsLocation[senderFret] + fretsLocation[senderFret + 1]) / 2 - buttonWidth / 2
                var buttonY = stringViewEdit[senderString].center.y - buttonWidth / 2
                item.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
                item.alpha = 0
                UIView.animateWithDuration(0.5, animations: {
                    item.alpha = 1
                })

            }
        }
    }
    func pressFingerButton(sender: UIButton) {
        if sender.accessibilityIdentifier == "blackX" {
            sender.accessibilityIdentifier = "grayButton"
            sender.setImage(UIImage(named: "grayButton"), forState: UIControlState.Normal)
        } else {
            sender.accessibilityIdentifier = "blackX"
            sender.setImage(UIImage(named: "blackX"), forState: UIControlState.Normal)
        }
    }
    
    
    // specific note button
    func removeSpecificNoteButton() {
        for view in self.existTabScrollView.subviews {
            view.removeFromSuperview()
        }
    }
    func addSpecificNoteButton(index: NSNumber) -> Int {
        self.ExistTabButton.removeAll(keepCapacity: false)
        var count = 0
        for var i = 0; i < 4; i++ {
            var dict: NSDictionary = core.getExistTab(NSNumber(integer: (Int(index) + i)))
            if dict.count > 0 {
                if dict.objectForKey("content") as! String != "" {
                    count++
                    var buttonWidth = 0.08 * self.trueHeight
                    var tempButton: UIButton = UIButton()
                    tempButton.frame = CGRectMake(CGFloat(i) * (buttonWidth + 5) * 1.5 + 0.01 * self.trueWidth, 0.01 * self.trueHeight, buttonWidth * 1.5, buttonWidth)
                    tempButton.setTitle(dict.objectForKey("name") as? String, forState: UIControlState.Normal)
                    tempButton.layer.cornerRadius = 3
                    tempButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
                    tempButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                    tempButton.titleLabel?.adjustsFontSizeToFitWidth = true
                    tempButton.titleLabel?.minimumScaleFactor = 0.5
                    tempButton.tag = Int((dict.objectForKey("index") as! NSNumber))
                    tempButton.addTarget(self, action: "pressSpecificNoteButton:", forControlEvents: UIControlEvents.TouchUpInside)
                    self.ExistTabButton.append(tempButton)
                    self.existTabScrollView.addSubview(tempButton)
                }
            }
        }
        return count
    }
    func pressSpecificNoteButton(sender: UIButton) {
        removeFingerPoint()
        removeEditFingerButton()
        self.choosedSpecificTab = true
        if self.deleteButtonPressed == false {
            changeButtonStatus(sender)
            println("press specific note button")
            var index = sender.tag as NSNumber
            var dict = core.getExistTab(index)
            var content = dict.objectForKey("content") as! String
            self.addTabAvaliable = false
            addFingerPoint(index, content: content)
        } else {
            let alertController = UIAlertController(title: "Delete Warning", message: "Cannot delete built-in tabs", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            changeDeleteButtonStatus(self.removeButton, back: true)
        }
    }
    func changeButtonStatus(sender: UIButton) {
        if self.currentButton.accessibilityIdentifier == "NoCurrentButton" {
            self.currentButton = sender
        } else {
            if self.currentButton != sender {
                self.currentButton.backgroundColor = UIColor.blackColor()
                self.currentButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                self.currentButton = sender
            }
        }
        self.currentButton.accessibilityIdentifier = "HaveCurrentButton"
        self.currentButton.backgroundColor = UIColor.whiteColor()
        self.currentButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    func addNewSpecificNoteButton(index: String, count: Int) {
        self.newTabButton.removeAll(keepCapacity: false)
        var dict: [NSDictionary] = core.getExistNewTab(index)
        if dict.count > 0 {
            for var i = 0; i < dict.count; i++ {
                var buttonWidth = 0.08 * self.trueHeight
                var tempButton: UIButton = UIButton()
                tempButton.frame = CGRectMake(CGFloat(i + count) * (buttonWidth + 5) * 1.5 + 0.01 * self.trueWidth, 0.01 * self.trueHeight, buttonWidth * 1.5, buttonWidth)
                tempButton.setTitle(dict[i].objectForKey("name") as? String, forState: UIControlState.Normal)
                tempButton.layer.cornerRadius = 3
                tempButton.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
                tempButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                tempButton.tag = ((dict[i].objectForKey("index") as! String)).toInt()!
                tempButton.titleLabel?.adjustsFontSizeToFitWidth = true
                tempButton.titleLabel?.minimumScaleFactor = 0.5
                tempButton.addTarget(self, action: "pressNewSpecificNoteButton:", forControlEvents: UIControlEvents.TouchUpInside)
                self.newTabButton.append(tempButton)
                self.existTabScrollView.addSubview(tempButton)
            }
        }
    }
    func pressNewSpecificNoteButton(sender: UIButton) {
        removeFingerPoint()
        removeEditFingerButton()
        self.choosedSpecificTab = true
        println("press specific new note button")
        if self.deleteButtonPressed == false {
            changeButtonStatus(sender)
            var name: String = sender.titleLabel!.text!
            var index: String = "\(sender.tag)"
            var dict = core.getExistNewTabWithName(index, name: name)
            var content: String = dict.objectForKey("content") as! String
            self.addTabAvaliable = false
            var tempIndex = NSNumber(integer: index.toInt()!)
            addFingerPoint(tempIndex, content: content)
        } else {
            sender.removeFromSuperview()
            var count = 0
            for item in self.newTabButton {
                if item == sender {
                    var name = sender.titleLabel?.text
                    core.removeExistNewTab("\(sender.tag)", name: name!)
                    self.newTabButton.removeAtIndex(count)
                    break
                }
                count++
            }
            count = 0
            for item in self.mainTabButton {
                if item.titleLabel?.text == sender.titleLabel?.text && item.tag + 100 == sender.tag {
                    self.mainTabButton.removeAtIndex(count)
                    break
                }
                count++
            }
            changeDeleteButtonStatus(self.removeButton, back: true)
        }
    }
    struct existTabFingerPoint {
        static var location: [Int] = [Int]()
        static var content: [String] = [String]()
    }
    // finger point
    func addFingerPoint(index: NSNumber, content: String) {
        var stringNumber: Int = Int()
        if Int(index) >= 10000 {
            stringNumber = Int(index) / 10000
        } else {
            stringNumber = Int(index) / 100
        }
        var buttonWidth = 0.08 * self.trueHeight
        var buttonX = fretsLocation[1] - buttonWidth / 2
        var buttonY = stringViewEdit[5].center.y - buttonWidth / 2
        for var i = 11; i >= 0; i = i - 2 {
            let index = advance(content.startIndex, 11 - i)
            let endIndex = advance(content.startIndex, 11 - i + 2)
            var charAtIndex = content[Range(start: index, end: endIndex)]
            var fingerButton: UIButton = UIButton()
            var image: UIImage = UIImage()
            var temp: Int = Int()
            if charAtIndex == "xx" {
                temp = 1
                buttonX = fretsLocation[1] - buttonWidth / 2
                buttonY = stringViewEdit[i / 2].center.y - buttonWidth / 2
                image = UIImage(named: "blackX")!
                fingerButton.accessibilityIdentifier = "blackX"
            } else {
                temp = String(charAtIndex).toInt()!
                image = UIImage(named: "grayButton")!
                buttonX = (fretsLocation[temp] + fretsLocation[temp + 1]) / 2 - buttonWidth / 2
                buttonY = stringViewEdit[i / 2].center.y - buttonWidth / 2
                fingerButton.accessibilityIdentifier = "grayButton"
            }
            fingerButton.addTarget(self, action: "pressEditFingerButton:", forControlEvents: UIControlEvents.TouchUpInside)
            if i / 2 != stringNumber - 1 {
                fingerButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
                fingerButton.setImage(image, forState: UIControlState.Normal)
                fingerButton.alpha = 0
                fingerButton.tag = (i / 2 + 1) * 100 + temp
                fingerPoint.append(fingerButton)// store all the finger point for exist tabs
                UIView.animateWithDuration(0.5, animations: {
                    fingerButton.alpha = 1
                })
                self.scrollView.addSubview(fingerButton)
            }
        }
    }
    func removeFingerPoint() {
        for item in self.fingerPoint {
            item.removeFromSuperview()
        }
    }

    // temp note button
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
        self.editViewTempNoteButton.tag = Int(position.x) * 100 + Int(position.y)
        self.editViewTempNoteButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.editViewTempNoteButton.titleLabel?.minimumScaleFactor = 0.5
        self.scrollView.addSubview(editViewTempNoteButton)
        UIView.animateWithDuration(0.5, animations: {
            self.editViewTempNoteButton.alpha = 1
        })
    }
    func pressEditViewTempNoteButton(sender: UIButton) {
        sender.removeFromSuperview()
        removeSpecificNoteButton()
        removeFingerPoint()
        removeEditFingerButton()
        self.addTabAvaliable = false
        self.choosedSpecificTab = false
        println("press edit view temp note button")
    }
    
    // edit tab finger and add new tab
    func createEditFingerButton(index: Int) {
        if addTabAvaliable == true {
            removeEditFingerButton()
            var buttonWidth = 0.08 * self.trueHeight
            var buttonX = (fretsLocation[0] + fretsLocation[1]) / 2 - buttonWidth / 2
            for var i = 0; i < 6; i++ {
                var buttonY = stringViewEdit[i].center.y - buttonWidth / 2
                var tempButton: UIButton = UIButton()
                tempButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
                tempButton.addTarget(self, action: "pressEditFingerButton:", forControlEvents: UIControlEvents.TouchUpInside)
                tempButton.setImage(UIImage(named: "grayButton"), forState: UIControlState.Normal)
                tempButton.accessibilityIdentifier = "grayButton"
                tempButton.alpha = 0
                if i < index {
                    self.scrollView.addSubview(tempButton)
                }
                UIView.animateWithDuration(0.5, animations: {
                    tempButton.alpha = 1
                })
                editFingerPointStruct.fingerButton.append(tempButton)
                editFingerPointStruct.location.append(0)
            }
        }
    }
    func removeEditFingerButton() {
        for item in editFingerPointStruct.fingerButton {
            if item.superview != nil {
                item.removeFromSuperview()
            }
        }
        editFingerPointStruct.fingerButton.removeAll(keepCapacity: false)
        editFingerPointStruct.location.removeAll(keepCapacity: false)
        
        
    }
    func moveEditFingerPointButton(position: CGPoint) {
        if editFingerPointStruct.location.count > 0 {
            var buttonWidth = 0.08 * self.trueHeight
            var buttonX = (fretsLocation[Int(position.y)] + fretsLocation[Int(position.y) + 1]) / 2 - buttonWidth / 2
            var buttonY = stringViewEdit[Int(position.x)].center.y - buttonWidth / 2
            var location = Int(choosedNote.y)
            editFingerPointStruct.location[Int(choosedNote.x)] = location
            editFingerPointStruct.fingerButton[Int(choosedNote.x)].frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
            editFingerPointStruct.fingerButton[Int(choosedNote.x)].alpha = 0
            UIView.animateWithDuration(0.5, animations: {
                editFingerPointStruct.fingerButton[Int(self.choosedNote.x)].alpha = 1
            })
        }
    }
    func pressEditFingerButton(sender: UIButton) {
        println("press finger button")
        if sender.accessibilityIdentifier == "grayButton" {
            sender.accessibilityIdentifier = "blackX"

            sender.setImage(UIImage(named: "blackX"), forState: UIControlState.Normal)
        } else {
            sender.accessibilityIdentifier = "grayButton"
            sender.setImage(UIImage(named: "grayButton"), forState: UIControlState.Normal)
        }
    }
    
    // back button
    func pressBackButton(sender: UIButton) {
        println("press back button")
        self.deleteButtonPressed = false
        changeDeleteButtonStatus(self.removeButton, back: true)
        if editAvaliable == true {
            backToMainView()
            addMainTabButton()
        }
        
    }
    func backToMainView() {
        self.choosedSpecificTab = false
        self.editAvaliable = false
        self.addTabAvaliable = false
        self.newTabName.text = ""
        self.mainStatusTitle.text = "Tab Editor"
        self.view.addSubview(self.musicView)
        removeSpecificNoteButton()
        removeFingerPoint()
        removeEditFingerButton()
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
    
    //edit button
    func pressEditButton(sender: UIButton) {
        self.player.stop()
        self.timer.invalidate()
        self.deleteButtonPressed = false
        changeDeleteButtonStatus(self.removeButton, back: true)
        self.mainStatusTitle.text = "Add New Tab"
        if self.editAvaliable == false {
            removeMainTabButton()
            self.editAvaliable = true
            addObjectsOnEditView()
            self.editViewTempNoteButton.accessibilityIdentifier = "TempNoteButtonNotExist"
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
    }
    
    // done button
    func pressDoneButton(sender: UIButton) {
        if editAvaliable == true && deleteButtonPressed == false {
            println("press Done Button")
            if editViewTempNoteButton.accessibilityIdentifier == "TempNoteButtonExist" {
                
                if addTabAvaliable == true {
                    if  self.newTabName.text == "" {
                        let alertController = UIAlertController(title: "Add Warning", message:
                            "Please input the Name for the new Tab", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                    } else {
                        var tempButton = createMainTabButton(self.newTabName.text)
                        addNewTabToDatabase(tempButton.tag + 100, name: self.newTabName.text)
                        mainTabButton.append(tempButton)
                        editAvaliable = false
                        backToMainView()
                        addMainTabButton()
                    }
                } else {
                    var name = self.currentButton.titleLabel?.text
                    var tempButton = createMainTabButton(name!)
                    mainTabButton.append(tempButton)
                    editAvaliable = false
                    backToMainView()
                    addMainTabButton()
                }
            }
        } else {
            editAvaliable = false
            self.deleteButtonPressed = false
            changeDeleteButtonStatus(self.removeButton, back: true)
            backToMainView()
            addMainTabButton()
        }
    }
    
    func reorganizeMainTabButton(sender: [UIButton]) {
        // temperary store repeated button
        var tempRepeatedButtonIndex: [Int] = [Int]()
        // store finished button index
        var repeatedButtonIndex: [Int] = [Int]()
        
        for var i = 0; i < sender.count; i++ {
            if contains(repeatedButtonIndex, i) == false {
                tempRepeatedButtonIndex.append(i)
                repeatedButtonIndex.append(i)
                var fullName = sender[i].tag
                var name = fullName
                if name > 10000 {
                    name = name / 100
                }
                var repeatNumber = 1
                // find the tab in the same fret
                for var j = i + 1; j < sender.count; j++ {
                    var fullName2 = sender[j].tag
                    var name2 = fullName2
                    if name2 > 10000 {
                        name2 = name2 / 100
                    }
                    if name == name2 {
                        repeatNumber++
                        tempRepeatedButtonIndex.append(j)
                        repeatedButtonIndex.append(j)
                    }
                }
                // deal with the button position
                var buttonWidth = 0.1 * self.trueHeight
                if tempRepeatedButtonIndex.count == 2 {
                    buttonWidth = 0.09 * self.trueHeight
                } else if tempRepeatedButtonIndex.count >= 3 {
                    buttonWidth = 0.07 * self.trueHeight
                }
                var rrr = repeatNumber + 1
                if repeatNumber >= 3 {
                    rrr = 4
                }
                for var k = 0; k < tempRepeatedButtonIndex.count; k++ {
                    if k < 3 {
                        var frameWidth = self.trueWidth / CGFloat(6) / CGFloat(rrr)
                        var py = name / 100
                        var px = name - py * 100
                        var buttonX = fretsLocation[px] + CGFloat(k + 1) * frameWidth - buttonWidth / 2
                        var buttonY = stringViewEdit[py - 3].center.y - buttonWidth / 2
                        var index = tempRepeatedButtonIndex[k]
                        sender[index].frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
                        sender[index].layer.cornerRadius = 0.5 * buttonWidth
                        sender[index].titleLabel?.adjustsFontSizeToFitWidth = true
                        sender[index].titleLabel?.minimumScaleFactor = 0.5
                    } else {
                        let alertController = UIAlertController(title: "Warning", message:
                            "Cannot add four tabs in one fret", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                        self.presentViewController(alertController, animated: true, completion: nil)
                        sender[tempRepeatedButtonIndex[k]].removeFromSuperview()
                        mainTabButton.removeAtIndex(tempRepeatedButtonIndex[k])
                    }
                    
                }
                tempRepeatedButtonIndex.removeAll(keepCapacity: false)
            }
        }
    }
    
    func createMainTabButton(name: String) -> UIButton {
        var title: String = String()
        if count(name) > 3 {
            let index = advance(name.startIndex, 0)
            let endIndex = advance(name.startIndex, 3)
            title = name[Range(start: index, end: endIndex)]
        } else {
            title = name
        }
        var tempButton: UIButton = UIButton()
        tempButton.tag = self.editViewTempNoteButton.tag
        var buttonWidth = 0.1 * self.trueHeight
        var buttonY = stringViewNotEdit[tempButton.tag / 100 - 3].center.y - buttonWidth / 2
        var y = tempButton.tag - tempButton.tag / 100 * 100
        var buttonX = (fretsLocation[y] + fretsLocation[y + 1]) / 2 - buttonWidth / 2
        tempButton.frame = CGRectMake(buttonX, buttonY, buttonWidth, buttonWidth)
        tempButton.addTarget(self, action: "pressMainTabButton:", forControlEvents: UIControlEvents.TouchUpInside)
        tempButton.setTitle(title, forState: UIControlState.Normal)
        tempButton.layer.borderWidth = 1
        var red = UIColor(red: 100.0/255.0, green: 130.0/255.0, blue: 230.0/255.0, alpha: 1.0)
        tempButton.layer.borderColor = red.CGColor
        tempButton.layer.cornerRadius = 0.5 * tempButton.frame.width
        tempButton.titleLabel?.adjustsFontSizeToFitWidth = true
        tempButton.titleLabel?.minimumScaleFactor = 0.5
        return tempButton
    }
    
    func addNewTabToDatabase(position: Int, name: String) {
        var index = "\(position)"
        var content: String = String()
        for var i = 6; i >= 1; i-- {
            if i < (position / 100) {
                if editFingerPointStruct.location[i] < 10 {
                    content += "0\(editFingerPointStruct.location[i - 1])"
                } else {
                    content += "\(editFingerPointStruct.location[i - 1])"
                }
            } else if i == (position / 100) {
                if position % 100 < 10 {
                    content += "0\(position % 100)"
                } else {
                    content += "\(position % 100)"
                }
            } else {
                content += "xx"
            }
        }
        core.addNewTab(index, name: name, content: content)
    }
    
    func addMainTabButton() {
        for item in mainTabButton {
            self.scrollView.addSubview(item)
        }
        reorganizeMainTabButton(self.mainTabButton)
    }
    
    func removeMainTabButton() {
        self.musicView.removeFromSuperview()
        for item in mainTabButton {
            item.removeFromSuperview()
        }
    }
    
    func pressPreviousButton(sender: UIButton) {
        println("press Previous Button")
        if self.allTabsOnMusicLine.count > 1 {
            self.allTabsOnMusicLine.last?.tab.removeFromSuperview()
            self.allTabsOnMusicLine.removeLast()
            var previousTime = self.allTabsOnMusicLine.last?.time
            self.player.currentTime = previousTime!
        } else if self.allTabsOnMusicLine.count == 1 {
            self.allTabsOnMusicLine.last?.tab.removeFromSuperview()
            self.allTabsOnMusicLine.removeLast()
            self.player.currentTime = 0
        }else {
            self.player.currentTime = 0
        }
        
    }
    
    func pressPreviewButton(sender: UIButton) {
        println("press Preview Button")
        
    }
    
    // delete tabs
    struct tabButtonWithDeleteButton {
        var tabButton: UIButton = UIButton()
        var deleteButton: UIButton = UIButton()
    }
    var deleteButtonPressed: Bool = false
    
    func pressRemoveButton(sender: UIButton) {
        if deleteButtonPressed == false {
            deleteButtonPressed = true
            changeDeleteButtonStatus(sender, back: false)
            if editAvaliable == true {
                removeFingerPoint()
                removeEditFingerButton()
                for item in self.newTabButton {
                    item.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
                    item.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                }
                for item in self.ExistTabButton {
                    item.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6)
                    item.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                }
            }
        } else {
            changeDeleteButtonStatus(sender, back: true)
            removeFingerPoint()
            removeEditFingerButton()
        }
    }
    
    func changeDeleteButtonStatus(sender: UIButton, back: Bool) {
        if back == false {
            sender.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.4)
            self.mainStatusTitle.text = "Delete Tab"
            deleteButtonPressed = true
        } else {
            sender.backgroundColor = UIColor.clearColor()
            //removeAllDeleteButton()
            if editAvaliable == true {
                self.mainStatusTitle.text = "Add New Tab"
            } else {
                self.mainStatusTitle.text = "Tab Editor"
            }
            deleteButtonPressed = false
        }
    }
    
    // for music view
    struct tabOnMusicLine {
        var tab: UIView = UIView()
        var time: NSTimeInterval = NSTimeInterval()
    }
    
    var allTabsOnMusicLine: [tabOnMusicLine] = [tabOnMusicLine]()
    
    func createTabOnMusicLine(sender: UIButton, time: Float) {
        var tabX = 0.667 * self.trueWidth
        var tabY = 0.3 * self.trueHeight
        var tabWidth = 0.08 * self.trueHeight
        var tabHeight = 0.09 * self.trueHeight
        var tempTab: UIView = UIView()
        var name = sender.titleLabel?.text
        tempTab.frame = CGRectMake(tabX, tabY, tabWidth, tabHeight)
    }
    
    func createSoundWave() {
        let filename: String = "rainbow.mp3"
        let frame = CGRectMake(0.667 * self.trueWidth, 0, 4 * self.trueWidth, 0.4 * self.trueHeight)
        self.progressBlock = SoundWaveView(frame: frame)
        let url = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("rainbow", ofType: "mp3")!)
        self.progressBlock.SetSoundURL(url!)
    }
    
    func pressMainTabButton(sender: UIButton) {
        println("press main tab button")
        if deleteButtonPressed == true {
            println("delete this button")
            var index = 0
            for item in self.mainTabButton {
                if item == sender {
                    item.removeFromSuperview()
                    mainTabButton.removeAtIndex(index)
                    break
                }
                index++
            }
            changeDeleteButtonStatus(self.removeButton, back: true)
            reorganizeMainTabButton(self.mainTabButton)
        } else {
            println("show it on top")
            var tempView: UIView = UIView()
            tempView.frame = CGRectMake(0 + CGFloat(self.currentTime / self.duration) * (self.progressBlock.frame.width), self.progressBlock.frame.height / 2, 0.0225 * self.trueHeight, 0.175 * self.trueHeight)
            tempView.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.4)
            tempView.layer.cornerRadius = 2
            var tempStruct: tabOnMusicLine = tabOnMusicLine()
            var name = sender.titleLabel?.text
            var number = count(name!)
            for var i = 0; i < number; i = i + 2 {
                var index = advance(name!.startIndex, i + 1)
                name?.insert("\n", atIndex: index)
            }
            var tempLabelView: UILabel = UILabel()
            tempLabelView.frame = CGRectMake(0, 0, tempView.frame.width, tempView.frame.height)
            tempLabelView.layer.cornerRadius = 2
            tempLabelView.font = UIFont.systemFontOfSize(11)
            tempLabelView.textAlignment = NSTextAlignment.Center
            tempLabelView.numberOfLines = 3
            tempLabelView.text = name
            tempView.addSubview(tempLabelView)
            tempStruct.tab = tempView
            tempStruct.time = self.currentTime
            self.allTabsOnMusicLine.append(tempStruct)
            self.progressBlock.addSubview(tempView)
        }
    }
    
//    func pressRemoveButton(sender: UIButton) {
//        println("press Remove Button")
//        if self.deleteButtonPressed == false {
//            if editAvaliable == true {
//                var count = 0
//                for item in self.newTabButton {
//                    var deleteButton: UIButton = UIButton()
//                    deleteButton.frame = CGRectMake(0, 0, 15, 15)
//                    deleteButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4)
//                    deleteButton.setImage(UIImage(named: "blackX"), forState: UIControlState.Normal)
//                    deleteButton.addTarget(self, action: "pressDeleteButton:", forControlEvents: UIControlEvents.TouchUpInside)
//                    var name = item.titleLabel?.text
//                    deleteButton.setTitle(name, forState: UIControlState.Normal)
//                    deleteButton.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
//                    deleteButton.layer.cornerRadius = 2
//                    deleteButton.tag = count
//                    var tempStruct: tabButtonWithDeleteButton = tabButtonWithDeleteButton()
//                    tempStruct.tabButton = item
//                    tempStruct.deleteButton = deleteButton
//                    self.allDeleteButton.append(tempStruct)
//                    item.addSubview(deleteButton)
//                    count++
//                }
//            } else {
////                var buttonWidth = 0.1 * self.trueHeight
////                var count = 0
////                for item in self.mainTabButton {
////                    var deleteButton: UIButton = UIButton()
////                    deleteButton.frame = CGRectMake(0, 0, 15, 15)
////                    deleteButton.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4)
////                    deleteButton.layer.cornerRadius = 0.5 * 15
////                    deleteButton.setImage(UIImage(named: "blackX"), forState: UIControlState.Normal)
////                    deleteButton.addTarget(self, action: "pressDeleteButton:", forControlEvents: UIControlEvents.TouchUpInside)
////                    deleteButton.tag = count
////                    var tempStruct: tabButtonWithDeleteButton = tabButtonWithDeleteButton()
////                    tempStruct.tabButton = item
////                    tempStruct.deleteButton = deleteButton
////                    self.allDeleteButton.append(tempStruct)
////                    item.addSubview(deleteButton)
////                    count++
////                }
//                var index = self.currentButton.tag
//                if index > 10000 {
//                    let alertController = UIAlertController(title: "Delete Warning", message:
//                        "Cannot delete built-in tabs", preferredStyle: UIAlertControllerStyle.Alert)
//                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
//                    self.presentViewController(alertController, animated: true, completion: nil)
//                } else {
//                    var name = self.currentButton.titleLabel?.text
//                    core.removeExistNewTab("\(index)", name: name!)
//                    self.currentButton.removeFromSuperview()
//                }
//            }
//            self.deleteButtonPressed = true
//            changeDeleteButtonStatus(sender, back: false)
//
//        } else {
//            self.deleteButtonPressed = false
//            changeDeleteButtonStatus(sender, back: true)
//        }
//        
//    }
    
//    func removeAllDeleteButton() {
//        for item in self.allDeleteButton {
//            item.deleteButton.removeFromSuperview()
//        }
//        self.allDeleteButton.removeAll(keepCapacity: false)
//        self.newTabButton.removeAll(keepCapacity: false)
//    }
//    func pressDeleteButton(sender: UIButton) {
//        println("delete button")
//        var tag = sender.tag
//        var tempStruct = allDeleteButton[tag]
//        var index = tempStruct.tabButton.tag
//        var name = tempStruct.tabButton.titleLabel?.text
//        if index < 10000 {
//            core.removeExistNewTab("\(index)", name: name!)
//        }
//        tempStruct.tabButton.removeFromSuperview()
//        var count = 0
//        for item in self.mainTabButton {
//            if item.tag == tempStruct.tabButton.tag {
//                mainTabButton.removeAtIndex(count)
//            }
//            count++
//        }
//        self.allDeleteButton.removeAtIndex(tag)
//        changeDeleteButtonStatus(self.removeButton, back: true)
//        self.deleteButtonPressed = false
//    }
}

