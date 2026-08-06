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
        if index == 0 || index == Constants.hoursInDay {
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
        let sortedEntries = sort(entries: entries)
        let clusters = group(sortedEntries: sortedEntries)
        return clusters.flatMap { cluster in
            layout(cluster: cluster)
        }
    }
    
    static func sort(entries: [WorkEntry]) -> [WorkEntry] {
        return entries.sorted { first, second in
            if first.startTime != second.startTime {
                return first.startTime < second.startTime
            }
            return first.endTime < second.endTime
        }
    }
    
    static func group(sortedEntries: [WorkEntry]) -> [[WorkEntry]] {
        var clusteredEntries = [[WorkEntry]]()
        var currentCluster = [WorkEntry]()
        var clusterEnd = Date.distantPast
        for entry in sortedEntries {
            // If this entry is not in the cluster, make a new cluster
            if entry.startTime >= clusterEnd {
                clusteredEntries.append(currentCluster)
                currentCluster = []
            }
            currentCluster.append(entry)
            clusterEnd = max(entry.endTime, clusterEnd)
        }
        
        if !currentCluster.isEmpty {
            clusteredEntries.append(currentCluster)
        }
        
        return clusteredEntries
    }
    
    static func layout(cluster: [WorkEntry]) -> [LayedOutEntry] {
        // Track end time of event currently in each column
        var columnEndTimes = [Date]()
        var placements = [(entry: WorkEntry, column: Int)]()
        
        for entry in cluster {
            // Find column that's empty:
            if let freeColumnIndex = columnEndTimes.firstIndex(where: {
                $0 <= entry.startTime
            }) {
                columnEndTimes[freeColumnIndex] = entry.endTime
                placements.append((entry: entry, column: freeColumnIndex))
            } else {
                columnEndTimes.append(entry.endTime)
                placements.append((entry: entry, column: columnEndTimes.count - 1))
            }
        }
        return placements.map { placement in
            return LayedOutEntry(entry: placement.entry, columnIndex: placement.column, totalColumns: columnEndTimes.count)
        }
    }
    
    static func entriesOverlap(entry1: WorkEntry, entry2: WorkEntry) -> Bool {
        return entry1.endTime > entry2.startTime && entry1.startTime < entry2.endTime
    }
}
