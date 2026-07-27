//
//  DayView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/23/26.
//

import SwiftUI

struct DayView: View {
    var day: Date
    @Bindable var viewModel: HourLoggerViewModel

    var body: some View {
        VStack(spacing: 0) {
            DayViewHeader(viewModel: viewModel)
            ScrollView {
                ZStack(alignment: .topLeading) {
                    HourLayerView(viewModel: viewModel)
                    EventLayerView(date: day, viewModel: viewModel)
                }
                .frame(height: 24 * ViewConstants.hourHeight)
            }
            .navigationTitle("Day View")
        }
    }
}
