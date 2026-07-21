//
//  Header.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct Header: View {
    @Bindable var viewModel: HourLoggerViewModel
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button("Start log") {
                        // TODO
                    }
                    Spacer()
                    Button("Stop log") {
                        // TODO
                    }
                }
                .padding()
                
                HStack {
                    Picker("Job", selection: $viewModel.selectedJobId) {
                        ForEach($viewModel.jobs) { job in
                            Text(job.name).tag(job.id)
                        }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem
        }
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    Header(viewModel: viewModel)
}
