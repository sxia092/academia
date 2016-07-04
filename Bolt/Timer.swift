//
//  Timer.swift
//  Bolt
//
//  Created by Illya Starikov on 1/19/16.
//  Copyright © 2016 Illya Starikov. All rights reserved.
//

import Foundation

class Timer {
    private var hours: Int?, minutes: Int?, seconds: Int
    private let defaultValues: (hours: Int?, minutes: Int?, seconds: Int)
    
    var isBreakTimer: Bool
    var isTimerFinished: Bool { return totalSeconds == 0 }
    
    var totalSeconds: Int {
        var total = seconds
        
        if let hours = hours { total += hours * 60 * 60 }
        if let minutes = minutes { total += minutes * 60 }
        
        return total
    }
    
    var initialTotalSeconds: Int {
        var total = defaultValues.seconds
        
        if let hours = defaultValues.hours { total += hours * 60 * 60 }
        if let minutes = defaultValues.minutes { total += minutes * 60 }
        
        return total
    }
    
    var displayText: String {
        var leftHandSide: String, rightHandSide: String
        
        if let hours = hours, minutes = minutes {
            leftHandSide = hours <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(hours)" : "\(hours)"
            
            rightHandSide = minutes <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(minutes)" : "\(minutes)"
        } else if let minutes = minutes {
            leftHandSide = minutes <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(minutes)" : "\(minutes)"
            
            rightHandSide = seconds <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(seconds)" : "\(seconds)"
        } else {
            leftHandSide = "00"
            
            rightHandSide = seconds <= Constants.timeNeededToPreAppendAZeroToDisplay ? "0\(seconds)" : "\(seconds)"
        }
        
        return "\(leftHandSide):\(rightHandSide)"
    }
    
    init(seconds: Int = 0, minutes: Int? = nil, hours: Int? = nil, isBreakTimer: Bool = false) {
        if hours != nil { self.minutes = 0 }
        
        self.hours = hours
        self.seconds = seconds
        self.minutes = minutes
        
        defaultValues = (hours, minutes, seconds)
        self.isBreakTimer = isBreakTimer
    }
    
    func resetTheTimer() {
        hours = defaultValues.hours
        minutes = defaultValues.minutes
        seconds = defaultValues.seconds
    }
    
    
    func updateTheTimer() {
        if seconds == 0 {
            seconds = 59
            if minutes == 0 {
                
                minutes = 59
                if hours != 0 && hours != nil { hours! -= 1 }
                
            } else if minutes != nil {
                minutes! -= 1
            }
        } else {
            seconds -= 1
        }
    }
}


/*--------------------Begin Legacy--------------------*/
/*
 func convertUnitsFromSeconds(let totalSecondsToConvertFrom: Int) {
 hours = (totalSecondsToConvertFrom / GlobalConstants.numberOfSecondsInMinute / GlobalConstants.numberOfMinutesInHours) % GlobalConstants.numberOfHoursInDay; // Trim the lefovers
 minutes = (totalSecondsToConvertFrom / GlobalConstants.numberOfSecondsInMinute) % GlobalConstants.numberOfMinutesInHours; // Trim the leftovers
 seconds = totalSecondsToConvertFrom % GlobalConstants.numberOfSecondsInMinute; // Likewise, trim the leftovers
 }
 */
/*--------------------End Legacy--------------------*/

