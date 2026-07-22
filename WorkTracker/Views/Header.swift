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
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .disabled(viewModel.selectedJobId == nil)
                .font(.title2)
                .foregroundColor(.white)
            
                if let startTime = viewModel.startTime {
                    Text(startTime, style: .timer)
                        .font(.system(.title, design: .rounded))
                        .monospacedDigit()
                        .foregroundStyle(.blue)
                }
            
                Button("Stop log") {
                    viewModel.stopTrackingJob()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .disabled(viewModel.startTime == nil)
                .font(.title2)
                .foregroundColor(.white)
            }
            .padding(.horizontal, 10)
            
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
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    Header(viewModel: viewModel)
}
