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
        VStack {
            HStack {
                Text("Job:")
                    .foregroundColor(.primary)
                if (viewModel.jobs.isEmpty) {
                    Text("No jobs created")
                        .foregroundColor(.secondary)
                } else {
                    Picker("Job", selection: $viewModel.selectedJobId) {
                        ForEach(viewModel.jobs) { job in
                            Text("\(job.name)").tag(job.id as UUID?)
                        }
                    }
                }
            }
            .padding()

            HStack {
                Button("Start log") {
                    viewModel.startTrackingJob()
                }
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .background(.green)
                .cornerRadius(4)
                
                Spacer()
                Button("Stop log") {
                    viewModel.stopTrackingJob()
                }
                .disabled(viewModel.startTime == nil)
                .font(.title2)
                .foregroundColor(.white)
                .padding(10)
                .background(.red)
                .cornerRadius(4)
            }
            .padding(.horizontal, 4)
            
            Button("Add manual entry") {
                // TODO
            }
            .font(.title3)
            .foregroundColor(.white)
            .padding(5)
            .background(.yellow)
            .cornerRadius(4)
        }
        .padding(.bottom, 10)
        .background(.thinMaterial)
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    Header(viewModel: viewModel)
}
