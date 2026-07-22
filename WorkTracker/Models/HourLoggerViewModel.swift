//
//  HourLoggerViewModel.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import Foundation

@Observable
class HourLoggerViewModel {
    // State for work logger
    var jobs: [Job] = []
    var entries: [WorkEntry] = []
    var selectedJobId: UUID? = nil
    var startTime: Date? = nil
    var isShowingManualEntryView: Bool = false
    
    func addJob(_ name: String) {
        let newJob = Job(name: name)
        jobs.append(newJob)
        
        // Optional: Auto-select if nothing is currently selected
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
    
    func addManualEntry(with startTime: Date, endTime: Date, job: Job) {
        let workEntry = WorkEntry(job: job, startTime: startTime, endTime: endTime)
        entries.append(workEntry)
    }
    
    func stopTrackingJob() {
        guard let startTime = startTime else {return}
        let endTime = Date()
        if let jobIndex = jobs.firstIndex(where: {
            $0.id == selectedJobId
        }) {
            let workEntry = WorkEntry(job: jobs[jobIndex], startTime: startTime, endTime: endTime)
            entries.append(workEntry)
            reset()
        }
    }
    
    func reset() {
        startTime = nil
    }
    
    init() {
        // Automatically select the first job on launch
        self.jobs = Job.mockJobs()
        self.entries = WorkEntry.mockEntries(jobs: jobs)
        self.selectedJobId = jobs.first?.id
    }
}
