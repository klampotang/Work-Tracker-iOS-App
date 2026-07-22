//
//  History.swift
//  WorkTracker
//
//  Created by Kelly Lampotang on 7/21/26.
//

import SwiftUI
import Charts

// 1. Time Range Options
enum TimeRange: String, CaseIterable, Identifiable {
    case week = "Last Week"
    case month3 = "3 Months"
    case year = "Last Year"
    
    var id: String { rawValue }
}

// 2. Data point struct for the chart
struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let hours: Double
}

struct History: View {
    @Bindable var viewModel: HourLoggerViewModel
    @State private var selectedRange: TimeRange = .week

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                // Segmented Picker for switching timeline
                Picker("Time Range", selection: $selectedRange.animation()) {
                    ForEach(TimeRange.allCases) { range in
                        Text(range.rawValue).tag(range)
                    }
                }
                .pickerStyle(.segmented)
                
                // Header summary
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total Hours")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text("\(totalHours, specifier: "%.1f") hrs")
                        .font(.title2)
                        .bold()
                }
                
                // The Dynamic Bar Chart
                Chart(chartData) { point in
                    BarMark(
                        x: .value("Date", point.date, unit: dateComponentUnit),
                        y: .value("Hours", point.hours)
                    )
                    .foregroundStyle(.blue.gradient)
                    .cornerRadius(4)
                }
                .chartXAxis {
                    AxisMarks(values: chartData.map(\.date)) { value in
                        AxisGridLine()
                        AxisValueLabel(format: xAxisFormatStyle)
                    }
                }
                .chartYAxis {
                    AxisMarks { value in
                        AxisGridLine()
                        AxisValueLabel()
                    }
                }
                .frame(height: 220)
                VStack {
                    Text("Filter by job:")
                        .bold()
                    Picker("Job", selection: $viewModel.jobFilterId) {
                        Text("All").tag(nil as UUID?)
                            .font(.caption)
                        ForEach(viewModel.jobs) { job in
                            Text(job.name).tag(job.id as UUID?)
                        }
                        .font(.caption)
                    }
                    .pickerStyle(.segmented)
                }
                Spacer()
            }
            .navigationTitle("History")
            .padding()
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }

    // MARK: - Helper Calculations

    /// Total sum of hours for the selected period
    private var totalHours: Double {
        chartData.reduce(0) { $0 + $1.hours }
    }

    /// Determines the unit granularity for the X-axis
    private var dateComponentUnit: Calendar.Component {
        switch selectedRange {
        case .week: return .day
        case .month3: return .weekOfYear
        case .year: return .month
        }
    }

    /// Date formatting for X-axis labels
    private var xAxisFormatStyle: Date.FormatStyle {
        switch selectedRange {
        case .week:
            return .dateTime.weekday(.abbreviated) // e.g. "Mon", "Tue"
        case .month3:
            return .dateTime.month(.abbreviated).day() // e.g. "Jul 12"
        case .year:
            return .dateTime.month(.abbreviated) // e.g. "Jan", "Feb"
        }
    }

    /// Filters and groups `entries` by the selected date range
    private var chartData: [ChartDataPoint] {
        let calendar = Calendar.current
        let now = Date()
        
        // 1. Determine start date limit
        let startDate: Date = {
            switch selectedRange {
            case .week:
                return calendar.date(byAdding: .day, value: -7, to: now) ?? now
            case .month3:
                return calendar.date(byAdding: .month, value: -3, to: now) ?? now
            case .year:
                return calendar.date(byAdding: .year, value: -1, to: now) ?? now
            }
        }()
        
        // 2. Filter entries within range
        let filteredEntries = viewModel.filteredEntries.filter { $0.startTime >= startDate && $0.startTime <= now }
        
        // 3. Group by Day, Week, or Month
        let grouped = Dictionary(grouping: filteredEntries) { entry in
            switch selectedRange {
            case .week:
                return calendar.startOfDay(for: entry.startTime)
            case .month3:
                let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: entry.startTime)
                return calendar.date(from: components) ?? entry.startTime
            case .year:
                let components = calendar.dateComponents([.year, .month], from: entry.startTime)
                return calendar.date(from: components) ?? entry.startTime
            }
        }
        
        // 4. Sum hours per group & sort chronologically
        return grouped.map { (date, groupEntries) in
            let totalSeconds = groupEntries.reduce(0) { $0 + $1.endTime.timeIntervalSince($1.startTime) }
            return ChartDataPoint(date: date, hours: totalSeconds / 3600.0)
        }.sorted { $0.date < $1.date }
    }
}

#Preview {
    @Previewable var viewModel = HourLoggerViewModel()
    History(viewModel: viewModel)
}
