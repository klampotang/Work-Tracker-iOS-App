//
//  WorkEntry.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation

struct WorkEntry: Identifiable {
    let id: UUID
    var job: Job
    var startTime: Date
    var endTime: Date
    
    init(id: UUID = UUID(), job: Job, startTime: Date, endTime: Date) {
        self.id = id
        self.job = job
        self.startTime = startTime
        self.endTime = endTime
    }
    
    static func mockEntries(jobs: [Job]) -> [WorkEntry] {
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
            WorkEntry(job: jobs[0], startTime: startTime1, endTime: endTime1),
            WorkEntry(job: jobs[1], startTime: startTime2, endTime: endTime2)
        ]
    }
}

