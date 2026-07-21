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
    var jobInput: String = ""
    var selectedJobId: UUID? = nil
    
    func addJob(_ name: String) {
        let newJob = Job(name: name)
        jobs.append(newJob)
        
        // Optional: Auto-select if nothing is currently selected
        if selectedJobId == nil {
            selectedJobId = newJob.id
        }
    }
    
    init() {
        // Automatically select the first job on launch
        self.selectedJobId = jobs.first?.id
    }
}
