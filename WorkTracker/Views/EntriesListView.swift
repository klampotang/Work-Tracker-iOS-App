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
    @State private var itemToDelete: WorkEntry? = nil
    @Bindable var viewModel: HourLoggerViewModel

    private func delete(entry: WorkEntry) {
        modelContext.delete(entry)
    }
    
    var groupedEntries: [(date: Date, entries: [WorkEntry])]

    var body: some View {
        List {
            ForEach(groupedEntries, id: \.date) { group in
                Section(header: DaySectionHeader(date: group.date, viewModel: viewModel)) {
                    ForEach(group.entries, id: \.id) { entry in
                        EntriesView(entry: entry)
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button {
                                    itemToDelete = entry
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                    }
                    .alert("Delete item?", item: $itemToDelete) { entry in
                        Button("Delete", role: .destructive) {
                            delete(entry: entry)
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: { _ in
                        Text("Are you sure you want to delete this entry?")
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}
