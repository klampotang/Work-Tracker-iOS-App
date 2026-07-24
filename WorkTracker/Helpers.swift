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
    
    static func groupedEntries(_ entries: [WorkEntry]) -> [(date: Date, entries: [WorkEntry])] {
        let dictionary = Dictionary(grouping: entries) { entry in
            Calendar.current.startOfDay(for: entry.startTime)
        }
        return dictionary
            .map { (date: $0.key, entries: $0.value) }
            .sorted { $0.date > $1.date }
    }
    
    static func entries(for day: Date, _ entries: [WorkEntry]) -> [WorkEntry] {
        return entries.filter { entry in
            Calendar.current.isDate(entry.startTime, inSameDayAs: day)
        }
    }
    static func hourFormatter(for index: Int) -> String {
        if index == 0 || index == 24 {
            return "12 AM"
        } else if index == 12 {
            return "12 PM"
        } else if index < 12 {
            return "\(index) AM"
        } else {
            return "\(index - 12) PM"
        }
    }
}
