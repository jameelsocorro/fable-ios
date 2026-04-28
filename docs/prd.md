# Fable

## What It Is

Fable is a gamified accountability companion for indie founders building in public. During onboarding, you pick the social platforms you want to grow on (e.g., Instagram, Threads, TikTok). Fable then surfaces a fixed set of platform-specific daily quests — actions like "Post a Reel on Instagram" or "Post on Threads" — and rewards you for showing up. Tap-and-hold the colored quest circle to complete it. One completed quest per day keeps the streak alive. Think Duolingo for staying visible while you build.

## The Problem

Indie founders can build but struggle to market. They build privately, only think about distribution after launch, and end up launching to silence. The result: good products nobody knows about.

## Target Audience

Primary: indie founders and solo builders actively building apps, SaaS products, tools, or digital products. They understand the value of marketing but can't stay consistent with it.

Secondary: indie hackers, no-code founders, app developers, creators building digital products, students with side projects.

## Core Transformation

Before: "I'm building something but I don't know what to post. I keep delaying marketing until launch."

After: "Every day I know exactly what to post on the platforms I picked. My building progress becomes visibility, my visibility becomes momentum, and my momentum helps my product grow."

One line: from nobody to noteworthy.

---

## UI/UX Foundation: Atoms-Inspired Design

Fable adopts Atoms' best-in-class UX principles, adapted for a founder's build-in-public journey. Both apps turn what could feel like homework into something rewarding and game-like.

### Core Interaction: Quest Completion Circle

Each quest gets a **color-coded circle** representing the social platform the quest is for:
- Instagram quests → vibrant magenta/pink (aligned with Instagram brand recognition)
- TikTok quests → bold black + cyan (aligned with TikTok visual identity)
- Threads quests → deep neutral / monochrome (aligned with Threads minimalism)
- Future platforms (X, LinkedIn, YouTube, etc.) → assigned distinct colors at addition time

Exact color values are defined in `DESIGN.md` and should be visually distinct while still feeling cohesive with the Unified Glass Design System. Color must never be the only signal — every quest also has a platform name, action verb, and optional icon.

**How it works:**
1. User taps and holds on the quest circle
2. Inner circle grows outward like an expanding atom
3. As they hold, the circle fills the outer boundary
4. Once full → haptic vibration + satisfying animation burst
5. Quest marked complete, streak increases

**Why this works for Fable:**
- **Tactile satisfaction** — completing a quest feels rewarding, not obligatory
- **Visual clarity** — colors instantly differentiate which platform a quest is for (no reading needed)
- **Progressive feedback** — the growing circle creates momentum and anticipation
- **Play, not drudgery** — it feels like a game, not a task tracker
- **Haptic reward** — vibration trains the brain to come back (Pavlovian design)
- **Differentiation** — separates Fable from generic quest/habit trackers

### Design Principle #1: Platform-First Onboarding

Onboarding leads with **platform commitment**, not identity. The user picks 1–3 social platforms they want to grow on. Fable then filters all daily quests to those platforms.

During onboarding (part of MVP):
- Ask **"What are you building?"** — short project name, used to make quest copy feel personal
- Ask **"Which platforms do you want to grow on?"** — multi-select. MVP options: Instagram, Threads, TikTok. More added over time.
- Done. Under 60 seconds.

Post-MVP enhancement:
- Add **"Who do you want to become as a founder?"** as a deeper identity question, tied to **Founder XP** (a post-MVP feature where the user levels up *as a founder*, not as a game character).
- Add **"What story are you telling with your build?"** as a deeper narrative prompt (powers AI content reframing of Founder Notes).

This grounds quests in **commitment to specific platforms**, not abstract goals. A founder isn't just "posting updates" — they're growing on the platforms they chose, intentionally.

### Design Principle #2: Calming, Intentional Interface

Steal Atoms' aesthetic:
- **Minimal, clean layout** — one today screen showing available quests
- **Breathing room** — don't crowd the screen with stats
- **Focused hierarchy** — current streak is visible but doesn't dominate
- **Typography that's readable** — no tiny text or corporate feel
- **Color palette that's cohesive** — the quest circles set the tone

Goal: founders open the app and feel calm, not overwhelmed.

### Design Principle #3: Sensory Design (Haptic + Visual + Sound)

Make completing a quest feel **good**:
- **Haptic vibration** when the circle fills (reward sensation)
- **Animation burst** — confetti or shapes exploding in the platform's color
- **Sound cue** (optional) — satisfying sound on completion (can be disabled)
- **Visual streak increment** — watch the streak number go up
- **Color fills the background briefly** — momentary visual celebration

This is Pavlovian design: your brain learns "completing a quest = reward." Founders come back.

### Design Principle #4: "Five Good Minutes" Philosophy

Adapted for Fable:
- **Quests should be completable in 5 minutes or less** (including writing and posting on the platform)
- **Onboarding under 60 seconds** — don't make people answer 20 questions
- **Post-MVP: daily lessons and Founder Notes follow the same rule** — short, actionable, never more than 5 minutes

Founders are busy building. Respect their time.

### Design Principle #5: Platform-Specific Action Quests (Not Generic)

Each quest is a concrete action on a specific platform — not a thematic category and not a generic "share something" prompt. Examples:

- **Instagram:** Post a Reel, Post a Story, Post (feed)
- **TikTok:** Post a Reel
- **Threads:** Post

The exact catalog of quests per platform is defined in code as a static list (the "quest catalog"). The MVP catalog is intentionally small — variety comes from rotation across the user's chosen platforms, not from category breadth.

Why this works:
- **No content overhead** — the action is unambiguous; the user supplies the substance from what they're already building
- **Platform-shaped behavior** — the quest matches what's actually rewarded on that platform (a Reel is a Reel, not a vague "share progress")
- **Filterable** — only quests for the user's selected platforms appear

Post-MVP, AI content reframing (via Founder Notes) will turn the user's daily build journal into draft post copy specific to the active quest. The MVP does not include a draft helper, templates, or content generation.

### Design Principle #6: Minimal Friction, Maximum Clarity

Steal Atoms' frictionless flow:
- **No account creation required** to start first quest (free trial approach)
- **One gesture to complete** (tap-and-hold the circle)
- **Settings are accessible but hidden** — don't clutter the today screen
- **Settings only appear if you seek them out**

Goal: first-time user opens app, sees today's quests for the platforms they picked, completes one quest, feels good, comes back tomorrow.

### Design Principle #7: Streaks with Grace (Don't Miss Twice)

Adopt Atoms' "don't miss twice" philosophy:
- **One missed day doesn't reset streak** (optional grace day)
- **Two missed days break the streak** (forces back, not punishment)
- **Comeback moment** — if you break a streak, next quest says "Let's get back on track"
- **Longest streak always visible** — shows all-time best, not just current

This reduces shame/quit cycles. Founders are human. One bad day shouldn't end everything.

### Design Principle #8: Color-Coded Visual Scanning (By Platform)

Extend the platform colors (defined in Core Interaction above) across the entire app:
- **Quest History** — colors show which platforms you've shown up on at a glance
- **Heatmap (GitHub-style)** — daily squares on a grid. More quests completed = deeper color intensity. Light shade for 1 quest, darkest shade for all quests done. Missed days stay blank. The heatmap can optionally segment by platform in a stacked variant (post-MVP polish).
- **Today screen** — colored circles are a quick visual inventory of which platforms have quests available today

Over time, each founder learns their platform color mapping — it becomes muscle memory. The heatmap becomes a source of pride — founders will screenshot and share it.

### Design Principle #9: Minimal Gamification (Streaks, Not Badges)

For MVP, keep it simple:
- **Streaks are the main motivator** (not XP, badges, levels)
- **Current streak displayed on today screen** (prominent)
- **Longest streak visible on profile/settings**
- **Milestone labels** (Day 7: "Consistent Builder," Day 30: "Public Founder")
- **Skip badge/complexity** until post-MVP

Atoms learned: too many reward mechanics dilute impact. One strong mechanic (streaks) beats many weak ones.

### Design Principle #10: No Draft Helper in MVP (Post-MVP: AI Content Reframing)

The MVP is intentionally an **accountability layer, not a content tool**. The user supplies the post content from what they're already building; Fable's job is to make sure they post.

- **MVP:** No templates. No fill-in-the-blank. No copy-to-clipboard helper. The quest tells you the action ("Post a Reel on Instagram") — you write and post the content yourself, in the platform's own app.
- **Post-MVP:** Founder Notes (daily journaling) + AI content reframing turn what you actually did each day into draft post copy. This is a content tool, but it's *earned* — built on top of the validated habit loop.

Don't force auto-posting at any stage. The MVP does not even open the platform app for you. Tap-and-hold to complete is the only thing the user does inside Fable.

### Design Principle #11: Daily Lessons + Academy (Post-MVP)

**Not in MVP.** Two related learning surfaces in later phases:

**Daily Lessons:**
- **Short lesson pops up once per day** (optional, can be dismissed)
- **Lessons tied to the day's platform** — "You're posting on Instagram today. Here's what's working on Reels right now."
- **Lessons are from real founder stories** — not generic advice
- **Lessons reinforce why showing up matters** — distribution, momentum, audience

**Academy / Learn tab** (separate, deeper):
- **Tutorials and fundamentals** — for novice indie founders learning to build apps
- **Founder stories** — long-form, less ephemeral than daily lessons
- **Library** — deeper dives on build-in-public, audience, distribution, platform-specific growth

Together these widen Fable from "habit tracker for posting" into "place where the indie founder journey starts and continues."

Atoms does Daily Lessons brilliantly. Fable adapts the format once the core quest loop is validated.

### Design Principle #12: Intentional Limits (3-6 Quests Available, Only 1 Needed)

Like Atoms limits habits to 3-6:
- **Show 3-6 quests per day** (variety without overwhelm)
- **Quests filter to the user's selected platforms** — a user with one platform may see fewer quests; with three, they typically see the full 3-6
- **Only 1 quest completes the daily requirement** (choice, not burden)
- **Founder chooses which quest resonates** (agency)

This forces prioritization. Founders won't feel like they have to do everything. Quest count scales naturally with how many platforms the user committed to growing on.

### Design Principle #13: Multi-Surface Consistency (Post-MVP)

> Note on terminology: "Platform" in Fable's product vocabulary refers to **social platforms** (Instagram, Threads, TikTok). This principle is about **device surfaces** — iPhone, watchOS, widgets, web. Use the term "surface" here to avoid ambiguity.

**MVP is iPhone only.** Future phases expand like Atoms does:
- **iPhone app** (MVP — primary, full experience)
- **Apple Watch app** (post-MVP — quick quest check-in and logging)
- **Widgets** (post-MVP — show today's available quests, current streak)
- **Web dashboard** (post-MVP — view history, analytics, longer-form content)

Design the MVP with surface expansion in mind (shared data model) but don't build multi-surface until the core loop is validated.

### Design Principle #14: Progressive Disclosure (Free → Pro, Post-MVP)

The MVP is fully free. There is no paywall in V1 — the goal is to validate the core habit loop with as little friction as possible.

Pro is post-MVP and unlocks the Roadmap features as they ship:
- **Founder XP** — XP tied to leveling up *as a founder*
- **Founder Notes** — daily journaling of what you did on your build today
- **AI content reframing** — turn Founder Notes into draft post copy
- **Academy / Learn tab** — learning hub for novice indie founders
- **Apple Watch app, widgets, web dashboard** — multi-surface visibility

Don't gatekeep the core loop. The streak, tap-and-hold completion, platform selection, and platform-specific quests are always free.

---

## The Loop

Open app → see today's quests for your chosen platforms → tap-and-hold to complete at least one → streak increases → come back tomorrow.

MVP version: Pick Platforms → Daily Quests → Complete One → Maintain Streak → Build Visibility.

Future version: Pick Platforms → Daily Quests → Complete → Earn Founder XP → Journal in Founder Notes → AI Reframes Notes Into Drafts → Maintain Streak → Level Up as Founder.

## MVP Scope

1. **Onboarding** — Project name + platform multi-select (Instagram, Threads, TikTok in V1). Under 60 seconds. The identity question ("who do you want to become as a founder?") is post-MVP, tied to Founder XP.
2. **Daily Quests** — Fixed list of platform-specific actions, filtered to the user's selected platforms. Examples: "Post a Reel on Instagram," "Post a Story on Instagram," "Post on Threads," "Post a Reel on TikTok." Each quest has a title, the platform it belongs to, and a suggested action — that's it.
3. **Complete/Skip** — Tap-and-hold the colored circle to complete (inner circle expands, haptic feedback). Swipe or tap a secondary button to skip. Tap-and-hold is the only completion gesture. One completed quest per day keeps the streak alive.
4. **Streak** — Consecutive days with at least one completed quest across the user's chosen platforms. Main gamification mechanic. Displayed prominently. Uses "don't miss twice" grace: one missed day doesn't break the streak; two consecutive missed days resets it. Includes a GitHub-style heatmap where more quests completed per day = deeper color intensity.
5. **Quest History** — List of past quests with date and status, color-coded by platform.

## Out of Scope for MVP (Post-MVP Roadmap)

The following are explicit post-MVP features, ordered roughly by likely sequence:

- **Founder XP** — XP tied to leveling up *as a founder* (streak depth, platforms grown, days shown up)
- **Founder Notes** — daily journal of what you did on your build today
- **AI content reframing** — AI turns Founder Notes into draft posts/articles
- **Draft helper** (lightweight templates) — may or may not ship; AI reframing supersedes it
- **Identity-first onboarding question** — "who do you want to become as a founder?" — post-MVP, tied to Founder XP
- **Academy / Learn tab** — learning hub for novice indie founders learning to build apps
- **Apple Watch app, widgets, web dashboard** — multi-surface visibility for the streak
- **Pro / freemium tier** — gates around post-MVP features only; MVP is fully free

Not in roadmap: badges, boss battles, public profiles, social feed, auto-posting, calendar scheduling, markdown vault, team features, deep platform integrations.

## MVP Screens

1. **Onboarding (one-time)** — Welcome → project name → platform multi-select (Instagram, Threads, TikTok in V1; more added over time). Under 60 seconds. No identity question in MVP.
2. **Today Screen (primary)** — Displays the day's quests as color-coded circles (one color per platform). Each quest shows the action ("Post a Reel"), the platform name, and the tap-and-hold circle. Current streak displayed prominently. Skip is a clearly secondary action.
3. **Streak Screen** — Current streak, longest streak, and a GitHub-style contribution heatmap. Each day is a square on the grid; more quests completed in a day = deeper color intensity. Empty days stay blank.
4. **Quest History** — Past quests with date and status, color-coded by platform.
5. **Settings** — Project name, selected platforms (add/remove), reset streak.

## MVP Build Order

1. **Static quest catalog** — hardcoded list of platform-specific quest definitions (quest id, platform, action, title)
2. **Onboarding** — project name + platform multi-select; persist to founder profile
3. **Today screen** — render quests filtered to selected platforms, color-coded by platform
4. **Tap-and-hold completion** — gesture, animation, haptic feedback; mark quest complete
5. **Streak tracking** — local-calendar-day-based streak with "don't miss twice" grace logic
6. **Quest history + heatmap** — list view + GitHub-style heatmap
7. **Polish** — animations, visual feedback, settings screen

## Key Risks

- **Quests feel repetitive** → expand the per-platform quest catalog over time; add platforms (X, LinkedIn, YouTube, etc.) post-MVP. The MVP is intentionally narrow — variety scales with platforms added, not with quest categories.
- **Users don't want to post daily** → tap-and-hold is an *intentional* completion gesture; the user defines what counts as "completed" (posted vs drafted is between them and reality). No external verification.
- **App feels like homework** → tap-hold circle mechanic + haptic feedback + platform colors make it feel rewarding. Colors must be distinctive.
- **Tap-hold interaction isn't intuitive** → teach the gesture during onboarding. Tap-and-hold is the only way to complete (skip is a separate swipe/button action).
- **Streak pressure causes quitting** → "don't miss twice" grace day prevents harsh resets.
- **Users expect content help in MVP** → MVP is an accountability tool, not a content tool. Be explicit in onboarding copy: "We tell you to post; you supply the content from what you're already building."
- **Users select too many platforms in onboarding** → recommend 1–3 for focus; allow more but signal that consistency on a few beats sprawl across many.
- **Scope creep** → protect the core loop. Pick platforms → quests → tap-and-hold → streak. That's it for MVP. Anything else is post-MVP roadmap.

---

## Positioning & Launch Strategy

### Emotional Positioning

"Stop building things nobody knows about."

### Best Hooks

- "You'll spend 6 months building your app. Nobody will care. Unless you do this one thing every day."
- "Your app doesn't have a product problem. It has a silence problem."
- "Duolingo but instead of learning Spanish you're learning how to not launch to zero downloads."

### Borrowed Framing

"Duolingo for founder marketing" — daily quests, streaks, gamification. Instantly communicates the mechanic without explanation.

### Hater Activation

Biggest criticism of build-in-public: it's performative, people post fake progress for clout.

Acknowledgment: "Build-in-public is broken. Most of it is fake. Fable only works if you're actually building something."

Activation line: "This isn't for people who tweet about building. It's for people who build and forget to tweet."

### Content Angles

1. **"I did X for 30 days" format** — document using Fable for 30 days and show what happened to your audience. Dogfood the product.
2. **"Duolingo for ___" analogy** — short-form content that uses the comparison to instantly communicate the value.
3. **"I built the app I wished existed" founder story** — "I finished my app. Nobody knew it existed. So I built something to make sure that never happens again."

### 60-Second Launch Script Outline

1. Hook (0-3s): "I spent months building my app. I launched it. Nobody cared."
2. Pain (3-10s): Built the whole thing in private. No posts, no audience, no momentum. Launched into silence.
3. Turning point (10-18s): What if something told you exactly what to share every day while you were building?
4. Reveal (18-30s): I built Fable. Duolingo for marketing your app. Pick the platforms you want to grow on. Get a quest a day. Post a Reel on Instagram. Post on Threads. Tap-and-hold to complete. Keep the streak alive.
5. Proof (30-45s): Show the app — today screen with platform-colored quest circles, tap-and-hold a circle (inner circle expands), haptic feedback, streak goes up. Visual satisfaction.
6. Close (45-55s): Your next app doesn't need better features. It needs people who watched you build it.
7. CTA (55-60s): Link in bio. First quest is free.

### Landing Page Headlines

- Hero: "Stop launching in silence."
- Problem: "Building is not the hard part anymore. Getting people to care is."
- Solution: "One quest per day. One step toward visibility."
- Loop: "Build. Share. Streak. Repeat."
- Founder story: "Built because I was tired of finishing apps no one knew about."
- Final CTA: "Turn your progress into a story."

---

## Name Note

Fable means "story" — directly maps to the core tagline "turn your progress into a story" without needing to explain it. Short, memorable, clean.
