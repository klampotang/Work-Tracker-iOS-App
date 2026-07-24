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
                VStack {
                    Text("\(entry.job.name)")
                    Text("\(entry.startTime) to \(entry.endTime)")
                }
            }
        }
    }
}

#Preview {
    
    EventLayerView(date: Date())
}
