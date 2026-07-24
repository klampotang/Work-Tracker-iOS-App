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
        VStack(spacing: 0) {
            ForEach(Helpers.entries(for: date, entries)) { entry in
                let durationInHours = entry.endTime.timeIntervalSince(entry.startTime) / 3600.0
                let startHourFromMidnight = entry.startTime.timeIntervalSince(Calendar.current.startOfDay(for: entry.startTime)) / 3600.0
                VStack {
                    Text("\(entry.job.name)")
                    Text("\(entry.startTime.formatted(date: .omitted, time: .shortened)) to \(entry.endTime.formatted(date: .omitted, time: .shortened))")
                }
                .background(
                    RoundedRectangle(cornerRadius: 4.0)
                        .fill(.blue)
                )
                .frame(width: 200, height: durationInHours * 60.0)
                .offset(x: 60.0,
                        y: startHourFromMidnight * 60.0)
                
            }
        }
    }
}

#Preview {
    EventLayerView(date: Date())
}
