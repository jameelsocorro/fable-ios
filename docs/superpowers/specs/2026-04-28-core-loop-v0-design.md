# Fable Core Loop v0 Design

Date: 2026-04-28
Status: Approved design, pending implementation plan

## Summary

Core Loop v0 replaces the default SwiftUI template with Fable's first real product slice: a Today screen with five deterministic daily quests, tap-and-hold completion, skip support, inline draft help, and basic streak tracking with the PRD's "don't miss twice" grace rule.

This slice is a durable product foundation, not a throwaway prototype. It uses SwiftData for persisted state, hardcoded quest definitions for the initial catalog, and small testable business-rule units for daily selection and streak calculation.

## Goals

- Open directly to a real Today experience.
- Show exactly five daily quests, one from each PRD quest category.
- Make tap-and-hold on the colored quest circle the only completion gesture.
- Let copy/draft help exist independently from completion.
- Track completion, skip state, current streak, longest streak, and grace/reset behavior.
- Seed a default founder profile so onboarding can be added later without reshaping the data model.
- Keep the UI calm, founder-specific, and aligned with the Unified Glass Design System.

## Non-Goals

- No onboarding flow in this slice.
- No separate Streak, History, Draft Helper, or Settings screens.
- No XP, badges, lessons, widgets, Apple Watch, subscriptions, public profiles, social feed, AI writing, or auto-posting.
- No platform integrations beyond copying rendered draft text to the clipboard.
- No full heatmap UI yet, although the data should preserve daily completion counts for a later heatmap.

## Chosen Approach

Use a SwiftData-first Today core.

The app should persist founder profile defaults, daily quest rows, status changes, and streak summary state. The quest catalog remains code-defined, because the PRD calls for a static quest system first and there is no server or content management requirement. Business rules should be kept outside large SwiftUI body blocks so they can be unit tested and later reused by Streak and History screens.

Alternative approaches were rejected for this slice:

- A logic-first foundation would be clean and testable, but delays the product screen.
- A full navigation shell would create placeholder screens before the Today loop is validated.

## Project Structure

Move away from the starter app's flat template as real product code appears.

Recommended groups:

- `DesignSystem/`: color tokens, typography helpers, surfaces, glass styling, and shared component modifiers.
- `Profile/`: founder profile model and default seed behavior.
- `Quests/`: quest type definitions, quest catalog, daily selector, materialization logic, Today UI, quest cards, hold circle, and draft helper.
- `Streaks/`: streak record model, streak calculator, and summary display.

The current template `Item` model and list-based `ContentView` should be replaced during implementation.

## SwiftData Models

### FounderProfile

One seeded row represents the current user until onboarding exists.

Default values:

- `projectName`: `"Your app"`
- `founderIdentity`: `"visible builder"`
- `productStage`: `"building"`
- `preferredPlatforms`: `["X", "LinkedIn"]`

Onboarding will later edit this row instead of requiring a new profile storage concept.

### QuestDefinition

`QuestDefinition` is not persisted. It is a stable code-defined catalog item.

Fields:

- stable id
- quest type
- title template
- description template
- fallback prompt
- draft template
- suggested platform
- estimated minutes

The templates may reference profile fields such as project name and founder identity.

### DailyQuest

`DailyQuest` is persisted for a specific local calendar day.

Fields:

- id
- local date key
- quest definition id
- quest type
- rendered title
- rendered description
- rendered fallback prompt
- rendered draft template
- suggested platform
- display order
- status: available, completed, skipped
- completed timestamp
- skipped timestamp

`DailyQuest` is the source of truth for completion and skip state in v0. A separate completion event model is intentionally deferred until analytics, detailed history, or undo/audit behavior requires it.

### StreakSnapshot

`StreakSnapshot` stores the current persisted streak summary.

Fields:

- current streak
- longest streak
- last completed local date key
- grace state
- updated timestamp

The snapshot is derived from persisted quest completions and can be recalculated when needed.

## Daily Quest Selection

Each local calendar day gets exactly five quests:

1. Share Progress
2. Behind-the-Scenes
3. Learning
4. Audience-Building
5. Launch/Reflection

Selection is deterministic. For a given date and category, the selector chooses a quest from the static catalog using the local date key and category index. This means the same date always produces the same set, tests can assert exact behavior, and the app avoids random duplicate materialization.

On first launch for a day, the app materializes the five selected quests as `DailyQuest` rows if they do not already exist. If rows already exist for that date, they are reused so completion and skip state remain stable.

## Today Screen

Today is the only primary screen in v0.

Top area:

- current streak
- longest streak
- calm grace status text based on "don't miss twice"

Quest area:

- five vertically stacked quest cards
- one card per quest category
- color-coded hold circle
- quest type label
- title
- short description
- suggested platform
- fallback prompt
- compact draft template and copy action

The draft helper lives inline. The user should not navigate away from Today to copy or use a template.

## Completion Interaction

The only way to complete a quest is to press and hold the colored quest circle.

Behavior:

- Hold starts filling an inner circle toward the outer boundary.
- Releasing early cancels without changing status.
- Reaching full marks the quest complete.
- Completion triggers haptic feedback.
- Completion triggers a small visual reward such as a burst or color pulse.
- The streak recalculates after completion.
- A normal tap does not complete the quest.

Completed quests no longer show the skip action.

## Skip Interaction

Skip is separate from completion.

In v0, each available quest card has a clearly secondary skip button. Swipe-to-skip can be added later, but the explicit button keeps the first implementation straightforward and accessible.

Skipped quests do not count toward the streak.

## Draft Helper

Each quest includes a rendered draft template and a copy action.

Copying a draft:

- writes the rendered template to the system clipboard
- does not complete the quest
- does not unlock or gate the hold interaction

This supports both valid user interpretations from the PRD risk section: "posted it" and "drafted it" can both be honored by the user's intentional completion gesture without requiring Fable to verify external posting.

## Streak Rules

The streak rule is local-calendar-day based:

- At least one completed quest on a local calendar day keeps the streak alive.
- Additional completions on the same day do not increase the streak by more than one.
- Additional completions should remain countable for future heatmap intensity.

States, evaluated against today's local date:

- Active: the user completed at least one quest today, or the last completed day was yesterday and today is still available.
- Grace: the last completed day was two calendar days ago, meaning yesterday was missed and completing a quest today preserves the streak.
- Reset: the last completed day was three or more calendar days ago, meaning two consecutive full local calendar days were missed and current streak resets to 0.

When the first quest of a day is completed, the calculator updates current streak and longest streak. Completing more quests that day leaves the streak count unchanged. If the app was not opened for several days, launch or completion should recalculate streak state from persisted completions.

Longest streak never decreases.

## Date Handling

Use local calendar day keys, not raw 24-hour windows.

Daily quest materialization, completion grouping, grace handling, and reset behavior all operate on local dates. This matches user expectations for a daily habit app and prevents confusing resets based on exact timestamps.

## Visual And Accessibility Requirements

The UI should follow the Unified Glass Design System:

- warm sage, sand, and earthy brown as brand colors
- restrained glass surfaces
- bounded content width appropriate for iPhone
- generous but not wasteful spacing
- no noisy dashboard chrome on the Today screen

Quest colors must be category-specific and visually distinct. Because category meaning cannot rely on color alone, every quest also needs a text label and/or icon.

Accessibility requirements:

- Respect Dynamic Type.
- Respect Reduce Motion by replacing large bursts with simpler fill or opacity feedback.
- Ensure the hold circle exposes a useful VoiceOver label and action.
- Do not make tap completion available as an accessibility shortcut; accessibility completion should still represent an intentional complete action, such as a named custom action if long-press is not practical through assistive tech.
- Keep skip and copy as real buttons with readable labels.

## Error Handling

If daily quest materialization fails, the Today screen should show a recoverable empty/error state rather than a blank screen.

If clipboard copy fails or is unavailable, show non-blocking feedback and leave quest completion unaffected.

If streak snapshot data becomes inconsistent, recalculate from persisted `DailyQuest` completion dates and overwrite the snapshot.

## Testing Plan

Unit tests should cover:

- daily selector returns exactly five quests
- selector returns one quest per category
- selector is deterministic for a fixed local date
- materialization reuses existing daily quests and does not duplicate rows
- completion changes status and sets `completedAt`
- completion updates streak only once per day
- copying a draft is independent from completion
- skip does not count toward streak
- first completion creates an active streak
- next-day completion continues the streak
- one missed day enters or preserves grace without reset
- two missed days reset current streak
- longest streak is preserved across resets

UI tests should stay light in v0:

- launch app
- verify Today appears
- verify five quest cards appear
- verify completion control, skip button, and copy action exist

Long-press animation should be validated manually or through focused component tests only if a stable automation surface exists. Avoid brittle UI tests that depend on animation timing.

## Verification

Implementation should be verified with Xcode's build and test flow against an available iPhone simulator.

Preferred commands:

```bash
xcodebuild -project Fable/Fable.xcodeproj -scheme Fable \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build

xcodebuild -project Fable/Fable.xcodeproj -scheme Fable \
  -destination 'platform=iOS Simulator,name=iPhone 16 Pro' test \
  -only-testing:FableTests
```

If that simulator is unavailable, use another available iPhone simulator and record the exact destination.

## Implementation Boundaries

Keep business rules small and testable:

- daily selection should be independent from SwiftUI rendering
- streak calculation should be independent from the Today view
- quest rendering should accept profile defaults and catalog definitions
- SwiftUI views should focus on layout, interaction, and presentation

Avoid adding a broad app-wide store layer in this slice. SwiftData queries and `modelContext` mutations are sufficient for the current scope.
