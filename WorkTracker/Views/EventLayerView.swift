//
//  EventLayerView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/23/26.
//

import SwiftUI
import SwiftData

struct EventLayerView: View {
    var date: Date
    @Bindable var viewModel: HourLoggerViewModel
    @Query(sort: \WorkEntry.startTime, order: .reverse) var entries: [WorkEntry]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topLeading) {
                let entriesForDay = Helpers.entries(for: date, entries)
                let layedoutEvents = Helpers.layOut(entries: entriesForDay)
                ForEach(layedoutEvents) { item in
                    let entry = item.entry
                    let highlighted = entry == viewModel.selectedEntry
                    let durationInHours = entry.durationInHours
                    let columnWidth = (geometry.size.width - ViewConstants.hourLabelWidth) / Double(item.totalColumns)
                    VStack {
                        Text("\(entry.job.name)")
                        Text("\(entry.startTime.formatted(date: .omitted, time: .shortened)) to \(entry.endTime.formatted(date: .omitted, time: .shortened))")
                            .font(.caption)
                    }
                    .onTapGesture {
                        viewModel.selectedEntry = entry
                        viewModel.selectedJobId = entry.job.id
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 4.0)
                            .fill(.blue)
                            .stroke(Color.red, lineWidth: highlighted ? 2 : 0)
                    )
                    .frame(width: columnWidth, height: durationInHours * ViewConstants.hourHeight)
                    .offset(x: ViewConstants.hourLabelWidth + (Double(item.columnIndex) * Double(columnWidth)),
                            y: entry.startHourFromMidnight * ViewConstants.hourHeight)
                    
                }
            }
        }
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    EventLayerView(date: Date(), viewModel: viewModel)
}
