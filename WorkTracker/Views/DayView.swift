//
//  DayView.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/23/26.
//

import SwiftUI

struct DayView: View {
    var day: Date

    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                HourLayerView()
                EventLayerView(date: day)
            }
        }
    }
}
