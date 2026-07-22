# WorkTracker

A native iOS app for tracking hours worked across multiple jobs. Built with SwiftUI.

## Features

- **Start / Stop Timer** — tap Start to begin logging time against a selected job, then Stop to save the entry automatically.
- **Manual Entry** — add past work sessions by picking a custom start and end date/time via a bottom sheet.
- **Multiple Jobs** — create and manage as many jobs as you need; switch the active job from the header picker.
- **Entry List** — browse all logged sessions grouped by date. Swipe to delete individual entries. Filter the list by job using the toolbar menu.
- **History Chart** — visualise total hours worked over the last week, 3 months, or year using a native SwiftUI bar chart. Filter by job using the segmented picker.

## Project Structure

```
WorkTracker/
├── WorkTrackerApp.swift          # App entry point
├── Constants.swift               # Tab identifiers
├── Helpers.swift                 # Formatting & grouping utilities
├── Models/
│   ├── Job.swift                 # Job model
│   ├── WorkEntry.swift           # Work session model
│   └── HourLoggerViewModel.swift # Observable view model (shared state)
└── Views/
    ├── MainTabView.swift         # Root tab container
    ├── Header.swift              # Start/stop controls & job picker
    ├── HourLogger.swift          # Log Hours tab
    ├── History.swift             # History tab with bar chart
    ├── ManualEntryView.swift     # Manual entry bottom sheet
    ├── JobPicker.swift           # Reusable job selector
    └── EntriesView.swift         # Individual entry row
```

## Requirements

- Xcode 16+
- iOS 18+

## Getting Started

1. Clone the repository.
2. Open `WorkTracker.xcodeproj` in Xcode.
3. Select a simulator or connected device and press **Run** (⌘R).

No external dependencies or package manager setup required — the project uses only Apple frameworks (SwiftUI, Charts, Foundation).
