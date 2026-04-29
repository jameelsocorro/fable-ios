# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project State

Levi is a **pre-launch, very early-stage iOS app**. The Xcode project currently contains only the default SwiftUI + SwiftData template scaffolding (`Item` model, list-based `ContentView`). None of the actual product features (quests, streaks, tap-and-hold completion, heatmap, etc.) have been built yet. When implementing features, expect to replace template code rather than extend it.

The PRD (`docs/prd.md`) is the source of truth for what gets built. Read it before designing features — the product has strong opinions (tap-and-hold as the only completion gesture, "don't miss twice" grace day for streaks, platform-first onboarding, platform-specific fixed quests color-coded by social platform) that should not be silently dropped or generalized.

## Tech Stack

- **Language:** Swift 5
- **UI:** SwiftUI
- **Persistence:** SwiftData (single `ModelContainer` set up in `LeviApp.swift`, injected via `.modelContainer` modifier)
- **Deployment target:** iOS 26.4
- **Test frameworks:** Swift Testing (`LeviTests`) for unit tests, XCTest (`LeviUITests`) for UI tests
- **Device family:** Universal in the project file, but the PRD scopes MVP to iPhone only — design and test for iPhone first

## Build, Run, and Test

The project lives at `Levi/Levi.xcodeproj`. There is no Swift Package Manager manifest, no fastlane, no CI config — Xcode is the build system.

```bash
# Build for iOS Simulator (replace destination as needed)
xcodebuild -project Levi/Levi.xcodeproj -scheme Levi \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build

# Run unit tests (Swift Testing framework)
xcodebuild -project Levi/Levi.xcodeproj -scheme Levi \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' test \
  -only-testing:LeviTests

# Run UI tests (XCTest)
xcodebuild -project Levi/Levi.xcodeproj -scheme Levi \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' test \
  -only-testing:LeviUITests

# Run a single Swift Testing test
xcodebuild ... -only-testing:LeviTests/LeviTests/example
```

For day-to-day work, opening `Levi/Levi.xcodeproj` in Xcode and using ⌘R / ⌘U is the expected workflow.

## Architecture

**Entry point:** `Levi/Levi/LeviApp.swift` constructs a `ModelContainer` with the app's SwiftData schema (currently just `Item`) and injects it into the SwiftUI environment. As the data model grows (quests, streaks, completions, identity), add new `@Model` types to the `Schema([...])` array there.

**Data flow pattern:** Views read SwiftData via `@Environment(\.modelContext)` + `@Query` (see `ContentView.swift` for the canonical pattern). Mutations go through `modelContext.insert` / `modelContext.delete`. Stick to this pattern — do not introduce a separate ViewModel/store layer unless something in the PRD genuinely requires it.

**Where new code goes:** Source files live flat under `Levi/Levi/`. No feature-folder structure exists yet. When the codebase grows beyond a handful of files, organize by feature (e.g., `Quests/`, `Streak/`, `Onboarding/`) rather than by type (`Views/`, `Models/`).

## Reference Documents

These are the load-bearing docs for understanding the product. Read them before making design or product decisions:

- **`docs/prd.md`** — Product requirements. Defines MVP scope, the 14 design principles (tap-and-hold mechanic, platform-first onboarding, platform-specific fixed quests, grace-day streaks, etc.), the build order, and what is explicitly out of scope. Treat the design principles as constraints, not suggestions.
- **`DESIGN.md`** — Design system tokens (colors, typography, spacing, radii, components, motion). Uses a "Unified Glass Design System" with warm sage / sand / earthy brown brand colors and dual-theme (light/dark) support. Brand colors are constant across themes; only environmental tokens (backgrounds, surfaces, text, borders) adapt.
- **`docs/references/atoms/`** — Screenshots of the Atoms app, which is the primary UX inspiration for Levi (per the PRD). When unsure how an interaction should feel, consult these.
- **`.agents/product-marketing-context.md`** — Positioning, target audience, brand voice, customer language. Used by marketing skills (`/copywriting`, `/launch-strategy`, etc.). Note: it is explicitly marked pre-launch and most sections are hypothesized — do not treat its testimonials, metrics, or persona quotes as validated facts.

## Product Principles That Shape Implementation

A few PRD principles are easy to violate without realizing it:

- **Tap-and-hold is the only completion gesture.** Skip is a separate swipe/button. Do not add a tap-to-complete shortcut.
- **One completed quest per day keeps the streak alive.** The other 2-5 quests on screen are optional variety, not a checklist.
- **"Don't miss twice."** One missed day uses the grace day; only two consecutive misses reset the streak. This is a deliberate anti-shame design — do not "fix" it to be stricter.
- **No auto-posting.** The draft helper copies to clipboard and the user posts manually. Platform integrations are out of scope for MVP.
- **Quests must feel completable in 5 minutes or less,** including writing the post.

## What's Out of Scope (per PRD)

The following are explicit post-MVP features (do not accidentally start building them in MVP work): Founder XP, Founder Notes (daily journaling), AI content reframing, draft helper / templates, identity-first onboarding question, Academy / Learn tab, Apple Watch app, widgets, web dashboard, Pro / freemium tier. Also out of roadmap entirely: badges, boss battles, public profiles, social feed, auto-posting, calendar scheduling, markdown vault, team features, deep platform integrations.

## Tool & Git Workflow (Superpowers Override)

When using the `superpowers` tool or any other filesystem/Git tool to create design files, write code, or modify the project, you MUST adhere to the following strict rules:

- **No Branching:** DO NOT create new Git worktrees or branches. Always stay on the current active branch.
- **No Committing:** DO NOT run `git commit`.
- **No Pushing:** DO NOT push changes to remote repositories.
- **Direct File Writing:** ALWAYS write or modify files directly in the current working directory.
- **Manual Review:** Leave all modifications uncommitted in the working tree so I can review, test, and commit them manually.
- **Manual Verification:** Do NOT run project build or test commands by default. Leave build and test verification to the user unless they explicitly ask you to run it.
- **Design & Implementation Docs:** ALWAYS read and follow the `swiftui-pro` skill when creating design docs or implementation plans.
