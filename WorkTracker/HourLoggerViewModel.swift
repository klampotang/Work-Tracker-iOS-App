//
//  HourLoggerViewModel.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import Foundation

@Observable
class HourLoggerViewModel {
    // State for work logger
    var entries: [WorkEntry] = WorkEntry.mockEntries()
    var jobInput: String = ""
    var selectedJobId: UUID? = nil
}
