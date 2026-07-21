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

    var body: some View {
        NavigationStack {
            VStack {
                Header(viewModel: viewModel)
                List {
                    ForEach(viewModel.entries) { entry in
                        Text("Entry!")
                    }
                    .onDelete(perform: deleteEntries)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isShowingAddJobAlert = true
                    }) {
                        Label("New job", systemImage: "plus")
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
