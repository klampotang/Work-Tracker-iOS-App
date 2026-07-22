//
//  HourLoggerViewModel.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import Foundation
import SwiftData

@Observable
class HourLoggerViewModel {
    var selectedJobId: UUID? = nil
    var startTime: Date? = nil
    var isShowingManualEntryView: Bool = false
    var jobFilterId: UUID? = nil
    var showAnimationOverlay = false

    func filteredEntries(_ entries: [WorkEntry]) -> [WorkEntry] {
        guard let jobFilterId else { return entries }
        return entries.filter { $0.job.id == jobFilterId }
    }

    func addJob(_ name: String, context: ModelContext) {
        let newJob = Job(name: name)
        context.insert(newJob)
        if selectedJobId == nil {
            selectedJobId = newJob.id
        }
    }

    func startTrackingJob() {
        startTime = Date()
    }

    func startTrackingJob(with startTime: Date) {
        self.startTime = startTime
    }

    func stopTrackingJob(jobs: [Job], context: ModelContext) {
        guard let startTime else { return }
        if let job = jobs.first(where: { $0.id == selectedJobId }) {
            let workEntry = WorkEntry(job: job, startTime: startTime, endTime: Date())
            context.insert(workEntry)
            reset()
        }
    }

    func addManualEntry(with startTime: Date, endTime: Date, job: Job, context: ModelContext) {
        let workEntry = WorkEntry(job: job, startTime: startTime, endTime: endTime)
        context.insert(workEntry)
    }

    func reset() {
        startTime = nil
    }
}
