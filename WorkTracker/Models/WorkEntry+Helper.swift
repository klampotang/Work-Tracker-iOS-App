//
//  WorkEntry+Helper.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/24/26.
//

import Foundation

extension WorkEntry {
    var startHourFromMidnight: Double {
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: startTime)
        let hour = Double(components.hour ?? 0)
        let minute = Double(components.minute ?? 0)
        let second = Double(components.second ?? 0)
        
        return hour + (minute / 60.0) + (second / 3600.0)
    }
    
    var durationInHours: Double {
        max(endTime.timeIntervalSince(startTime) / 3600.0, 0.05) // Prevents 0-height blocks
    }
}
