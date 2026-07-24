//
//  MainTabView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct MainTabView: View {
    @Bindable var viewModel: HourLoggerViewModel
    var body: some View {
        TabView {
            HourLogger(viewModel: viewModel)
                .tabItem {
                    Label("Log Hours", systemImage: "timer")
                }
                .tag(TabIdentifier.timer)
            DayView(day: Date())
                .tabItem {
                    Label("Day view", systemImage: "calendar.day.timeline.leading")
                }
            History(viewModel: viewModel)
                .tabItem {
                    Label("History", systemImage: "chart.line.text.clipboard.fill")
                }
                .tag(TabIdentifier.timer)
        }
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    MainTabView(viewModel: viewModel)
}
