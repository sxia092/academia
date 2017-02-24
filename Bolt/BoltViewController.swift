//
//  FirstViewController.swift
//  Bolt
//
//  Created by Illya Starikov on 12/21/15.
//  Copyright © 2015 Illya Starikov. All rights reserved.
//

import UIKit

class BoltViewController: UIViewController, UIViewControllerTransitioningDelegate {
    @IBOutlet weak var effectsView: UIVisualEffectView!
    
    private var timers = [Constants.defaultTimer]
    var currentTimer: Timer? { get { return timers.first } }
    
    let customPresentAnimationController = CustomPresentAnimationController()
    var defaults = UserDefaults()
    
    var playPauseText: String {
        get {
            if let timer = currentTimer {
                if timer.isRunning {
                    return Constants.pause
                } else {
                    return Constants.start
                }
            } else {
                return ""
            }
        }
    }
    
    var repeats: Bool {
        get {
            return defaults.bool(forKey: "Repeats")
        }
    }
    
    var beginOnStartup: Bool {
        get {
            return false //defaults.bool(forKey: "Begin On Startup")
        }
    }
    
    weak var bottomButton: UIButton! {
        get {
            return angularOverlay.bottomButton
        }
    }
    
    var bottomButtonText: String? {
        get {
            return angularOverlay.topButton.titleLabel?.text
        } set {
            angularOverlay.bottomButton.setTitle(newValue, for: [])
        }
    }
    
    var topButtonText: String? {
        get {
            return angularOverlay.topButton.titleLabel?.text
        } set {
            angularOverlay.topButton.setTitle(newValue, for: [])
        }
    }
    
    @IBOutlet weak var backgroundView: UIImageView!
    @IBOutlet weak var angularOverlay: AngularOverlay! {
        didSet {
            let changeState: () -> Void = { [weak weakSelf = self] in
                weakSelf?.changeState()
            }
            
            let function: (String) -> Void = { [weak weakSelf = self] in
                weakSelf?.topButtonText = $0
                
                if let timer = weakSelf?.currentTimer, timer.isFinished {
                    timer.reset()
                    changeState()
                    
                    if (weakSelf?.repeats)! {
                        timer.start()
                    }
                }
            }
            
            angularOverlay.bottomButtonAction = changeState
            currentTimer?.additionalAction = function
        }
    }
    
    func newImage() -> UIImage {
        let name = Int().randomArbitrary(from: Constants.imageFloor, to: Constants.imageCeiling)
        return UIImage(named: "\(name)")!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.image = newImage()
        
        if beginOnStartup {
            currentTimer?.start()
            bottomButtonText = playPauseText
        } else {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateUI()
    }
    
    private func updateUI() {
        topButtonText = currentTimer?.displayText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        
        if let navigationController = destinationVC as? UINavigationController {
            destinationVC = navigationController.visibleViewController ?? destinationVC
        }
        
        if let settingsVC = destinationVC as? SettingsViewController {
            settingsVC.transitioningDelegate = self
        }
    }
    
    private func changeState() {
        if let timer = currentTimer, timer.isRunning {
            timer.stop()
        } else if let timer = currentTimer, !timer.isRunning {
            timer.start()
        }
        
        bottomButtonText = playPauseText
    }
    
    func animationController(forPresentedController presented: UIViewController, presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    private struct Constants {
        static let imageFloor = 1
        static let imageCeiling = 12
        
        static let pause = "Pause Timer"
        static let start = "Start Timer"
        
        static let defaultTimer = Timer(hours: 0, minutes: 0, seconds: 5)
    }
    
    
}


extension Int {
    func randomArbitrary(from floor: Int, to ceiling: Int) -> Int {
        let floor = UInt32(floor)
        let ceiling = UInt32(ceiling)
        return Int(arc4random_uniform(ceiling - floor) + floor) + 1
    }
}
