//
//  TimeDisplay.swift
//  Pomodoro++
//
//  Created by Illya Starikov on 12/18/15.
//  Copyright © 2015 Illya Starikov. All rights reserved.
//

import Foundation

struct TimeDisplay {
    //var breakTimer = Timer(minutes: Constants.defaultMinutesInBreak),
    //focusTimer = Timer(minutes: Constants.defaultMinutesInFocus, isBreakTimer: true)
    
    private var timers: (current: Timer, next: Timer) = (Timer(minutes: Constants.defaultMinutesInFocus), Timer(minutes: Constants.defaultMinutesInBreak, isBreakTimer: true))
    
    var currentTimer: Timer { return timers.current }
    
    var isTimerFinished: Bool { return currentTimer.isTimerFinished }
    var isBreakTimer: Bool { return currentTimer.isBreakTimer }
    var totalSecondsLeft: Int { return currentTimer.totalSeconds }
    var initialTotalSeconds: Int { return currentTimer.initialTotalSeconds }
    
    var displayText: String { return currentTimer.displayText }
    
    func updateTimer() {
        return currentTimer.updateTheTimer()
    }
    
    private func resetTheTimer() {
        currentTimer.resetTheTimer()
    }
    
    mutating func switchFocusAndBreak() {
        func timerSwap(_ tuple: inout (current: Timer, next: Timer)) {
            let temporary = tuple.current
            tuple.current = tuple.next
            tuple.next = temporary
        }
        
        resetTheTimer()
        timerSwap(&timers)
    }
    
}
