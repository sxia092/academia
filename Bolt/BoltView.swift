//
//  FirstViewController.swift
//  Bolt
//
//  Created by Illya Starikov on 12/21/15.
//  Copyright © 2015 Illya Starikov. All rights reserved.
//

import UIKit

class BoltView: UIViewController {

    @IBOutlet weak var displayTimer: UILabel!
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var topView: UIView!
    
    var timer = Foundation.Timer()
    var timeDisplay = TimeDisplay()
    
    @IBAction func startTheTimer() {
        timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(BoltView.updateProgress), userInfo: nil, repeats: true)
    }
    
    func pauseTheTimer() {
        timer.invalidate()
    }
    
    func resetTheTimer() {
        pauseTheTimer()
    }
    
    func updateProgress() {
        if timeDisplay.isBreakTimer { displayTimer.text! = "" }
        timeDisplay.updateTimer()
        
        if !timeDisplay.isTimerFinished {
            displayTimer.text! = timeDisplay.displayText
        } else {
            timeDisplay.switchFocusAndBreak()
        }
    }
    
    func randomArbitrary(low floor: Int, high ceiling: Int) -> Int {
        let floor = UInt32(floor)
        let ceiling = UInt32(ceiling)
        return Int(arc4random_uniform(ceiling - floor) + floor) + 1
    }
    
    func newImage() -> UIImage {
        let name = randomArbitrary(low: Constants.imageFloor, high: Constants.imageCeiling)
        return UIImage(named: "\(name)")!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.image = newImage()
        topView.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2/3))
     //   self.topLeftView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2 / 2))
        displayTimer.transform = CGAffineTransform(rotationAngle: CGFloat(-M_PI_2/3))
        // SettingsViewController.startOnInit { startTheTimer() }
        displayTimer.text! = ""
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

