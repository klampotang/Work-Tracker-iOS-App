//
//  DaySectionHeader.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/24/26.
//
import SwiftUI

struct DaySectionHeader: View {
    let date: Date
    
    var body: some View {
        HStack {
            Text(date.formatted(date: .complete, time: .omitted))
                .font(.headline)
            
            Spacer()
            
            NavigationLink(destination: DayView(day: date)) {
                Label("Day View", systemImage: "calendar.day.timeline.left")
                    .labelStyle(.iconOnly)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .buttonStyle(.borderless)
        }
    }
}
