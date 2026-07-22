//
//  WorkEntry.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation
import SwiftData

@Model
class WorkEntry {
    var id: UUID
    var job: Job
    var startTime: Date
    var endTime: Date

    init(id: UUID = UUID(), job: Job, startTime: Date, endTime: Date) {
        self.id = id
        self.job = job
        self.startTime = startTime
        self.endTime = endTime
    }
}
