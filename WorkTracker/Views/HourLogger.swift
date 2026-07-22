//
//  HourLogger.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import SwiftData
import Lottie

struct HourLogger: View {
    @Bindable var viewModel: HourLoggerViewModel
    @Query(sort: \WorkEntry.startTime, order: .reverse) var entries: [WorkEntry]
    @Query var jobs: [Job]
    @Environment(\.modelContext) private var modelContext
    @State private var isShowingAddJobAlert: Bool = false
    @State private var newJobName: String = ""

    private var filteredEntries: [WorkEntry] {
        viewModel.filteredEntries(entries)
    }

    private var groupedEntries: [(date: Date, entries: [WorkEntry])] {
        return Helpers.groupedEntries(filteredEntries)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Header(viewModel: viewModel)
                    Divider()
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    List {
                        ForEach(groupedEntries, id: \.date) { group in
                            Section(header: Text(group.date, style: .date)) {
                                ForEach(group.entries) { entry in
                                    EntriesView(entry: entry)
                                }
                                .onDelete { offsets in
                                    for offset in offsets {
                                        modelContext.delete(group.entries[offset])
                                    }
                                }
                            }
                        }
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
                    if !jobs.isEmpty {
                        ToolbarItem(placement: .topBarTrailing) {
                            Menu {
                                Button("All") {
                                    viewModel.jobFilterId = nil
                                }
                                ForEach(jobs) { job in
                                    Button(job.name) {
                                        viewModel.jobFilterId = job.id
                                    }
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
                        viewModel.addJob(newJobName, context: modelContext)
                        newJobName = ""
                    }
                    .disabled(newJobName.isEmpty)
                }
                .navigationTitle("Work Tracker")
                
                if viewModel.showAnimationOverlay, let animationURL = URL(string: "https://lottie.host/11e1b452-f8fb-4274-bebd-b5e8f66c5f44/J152g3hOyh.lottie") {
                    LottieView {
                        try await DotLottieFile.loadedFrom(url: animationURL)
                    }
                    .playing(loopMode: .playOnce)
                    .animationSpeed(2.0)
                    .animationDidFinish { _ in
                        // Triggered automatically when the single loop completes
                        withAnimation(.easeOut(duration: 0.3)) {
                            viewModel.showAnimationOverlay = false
                        }
                    }
                    .resizable()
                    .frame(width: 120, height: 120)
                }
            }
            .sheet(isPresented: $viewModel.isShowingManualEntryView) {
                ManualEntryView(viewModel: viewModel)
                    .presentationDetents([.height(280)])
                    .presentationDragIndicator(.visible)
            }
            .transition(.opacity)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Job.self, WorkEntry.self, configurations: config)
    let job = Job(name: "Meta")
    container.mainContext.insert(job)
    return HourLogger(viewModel: HourLoggerViewModel())
        .modelContainer(container)
}
