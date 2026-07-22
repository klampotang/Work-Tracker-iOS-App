//
//  ManualEntryView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import SwiftData

struct ManualEntryView: View {
    @Bindable var viewModel: HourLoggerViewModel
    @Query var jobs: [Job]
    @Environment(\.modelContext) private var modelContext
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()

    var body: some View {
        let startDateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
            let startComponents = DateComponents(year: 2026, month: 1, day: 1)
            return calendar.date(from: startComponents)!
                ...
                Date()
        }()

        let endDateRange: ClosedRange<Date> = {
            return startTime
                ...
                Date()
        }()

        VStack {
            JobPicker(viewModel: viewModel)
            DatePicker(
                "Start Date",
                selection: $startTime,
                in: startDateRange,
                displayedComponents: [.date, .hourAndMinute]
            )
            Button("Start from selected time") {
                viewModel.startTrackingJob(with: startTime)
                viewModel.isShowingManualEntryView = false
            }
            DatePicker(
                "End Date",
                selection: $endTime,
                in: endDateRange,
                displayedComponents: [.date, .hourAndMinute]
            )
            Button("Add manual entry") {
                if let job = jobs.first(where: { $0.id == viewModel.selectedJobId }) {
                    viewModel.addManualEntry(with: startTime, endTime: endTime, job: job, context: modelContext)
                }
                viewModel.isShowingManualEntryView = false
            }
        }
        .padding()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, WorkEntry.self, configurations: config)
    let job = Job(name: "Meta")
    container.mainContext.insert(job)
    return ManualEntryView(viewModel: HourLoggerViewModel())
        .modelContainer(container)
}
