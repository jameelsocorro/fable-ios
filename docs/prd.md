# Shoyo PRD

*Last updated: 2026-05-03*

## Product Summary

Shoyo is an iPhone-first visibility companion for indie founders and solo builders. It helps them show their work while they build by turning posting into a small daily commitment: choose the social platforms you want to grow on, get concrete platform-specific quests, complete one or more with an intentional plus-button action, and build a streak.

The name is short for "show your work" / "showyowork." That phrase is the product promise: do not wait until launch day to become visible.

## Problem

Indie founders often build privately, postpone distribution until launch, and then ship to silence. They know they should post while building, but daily sharing feels vague, awkward, and easy to delay.

Shoyo does not try to become a full marketing suite. It removes one decision: "Should I show up today, and where?"

## Current Product Direction

Shoyo has moved away from the old Atoms-inspired UX direction. Atoms screenshots can remain historical reference material, but they are no longer the design foundation or source of truth.

The current app direction is:

- **Mascot-led onboarding** — Oreo introduces the habit with a friendly, companion-like feel.
- **Platform orbs** — users choose where they want to build audience by tapping floating social platform orbs.
- **Glass and native iOS surfaces** — light/dark-aware cards, translucent materials where appropriate, radial warmth, and iOS-native motion.
- **Serif-led editorial moments** — large serif headlines give the app a founder-story tone instead of a generic productivity tone.
- **Orange primary accent** — Shoyo uses a warm orange action color, while platform colors are used as contextual feedback.

Design work should follow the SwiftUI components in `Shoyo/Shoyo/Design/` and the current app screens before inventing a new visual system.

## Core Product Principles

1. **Show the work while building.** Shoyo exists to create visibility before launch, not after momentum is gone.
2. **Platform commitment comes first.** The user chooses social platforms first; quests are filtered from those choices.
3. **Quests are concrete publish actions.** "Post a Reel" is better than "share progress." The app should minimize interpretation.
4. **Completion is an intentional manual commit.** The current interaction is a visible plus button that fills the quest card, triggers haptic feedback, and switches to undo. Do not describe or rebuild tap-and-hold as the required mechanic unless the product direction changes again.
5. **One completed quest per day keeps the overall streak alive.** More quests are useful, but the app should not feel like a checklist that punishes users for skipping optional variety.
6. **Don't miss twice.** One missed day is forgiven; two consecutive misses reset the streak. This is an anti-shame retention mechanic.
7. **No auto-posting or external verification.** Shoyo trusts the user. It does not connect to social APIs, verify posts, or publish on the user's behalf.
8. **Fast enough for a busy builder.** A quest should feel doable in about five minutes, including the post itself.
9. **Color supports meaning but is never the only signal.** Platform name, icon, title, and accessibility labels must carry the same information.
10. **iPhone first.** Watch, widgets, and web are post-MVP surfaces.

## Current Implementation State

The app is no longer template scaffolding. Current implemented pieces include:

- **SwiftData persistence** with `FounderProfile` and `QuestCompletion`.
- **Routing** from onboarding to the main app based on the active profile.
- **Onboarding** with a welcome step and platform picker.
- **Platform picker** with floating orbs for Instagram, TikTok, Threads, YouTube, Facebook, LinkedIn, X, Bluesky, and Reddit.
- **Static quest catalog** with quests for Instagram, TikTok, Threads, YouTube, Facebook, LinkedIn, X, Bluesky, and Reddit.
- **Today tab** with a sticky recent-day strip, quest cards filtered to selected platforms, plus-button completion, undo, animated fill, and haptic feedback.
- **Streaks tab** with total completions, current streak, monthly completion rate, a 12-month activity board, and per-quest seven-day strips.
- **Settings tab placeholder** for project, platform, and theme settings.
- **Theme infrastructure** with system/sage/sand/earth/sky/ruby options in code, though the current accent color is still shared.

## MVP Scope

### 1. Onboarding

Current MVP onboarding is intentionally short:

- Welcome screen with Oreo and the "Stop launching in silence" positioning.
- Platform picker with social platform orbs.
- Continue button appears once at least one platform is selected.

Important current gap: the data model supports `projectName`, but there is no active project-name step in onboarding. Future work should either add that step deliberately or remove the unused concept from product copy.

### 2. Platform-Specific Quest Catalog

Quests are fixed definitions in code. They currently include:

| Platform | MVP Quest Examples |
| --- | --- |
| Instagram | Post a Story, Post a Reel, Post to Feed |
| TikTok | Post a TikTok |
| Threads | Post |
| YouTube | Post a Short, Post a Community Update |
| Facebook | Post |
| LinkedIn | Post |
| X | Post |
| Bluesky | Post |
| Reddit | Share in a subreddit |

Only selected platforms show in Today. The picker and catalog intentionally share the same supported platform list for launch.

### 3. Today Tab

The Today tab is the primary habit loop:

- Sticky "Today" header with a selectable recent-day strip.
- Quest cards filtered by selected platforms.
- Each card shows a per-quest streak badge, quest title, platform label, plus action, and undo action after completion.
- Completion fills the card with platform color, triggers haptics, and updates the streak count after the animation.
- Undo removes the selected day's completion and reverses the fill.

The app currently allows selecting recent days and recording a completion against the selected day. Decide before beta whether this is intentional backfill behavior or should be restricted to today.

### 4. Streaks Tab

The Streaks tab currently provides:

- Total completions.
- Current overall streak using the "don't miss twice" rule.
- Current-month completion rate.
- A horizontally scrollable 12-month activity grid where completion count controls intensity.
- Per-quest seven-day strips colored by platform.

The current app does not yet show longest streak, a detailed quest history list, or platform-specific analytics.

### 5. Settings

Settings is currently a placeholder. MVP needs a real settings surface before beta:

- Edit selected platforms.
- Reset local progress.
- Theme selection if themes remain part of the product.
- Optional project name if the app keeps project-specific copy.

## Out of Scope for MVP

Do not build these into the MVP without an explicit product decision:

- Auto-posting or deep social platform integrations.
- AI-written posts, draft generation, or content reframing.
- Content calendar or scheduling.
- Founder XP, badges, levels, boss battles, or public profiles.
- Academy / Learn tab.
- Apple Watch app, widgets, or web dashboard.
- Team features.
- Markdown vault or long-form content management.
- Paid Pro tier gates.

## Near-Term Build Priorities

1. **Settings** — replace the placeholder with platform editing, reset, and any theme controls.
2. **Onboarding decision** — either add a project-name step or remove project-name assumptions from copy and data flow.
3. **Backfill decision** — decide whether selecting past days in Today should allow completing quests for those days.
4. **Streak clarity** — make clear when UI refers to overall streak versus per-quest streak.
5. **Beta polish** — empty states, accessibility labels, reduce-motion paths, and persistence edge cases.

## Launch Positioning

### Emotional Positioning

"Stop launching in silence."

### Core Promise

Pick the platforms you want to grow on. Get one clear posting quest. Show your work today. Keep the streak alive.

### Best Hooks

- "Your app does not have a product problem. It has a silence problem."
- "Build in public before launch day, one quest at a time."
- "A tiny daily commitment to show your work."

### 60-Second Launch Script Outline

1. Hook: "I spent months building my app. I launched it. Nobody cared."
2. Pain: Built in private, no posts, no audience, no momentum.
3. Turning point: What if something told you where to show up today while you were still building?
4. Reveal: Shoyo. Pick the platforms you want to grow on. Get simple daily quests. Tap plus when you show up. Keep the streak alive.
5. Proof: Show onboarding platform orbs, Today quest cards, a completion fill, haptic feedback, and the Streaks board.
6. Close: Your next app does not need to launch to silence.
