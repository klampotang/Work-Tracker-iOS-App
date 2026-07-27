//
//  EntriesListView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/24/26.
//

import SwiftUI
import SwiftData

struct EntriesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var viewModel: HourLoggerViewModel

    private func deleteEntries(at offsets: IndexSet, in entries: [WorkEntry]) {
        for offset in offsets {
            let entryToDelete = entries[offset]
            modelContext.delete(entryToDelete)
        }
    }
    
    var groupedEntries: [(date: Date, entries: [WorkEntry])]

    var body: some View {
        List {
            ForEach(groupedEntries, id: \.date) { group in
                Section(header: DaySectionHeader(date: group.date, viewModel: viewModel)) {
                    ForEach(group.entries, id: \.id) { entry in
                        EntriesView(entry: entry)
                    }
                    .onDelete { offset in
                        deleteEntries(at: offset, in: group.entries)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
