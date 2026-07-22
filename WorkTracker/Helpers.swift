//
//  Helpers.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation

struct Helpers {
    static func formattedRunningTime(from startTime: Date, _ endTime: Date) -> String {
        let elapsedTime = endTime.timeIntervalSince(startTime)
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: elapsedTime) ?? "0s"
    }
}
