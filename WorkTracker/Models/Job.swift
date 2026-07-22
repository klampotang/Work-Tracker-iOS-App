//
//  Job.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import Foundation

struct Job: Identifiable {
    let id: UUID
    let name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    
    static func mockJobs() -> [Job] {
        return [
            Job(name: "Meta"),
            Job(name: "Interview prep")
        ]
    }
}
