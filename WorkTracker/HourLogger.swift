//
//  HourLogger.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI

struct HourLogger: View {
    @Bindable var viewModel: HourLoggerViewModel
    var body: some View {
        VStack {
            Header(viewModel: viewModel)
        }
        
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    HourLogger(viewModel: viewModel)
}
