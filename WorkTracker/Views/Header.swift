//
//  Header.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import SwiftData

struct Header: View {
    @Bindable var viewModel: HourLoggerViewModel
    @Query var jobs: [Job]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            HStack {
                Text("Job:")
                    .foregroundColor(.primary)
                if jobs.isEmpty {
                    Text("No jobs created")
                        .foregroundColor(.secondary)
                } else {
                    JobPicker(viewModel: viewModel)
                }
            }
            .padding()
            .onAppear {
                // Auto-select the first job on launch if nothing is selected
                if viewModel.selectedJobId == nil {
                    viewModel.selectedJobId = jobs.first?.id
                }
            }

            HStack {
                Button("Start log") {
                    viewModel.startTrackingJob()
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .disabled(viewModel.selectedJobId == nil)
                .font(.title2)
                .foregroundColor(.white)

                if let startTime = viewModel.startTime {
                    Text(startTime, style: .timer)
                        .font(.system(.title, design: .rounded))
                        .monospacedDigit()
                        .foregroundStyle(.blue)
                }

                Button("Stop log") {
                    viewModel.stopTrackingJob(jobs: jobs, context: modelContext)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .disabled(viewModel.startTime == nil)
                .font(.title2)
                .foregroundColor(.white)
            }
            .padding(.horizontal, 10)

            Button("Add manual entry") {
                viewModel.isShowingManualEntryView = true
            }
            .disabled(viewModel.startTime != nil)
            .buttonStyle(.borderedProminent)
            .font(.caption)
            .foregroundColor(.white)
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, WorkEntry.self, configurations: config)
    let job = Job(name: "Meta")
    container.mainContext.insert(job)
    return Header(viewModel: HourLoggerViewModel())
        .modelContainer(container)
}
