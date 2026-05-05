# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project State

Orion is a **pre-launch iOS app** for founders, creators, indie hackers, and solopreneurs who want to build an online presence by consistently showing their work. The app is no longer default SwiftUI template scaffolding. It already includes onboarding, platform selection, a static quest catalog, Today and Streaks tabs, SwiftData persistence, and an Orion-native visual direction.

The PRD (`docs/prd.md`) is the source of truth for product direction. Read it before making product or UX decisions. The old Atoms-inspired direction and tap-and-hold completion requirement are no longer current.

## Tech Stack

- **Language:** Swift 5
- **UI:** SwiftUI
- **Persistence:** SwiftData (single `ModelContainer` set up in `OrionApp.swift`, injected via `.modelContainer` modifier)
- **Deployment target:** iOS 26.4
- **Test frameworks:** Swift Testing (`OrionTests`) for unit tests, XCTest (`OrionUITests`) for UI tests
- **Device family:** Universal in the project file, but product work should design and test iPhone first

## Build, Run, and Test

The project lives at `Orion/Orion.xcodeproj`. There is no Swift Package Manager manifest, no fastlane, no CI config — Xcode is the build system.

```bash
# Build for iOS Simulator (replace destination as needed)
xcodebuild -project Orion/Orion.xcodeproj -scheme Orion \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build

# Run unit tests (Swift Testing framework)
xcodebuild -project Orion/Orion.xcodeproj -scheme Orion \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' test \
  -only-testing:OrionTests

# Run UI tests (XCTest)
xcodebuild -project Orion/Orion.xcodeproj -scheme Orion \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' test \
  -only-testing:OrionUITests

# Run a single Swift Testing test
xcodebuild ... -only-testing:OrionTests/OrionTests/example
```

For day-to-day work, opening `Orion/Orion.xcodeproj` in Xcode and using ⌘R / ⌘U is the expected workflow.

## Architecture

**Entry point:** `Orion/Orion/OrionApp.swift` constructs a `ModelContainer` with the SwiftData schema (`FounderProfile`, `QuestCompletion`) and injects it into the SwiftUI environment.

**Routing:** `ContentView` uses `@Query` to load profiles, then `AppRoute` chooses onboarding or the main Today experience.

**Data flow pattern:** Views read SwiftData via `@Environment(\.modelContext)` + `@Query`. Mutations go through `modelContext.insert`, `modelContext.delete`, and `modelContext.save()`. Stick to this pattern unless the PRD creates a real need for a separate state layer.

**Feature structure:** Source is organized by feature under `Orion/Orion/`: `Onboarding/`, `Quests/`, `Today/`, `Streak/`, and `Design/`.

## Reference Documents

- **`docs/prd.md`** — Product requirements and current MVP state. Treat this as the primary source of truth.
- **`.agents/product-marketing-context.md`** — Positioning, target audience, brand voice, and customer language for marketing skills. It is pre-launch context; do not treat hypothesized personas, objections, testimonials, or metrics as validated facts.
- **`Orion/Orion/Design/`** — Current design tokens and shared SwiftUI modifiers. Use these instead of assuming a separate `DESIGN.md` exists.
- **`docs/references/atoms/`** — Historical screenshots only. Do not use Atoms as the current UX foundation unless the user explicitly revives that direction.

## Product Principles That Shape Implementation

- **Show the work while building.** The product exists to help founders, creators, indie hackers, and solopreneurs become visible before launch.
- **Platform commitment comes first.** The user chooses the social platforms they want to grow on; quests filter from those choices.
- **Completion is a manual plus-button commit.** The current app uses a visible plus button, animated fill, haptics, and undo. Do not reintroduce tap-and-hold as a requirement unless explicitly requested.
- **One completed quest per day keeps the overall streak alive.** Optional extra quests add depth but should not feel like punishment.
- **"Don't miss twice."** One missed day is forgiven; two consecutive misses reset the streak.
- **No auto-posting or external verification.** Orion trusts the user and avoids deep platform integrations for MVP.
- **Quests must feel completable in roughly five minutes,** including writing or recording the post.
- **Design is Orion-native.** Guide-led onboarding, floating platform orbs, glassy native surfaces, warm orange accent, and accessible platform signals define the current direction.

## Current Gaps To Respect

- Settings is still a placeholder.
- `FounderProfile.projectName` exists, but onboarding does not currently ask for project name.
- Supported social platforms are intentionally limited to Instagram, TikTok, Threads, YouTube, Facebook, LinkedIn, X, Bluesky, and Reddit.
- Today currently allows selecting recent days; decide deliberately whether this is backfill or should become view-only history.
- Streak UI contains both overall streak and per-quest streak concepts; be explicit about which one a change affects.

## What's Out of Scope

Do not build these into MVP without explicit direction: auto-posting, deep social integrations, AI-written posts, draft generation, content calendar, Founder XP, Academy / Learn tab, Apple Watch app, widgets, web dashboard, paid Pro gates, badges, boss battles, public profiles, team features, markdown vault, or long-form content management.

## Tool & Git Workflow (Superpowers Override)

When using the `superpowers` tool or any other filesystem/Git tool to create design files, write code, or modify the project, you MUST adhere to the following strict rules:

- **No Branching:** DO NOT create new Git worktrees or branches. Always stay on the current active branch.
- **No Committing:** DO NOT run `git commit`.
- **No Pushing:** DO NOT push changes to remote repositories.
- **Direct File Writing:** ALWAYS write or modify files directly in the current working directory.
- **Manual Review:** Leave all modifications uncommitted in the working tree so I can review, test, and commit them manually.
- **Manual Verification:** Do NOT run project build or test commands by default. Leave build and test verification to the user unless they explicitly ask you to run it.
- **Design & Implementation Docs:** ALWAYS read and follow the `swiftui-pro` skill when creating design docs or implementation plans.
