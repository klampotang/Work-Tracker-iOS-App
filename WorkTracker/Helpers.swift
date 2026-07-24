//
//  Helpers.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation

struct LayedOutEntry: Identifiable {
    var id: UUID {
        return entry.id
    }
    let entry: WorkEntry
    let columnIndex: Int
    let totalColumns: Int
}

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
    
    static func layOut(entries: [WorkEntry]) -> [LayedOutEntry] {
        var result = [LayedOutEntry]()
        for entry in entries {
            // Find overlapping entries with this one
            let overlappingEntries = entries.filter { otherEntry in
                return entriesOverlap(entry1: otherEntry, entry2: entry)
            }
            // Find columnIndex
            let columnIndex = overlappingEntries.firstIndex(where: {
                $0.id == entry.id
            }) ?? 0
            // Find column count
            let totalColumns = overlappingEntries.count
            result.append(LayedOutEntry(entry: entry, columnIndex: columnIndex, totalColumns: totalColumns))
        }
        return result
    }
    
    static func entriesOverlap(entry1: WorkEntry, entry2: WorkEntry) -> Bool {
        return entry1.endTime > entry2.startTime && entry1.startTime < entry2.endTime
    }
}
