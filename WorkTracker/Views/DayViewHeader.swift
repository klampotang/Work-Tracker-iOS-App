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
                viewModel.updateEntry(entry: entry)
            }
        }
        .background(.thinMaterial)
    }
}
