//
//  WorkTrackerApp.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import SwiftData

@main
struct WorkTrackerApp: App {
    @State var viewModel = HourLoggerViewModel()
    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: viewModel)
        }
        .modelContainer(for: [Job.self, WorkEntry.self])
    }
}
