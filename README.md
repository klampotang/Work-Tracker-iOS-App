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
## Screenshots
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 29" src="https://github.com/user-attachments/assets/e3a8a412-4851-4ad7-8a32-9ee610abe7d4" />
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 23" src="https://github.com/user-attachments/assets/40d39105-0d5a-4a66-85a1-ffc1df530ff0" />
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 17" src="https://github.com/user-attachments/assets/d7df41d6-cc3b-4d7c-8883-271a79ca4583" />
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 03" src="https://github.com/user-attachments/assets/dd847fcc-615c-4d80-ae5e-a2652149b63b" />


## Requirements

- Xcode 16+
- iOS 18+

## Getting Started

1. Clone the repository.
2. Open `WorkTracker.xcodeproj` in Xcode.
3. Select a simulator or connected device and press **Run** (⌘R).

No external dependencies or package manager setup required — the project uses only Apple frameworks (SwiftUI, Charts, Foundation).
