//
//  DayViewHeader.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/27/26.
//

import SwiftUI
import SwiftData

struct DayViewHeader: View {
    @Bindable var viewModel: HourLoggerViewModel

    var body: some View {
        if let entry = viewModel.selectedEntry {
            DayViewHeaderContent(entry: entry, viewModel: viewModel)
        }
    }
}

private struct DayViewHeaderContent: View {
    @Bindable var entry: WorkEntry
    @Bindable var viewModel: HourLoggerViewModel
    @Query var jobs: [Job]

    var body: some View {
        VStack(spacing: 0) {
            JobPicker(viewModel: viewModel)
            let startDateRange: ClosedRange<Date> = {
                let calendar = Calendar.current
                let startComponents = DateComponents(year: 2026, month: 1, day: 1)
                return calendar.date(from: startComponents)!
                    ...
                    Date()
            }()

            let endDateRange: ClosedRange<Date> = {
                return entry.startTime
                    ...
                    Date()
            }()

            DatePicker(
                "Start",
                selection: $entry.startTime,
                in: startDateRange,
                displayedComponents: [.date, .hourAndMinute]
            )
            DatePicker(
                "End",
                selection: $entry.endTime,
                in: endDateRange,
                displayedComponents: [.date, .hourAndMinute]
            )
            Button("Update") {
                if let selectedJobId = viewModel.selectedJobId,
                   let job = jobs.first(where: { $0.id == selectedJobId }) {
                    entry.job = job
                }
                viewModel.updateEntry(entry: entry)
            }
            .padding(.bottom, 4)
        }
        .background(.thinMaterial)
    }
}
