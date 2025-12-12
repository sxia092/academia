//
//  Timer.swift
//  Bolt
//
//  Created by Illya Starikov on 1/19/16.
//  Copyright © 2016 Illya Starikov. All rights reserved.
//

import Foundation

class Timer {

    convenience init(hours: Int, minutes: Int, seconds: Int) {
        self.init()
        
        var totalSeconds = 0;
        totalSeconds += hours * Constants.numberOfMinutesInHour * Constants.numberOfSecondsInMinute
        totalSeconds += minutes * Constants.numberOfSecondsInMinute
        totalSeconds += seconds
        
        self.totalSeconds = totalSeconds
        defaultTotalSeconds = totalSeconds
    }
    
    var timer = Foundation.Timer()
    var additionalAction: (String) -> Void = { _ in return }
    
    var isFinished: Bool {
        get {
            return totalSeconds <= 0
        }
    }
    
    private var totalSeconds = Constants.defaultMinutes * Constants.numberOfSecondsInMinute
    private var defaultTotalSeconds = Constants.defaultMinutes * Constants.numberOfSecondsInMinute
    
    var resetsTo: Int { get { return defaultTotalSeconds } }
    
    private var hours: Int {
        return (totalSeconds / Constants.numberOfSecondsInMinute / Constants.numberOfMinutesInHour) % Constants.numberOfHoursInDay;
    }
    
    private var minutes: Int {
        return (totalSeconds / Constants.numberOfSecondsInMinute) % Constants.numberOfMinutesInHour
    }
    
    private var seconds: Int {
        return totalSeconds % Constants.numberOfSecondsInMinute
    }
    
    var displayText: String {
        if isFinished { return "00:00" }
        
        let leftHandSide: String, rightHandSide: String
        
        if hours > 0 {
            leftHandSide = hours <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(hours)" : "\(hours)"
            rightHandSide = minutes <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(minutes)" : "\(minutes)"
        } else {
            leftHandSide = minutes <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(minutes)" : "\(minutes)"
            rightHandSide = seconds <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(seconds)" : "\(seconds)"
        }
        
       return "\(leftHandSide):\(rightHandSide)"
    }
    
    var isRunning: Bool {
        return timer.isValid
    }
    
    // MARK: Methods
    func start() {
        if !isRunning {
            timer = Foundation.Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        }
    }
    
    func stop() {
        timer.invalidate()
    }
    
    func reset() {
        stop()
        totalSeconds = defaultTotalSeconds
    }
    
    @objc func update() {
        totalSeconds -= 1
        additionalAction(displayText)
    }
    
    // MARK: Constants
    
    private struct Constants {
        static let defaultMinutes = 25
        
        // Constants For Readibility
        static let numberOfSecondsInMinute = 60
        static let numberOfMinutesInHour = 60
        static let numberOfHoursInDay = 24
        
        static let timeNeededToPreAppendAZeroToDisplay = 9
    }
}


