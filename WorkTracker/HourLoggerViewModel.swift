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
    var entries: [WorkEntry] = WorkEntry.mockEntries()
    var jobs: [Job] = []
    var selectedJobId: UUID? = nil
    var startTime: Date? = nil
    
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
    
    func stopTrackingJob() {
        guard let startTime = startTime else {return}
        let endTime = Date()
        if let jobIndex = jobs.firstIndex(where: {
            $0.id == selectedJobId
        }) {
            let workEntry = WorkEntry(job: jobs[jobIndex], startTime: startTime, endTime: endTime)
            entries.append(workEntry)
        }
    }
    
    init() {
        // Automatically select the first job on launch
        self.selectedJobId = jobs.first?.id
    }
}
