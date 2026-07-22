//
//  JobPicker.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct JobPicker: View {
    @Bindable var viewModel: HourLoggerViewModel

    var body: some View {
        Picker("Job", selection: $viewModel.selectedJobId) {
            ForEach(viewModel.jobs) { job in
                Text("\(job.name)").tag(job.id as UUID?)
            }
        }
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    JobPicker(viewModel: viewModel)
}
