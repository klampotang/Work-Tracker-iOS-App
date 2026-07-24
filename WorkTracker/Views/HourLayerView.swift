//
//  HourLayerView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/23/26.
//

import SwiftUI

struct HourLayerView: View {
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<24) { index in
                HStack {
                    Text("\(Helpers.hourFormatter(for: index))")
                    VStack {
                        Divider()
                        Spacer()
                    }
                }
                .frame(height: 60.0, alignment: .leading)
            }
        }
    }
}
