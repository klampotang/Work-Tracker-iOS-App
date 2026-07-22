//
//  HourLogger.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct HourLogger: View {
    @Bindable var viewModel: HourLoggerViewModel
    @State private var isShowingAddJobAlert: Bool = false
    @State private var newJobName: String = ""
    @State private var jobFilterId: UUID? = nil
    
    private var filteredEntries: [WorkEntry] {
        guard let jobFilterId = jobFilterId else {
            return viewModel.entries
        }
        return viewModel.entries.filter {
            $0.job.id == jobFilterId
        }
    }
    var body: some View {
        NavigationStack {
            VStack {
                Header(viewModel: viewModel)
                Divider()
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                List {
                    ForEach(filteredEntries) { entry in
                        VStack(alignment: .leading) {
                            Text(entry.job.name)
                            Text(Helpers.formattedRunningTime(from: entry.startTime, entry.endTime))
                                .multilineTextAlignment(.leading)
                                .font(.caption)
                        }
                    }
                    .onDelete(perform: deleteEntries)
                }
                .scrollContentBackground(.hidden)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isShowingAddJobAlert = true
                    }) {
                        Label("New job", systemImage: "plus")
                    }
                }
                if !viewModel.jobs.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            ForEach(viewModel.jobs) { job in
                                Button(job.name, action: {
                                    jobFilterId = job.id
                                })
                            }
                        } label: {
                            Image(systemName: "line.3.horizontal.decrease")
                        }
                    }
                }
            }
            .alert("Add job", isPresented: $isShowingAddJobAlert) {
                TextField("Add job", text: $newJobName)
                Button("Cancel", role: .cancel) {
                    newJobName = ""
                }
                Button("Okay") {
                    viewModel.addJob(newJobName)
                    newJobName = ""
                }
                .disabled(newJobName.isEmpty)
            }
            .navigationTitle("Work Tracker")
        }
    }
    
    private func deleteEntries(at offsets: IndexSet) {
        viewModel.entries.remove(atOffsets: offsets)
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    HourLogger(viewModel: viewModel)
}
