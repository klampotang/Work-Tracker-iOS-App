//
//  ManualEntryView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct ManualEntryView: View {
    @Bindable var viewModel: HourLoggerViewModel
    @State var startTime: Date = Date()
    @State var endTime: Date = Date()
    var body: some View {
        let startDateRange: ClosedRange<Date> = {
            let calendar = Calendar.current
            let startComponents = DateComponents(year: 2026, month: 1, day: 1)
            return calendar.date(from:startComponents)!
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
                
            }
            DatePicker(
                "End Date",
                selection: $endTime,
                in: endDateRange,
                displayedComponents: [.date, .hourAndMinute]
            )
            Button("Add manual entry") {
                if let jobIndex = viewModel.jobs.firstIndex(where: {
                    $0.id == viewModel.selectedJobId
                }) {
                    let job = viewModel.jobs[jobIndex]
                    viewModel.addManualEntry(with: startTime, endTime: endTime, job: job)
                }
            }
        }
        .padding()
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    ManualEntryView(viewModel: viewModel)
}
