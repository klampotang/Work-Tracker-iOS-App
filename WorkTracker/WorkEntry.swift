//
//  WorkEntry.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation

struct WorkEntry {
    var job: Job
    var startTime: Date
    var endTime: Date
    
    static func mockEntries() -> [WorkEntry] {
        let startTime1 = Calendar.current.date(
                        bySettingHour: 9,
                        minute: 0,
                        second: 0,
                        of: Calendar.current.date(
                            byAdding: .day,
                            value: -1,
                            to: Date())!)!
        let endTime1 = Calendar.current.date(
            bySettingHour: 12,
            minute: 30,
            second: 0,
            of: Calendar.current.date(byAdding: .day,
                                      value: -1,
                                      to: Date())!
        )!
        let startTime2 = Calendar.current.date(bySettingHour: 3,
                                               minute: 0,
                                               second: 0,
                                               of: Date())!
        let endTime2 = Calendar.current.date(bySettingHour: 5,
                                               minute: 0,
                                               second: 0,
                                               of: Date())!
        return [
            WorkEntry(job: Job(name: "Meta"), startTime: startTime1, endTime: endTime1),
            WorkEntry(job: Job(name: "Interview"), startTime: startTime2, endTime: endTime2)
        ]
    }
}

