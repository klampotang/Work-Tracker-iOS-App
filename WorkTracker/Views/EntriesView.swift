//
//  EntriesView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct EntriesView: View {
    var entry: WorkEntry
    var body: some View {
        VStack(alignment: .leading) {
            Text(entry.job.name)
            Text(Helpers.formattedRunningTime(from: entry.startTime, entry.endTime))
                .multilineTextAlignment(.leading)
                .font(.caption)
        }
    }
}
