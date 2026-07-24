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
    @Query(sort: \WorkEntry.startTime, order: .reverse) var entries: [WorkEntry]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                let entriesForDay = Helpers.entries(for: date, entries)
                let layedoutEvents = Helpers.layOut(entries: entriesForDay)
                ForEach(layedoutEvents) { item in
                    let entry = item.entry
                    let durationInHours = entry.endTime.timeIntervalSince(entry.startTime) / 3600.0
                    let columnWidth = (geometry.size.width - ViewConstants.hourLabelWidth) / Double(item.totalColumns)
                    let startHourFromMidnight = entry.startTime.timeIntervalSince(Calendar.current.startOfDay(for: entry.startTime)) / 3600.0
                    VStack {
                        Text("\(entry.job.name)")
                        Text("\(entry.startTime.formatted(date: .omitted, time: .shortened)) to \(entry.endTime.formatted(date: .omitted, time: .shortened))")
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 4.0)
                            .fill(.blue)
                    )
                    .frame(width: columnWidth, height: durationInHours * ViewConstants.hourHeight)
                    .offset(x: ViewConstants.hourLabelWidth + (item.columnIndex * Double(columnWidth)),
                            y: startHourFromMidnight * ViewConstants.hourHeight)
                    
                }
            }
        }
    }
}

#Preview {
    EventLayerView(date: Date())
}
