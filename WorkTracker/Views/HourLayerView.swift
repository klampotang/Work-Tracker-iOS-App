//
//  HourLayerView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/23/26.
//

import SwiftUI

struct HourLayerView: View {
    @Bindable var viewModel: HourLoggerViewModel

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<24) { index in
                HStack {
                    Text("\(Helpers.hourFormatter(for: index))")
                        .frame(width: ViewConstants.hourLabelWidth, alignment: .leading)
                    VStack {
                        Divider()
                        Spacer()
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.clearSelectedEntry()
                }
                .frame(height: ViewConstants.hourHeight, alignment: .leading)
            }
        }
    }
}
