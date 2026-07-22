//
//  JobPicker.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import SwiftData

struct JobPicker: View {
    @Bindable var viewModel: HourLoggerViewModel
    @Query var jobs: [Job]

    var body: some View {
        Picker("Job", selection: $viewModel.selectedJobId) {
            ForEach(jobs) { job in
                Text(job.name).tag(job.id as UUID?)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, WorkEntry.self, configurations: config)
    let job = Job(name: "Meta")
    container.mainContext.insert(job)
    return JobPicker(viewModel: HourLoggerViewModel())
        .modelContainer(container)
}
