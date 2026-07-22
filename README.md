# WorkTracker

A native iOS app for tracking hours worked across multiple jobs. Built with SwiftUI.

## Features

- **Start / Stop Timer** — tap Start to begin logging time against a selected job, then Stop to save the entry automatically.
- **Manual Entry** — add past work sessions by picking a custom start and end date/time via a bottom sheet.
- **Multiple Jobs** — create and manage as many jobs as you need; switch the active job from the header picker.
- **Entry List** — browse all logged sessions grouped by date. Swipe to delete individual entries. Filter the list by job using the toolbar menu.
- **History Chart** — visualise total hours worked over the last week, 3 months, or year using a native SwiftUI bar chart. Filter by job using the segmented picker.
- **Stop Animation** — a Lottie animation plays as a celebratory overlay when you stop the timer, then automatically dismisses itself.

## Project Structure

```
WorkTracker/
├── WorkTrackerApp.swift          # App entry point
├── Constants.swift               # Tab identifiers
├── Helpers.swift                 # Formatting & grouping utilities
├── Models/
│   ├── Job.swift                 # Job model (@Model — persisted via SwiftData)
│   ├── WorkEntry.swift           # Work session model (@Model — persisted via SwiftData)
│   └── HourLoggerViewModel.swift # Observable view model (transient UI state)
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
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 03" src="https://github.com/user-attachments/assets/dd847fcc-615c-4d80-ae5e-a2652149b63b" />
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 29" src="https://github.com/user-attachments/assets/e3a8a412-4851-4ad7-8a32-9ee610abe7d4" />
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 23" src="https://github.com/user-attachments/assets/40d39105-0d5a-4a66-85a1-ffc1df530ff0" />
<img width="300" alt="Simulator Screenshot - iPhone 17 Pro - 2026-07-21 at 19 58 17" src="https://github.com/user-attachments/assets/d7df41d6-cc3b-4d7c-8883-271a79ca4583" />


## Persistence

Jobs and work entries are persisted across app launches using **SwiftData** (iOS 17+). The store is set up automatically — no configuration required.

- `Job` and `WorkEntry` are `@Model` classes managed by SwiftData.
- Each view fetches live data via `@Query`, so the UI updates automatically whenever the store changes.
- Writes (adding jobs, logging hours, manual entries, deletions) go through `ModelContext`, which is injected via the SwiftUI environment from the root `ModelContainer`.

## Requirements

- Xcode 16+
- iOS 18+

## Dependencies

| Package | Purpose |
|---------|---------|
| [Lottie for iOS](https://github.com/airbnb/lottie-ios) | Plays the `.lottie` animation overlay when the timer is stopped |

## Getting Started

1. Clone the repository.
2. Open `WorkTracker.xcodeproj` in Xcode.
3. Xcode will automatically resolve the **Lottie** Swift package dependency on first open (requires an internet connection).
4. Select a simulator or connected device and press **Run** (⌘R).
