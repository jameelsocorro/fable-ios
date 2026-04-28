# Fable

## What It Is

Fable is a gamified build-in-public companion for indie founders. Each day, founders get a series of quests to help them share their progress, build consistency, and grow their audience while building their product. Completing at least one quest per day keeps the streak alive. Think Duolingo for marketing your app.

## The Problem

Indie founders can build but struggle to market. They build privately, only think about distribution after launch, and end up launching to silence. The result: good products nobody knows about.

## Target Audience

Primary: indie founders and solo builders actively building apps, SaaS products, tools, or digital products. They understand the value of marketing but can't stay consistent with it.

Secondary: indie hackers, no-code founders, app developers, creators building digital products, students with side projects.

## Core Transformation

Before: "I'm building something but I don't know what to post. I keep delaying marketing until launch."

After: "Every day I know exactly what to share. My building progress becomes content, my content becomes momentum, and my momentum helps my product grow."

One line: from nobody to noteworthy.

---

## UI/UX Foundation: Atoms-Inspired Design

Fable adopts Atoms' best-in-class UX principles, adapted for a founder's build-in-public journey. Both apps turn what could feel like homework into something rewarding and game-like.

### Core Interaction: Quest Completion Circle

Each quest gets a **color-coded circle** representing that quest type:
- Share Progress quests → warm color (orange/red)
- Behind-the-Scenes quests → playful color (purple/teal)
- Learning quests → calm color (blue)
- Audience-Building quests → vibrant color (green)
- Launch/Reflection quests → gold/accent

**How it works:**
1. User taps and holds on the quest circle
2. Inner circle grows outward like an expanding atom
3. As they hold, the circle fills the outer boundary
4. Once full → haptic vibration + satisfying animation burst
5. Quest marked complete, streak increases

**Why this works for Fable:**
- **Tactile satisfaction** — completing a quest feels rewarding, not obligatory
- **Visual clarity** — colors instantly differentiate quest types (no reading needed)
- **Progressive feedback** — the growing circle creates momentum and anticipation
- **Play, not drudgery** — it feels like a game, not a task tracker
- **Haptic reward** — vibration trains the brain to come back (Pavlovian design)
- **Differentiation** — separates Fable from generic quest/habit trackers

### Design Principle #1: Identity-First (Like Atoms' "Who do you want to become?")

During onboarding (part of MVP):
- Ask **"Who do you want to become as a founder?"** — options like: visible builder, trusted voice, community leader, launch-ready founder
- This answer personalizes quest language — "Today's quest helps you become a [identity]"
- Link daily quests back to this identity throughout the app

Post-MVP enhancement:
- Add **"What story are you telling with your build?"** as a deeper narrative prompt
- Use the answer to personalize draft templates and content suggestions

This grounds quests in **meaning**, not just streak counting. A founder isn't just "posting updates" — they're building a narrative and becoming someone.

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
- **Animation burst** — confetti or shapes exploding in the quest's color
- **Sound cue** (optional) — satisfying sound on completion (can be disabled)
- **Visual streak increment** — watch the streak number go up
- **Color fills the background briefly** — momentary visual celebration

This is Pavlovian design: your brain learns "completing a quest = reward." Founders come back.

### Design Principle #4: "Five Good Minutes" Philosophy

Adapted for Fable:
- **Quests should be completable in 5 minutes or less** (including the share/draft)
- **Onboarding under 60 seconds** — don't make people answer 20 questions
- **Draft templates are short** — fill-in-the-blank, not long-form writing
- **Post-MVP: daily lessons and mindset content follow the same rule** — short, actionable, never more than 5 minutes

Founders are busy building. Respect their time.

### Design Principle #5: Identity-Anchored Quest Types (Not Generic)

Each quest isn't just a task — it's building a specific part of the founder identity:

- **Share Progress quests** → "Show you're shipping" (visible builder)
- **Behind-the-Scenes quests** → "Show the process" (authentic founder)
- **Learning quests** → "Reflect publicly" (thoughtful founder)
- **Audience-Building quests** → "Engage your community" (connected founder)
- **Launch/Reflection quests** → "Document the journey" (transparent founder)

The draft helper should remind them: "This quest helps you become a [type] founder."

### Design Principle #6: Minimal Friction, Maximum Clarity

Steal Atoms' frictionless flow:
- **No account creation required** to start first quest (free trial approach)
- **One gesture to complete** (tap-and-hold the circle)
- **Fallback prompts always available** ("can't think of what to share? here's a template")
- **Settings are accessible but hidden** — don't clutter the today screen
- **Settings only appear if you seek them out**

Goal: first-time user opens app, sees today's quests, completes one quest, feels good, comes back tomorrow.

### Design Principle #7: Streaks with Grace (Don't Miss Twice)

Adopt Atoms' "don't miss twice" philosophy:
- **One missed day doesn't reset streak** (optional grace day)
- **Two missed days break the streak** (forces back, not punishment)
- **Comeback moment** — if you break a streak, next quest says "Let's get back on track"
- **Longest streak always visible** — shows all-time best, not just current

This reduces shame/quit cycles. Founders are human. One bad day shouldn't end everything.

### Design Principle #8: Color-Coded Visual Scanning

Extend the quest type colors (defined in Core Interaction above) across the entire app:
- **Quest History** — colors show which types you've completed at a glance
- **Heatmap (GitHub-style)** — daily squares on a grid. More quests completed = deeper color intensity. Light shade for 1 quest, darkest shade for all quests done. Missed days stay blank. Founders can instantly see their consistency patterns over weeks and months.
- **Today screen** — colored circles are a quick visual inventory of what's available

Over time, each founder learns their color mapping — it becomes muscle memory. The heatmap becomes a source of pride — founders will screenshot and share it.

### Design Principle #9: Minimal Gamification (Streaks, Not Badges)

For MVP, keep it simple:
- **Streaks are the main motivator** (not XP, badges, levels)
- **Current streak displayed on today screen** (prominent)
- **Longest streak visible on profile/settings**
- **Milestone labels** (Day 7: "Consistent Builder," Day 30: "Public Founder")
- **Skip badge/complexity** until post-MVP

Atoms learned: too many reward mechanics dilute impact. One strong mechanic (streaks) beats many weak ones.

### Design Principle #10: Draft Helper Integration (Don't Leave the App)

Keep the core loop inside Fable:
- **Tap a quest → see the fallback template immediately** (no navigation)
- **Copy button copies to clipboard** (founder pastes in their preferred platform)
- **Optional: show platform-specific tips** ("X loves 3-part threads")
- **Save drafts inside Fable** (optional, for later posting)

Don't force auto-posting. Keep it simple: define → draft → copy → post elsewhere.

### Design Principle #11: Daily Lessons (Post-MVP, Identity-Focused)

**Not in MVP.** Adapt Atoms' daily lesson model in a later phase:
- **Short lesson pops up once per day** (optional, can be dismissed)
- **Lessons tied to the day's quest type** — "You're sharing progress today. Here's why that matters."
- **Lessons are from real founder stories** — not generic advice
- **Library available** for deeper dives on topics (build-in-public, audience, distribution, etc.)
- **Lessons reinforce the identity** — remind founders why they're building in public

Atoms does this brilliantly. Fable can adapt it for build-in-public principles once the core quest loop is validated.

### Design Principle #12: Intentional Limits (3-6 Quests Available, Only 1 Needed)

Like Atoms limits habits to 3-6:
- **Show 3-6 quests per day** (variety without overwhelm)
- **Only 1 quest completes the daily requirement** (choice, not burden)
- **Founder chooses which quest resonates** (agency)
- **Pro plan unlocks more quest variety** (progression)

This forces prioritization. Founders won't feel like they have to do everything.

### Design Principle #13: Multi-Platform Consistency (Post-MVP)

**MVP is iPhone only.** Future phases expand like Atoms does:
- **iPhone app** (MVP — primary, full experience)
- **Apple Watch app** (post-MVP — quick quest check-in and logging)
- **Widgets** (post-MVP — show today's available quests, current streak)
- **Web dashboard** (post-MVP — view history, analytics, longer-form content)

Design the MVP with platform expansion in mind (shared data model, API-first) but don't build multi-platform until the core loop is validated.

### Design Principle #14: Progressive Disclosure (Free → Pro)

Like Atoms' free tier vs Pro:
- **Free:** 1-2 quests per day, basic streak tracking, draft helper
- **Pro:** All quest types (3-6 per day), daily lessons, mindset library, deeper analytics, Apple Watch, widgets

Don't gatekeep the core loop. The streak, tap-and-hold completion, and basic quests work free. Pro adds variety, content, and depth.

---

## The Loop

Open app → get daily quests → complete at least one → streak increases → come back tomorrow.

MVP version: Daily Quests → Complete One → Maintain Streak → Build Visibility.

Future version: Daily Quests → Share Progress → Earn XP → Maintain Streak → Unlock Badges → Level Up.

## MVP Scope

1. **Onboarding** — what are you building, what stage, where do you share, what's your goal, and one identity question: "who do you want to become as a founder?" (maps to Atoms' identity-first approach). Under 60 seconds.
2. **Daily Quests** — series of 3-6 quests per day, color-coded by type (Share Progress, Behind-the-Scenes, Learning, Audience-Building, Launch). Each quest has title, description, fallback prompt, and suggested platform.
3. **Complete/Skip** — tap-and-hold the colored circle to complete (inner circle expands, haptic feedback). Swipe or tap a secondary button to skip. One completed quest per day keeps the streak alive.
4. **Streak** — consecutive days with at least one completed quest. Main gamification mechanic for MVP. Displayed prominently. Uses "don't miss twice" grace: one missed day doesn't break the streak, two consecutive missed days resets it. Includes a GitHub-style heatmap grid where more quests completed per day = deeper color intensity.
5. **Quest History** — list of past quests with date and status, colored by quest type.
6. **Draft Helper** — simple fill-in-the-blank templates the user can copy and post manually.

## Out of Scope for MVP

No XP system, badges, boss battles, public profiles, social feed, auto-posting, AI writing, calendar scheduling, markdown vault, team features, deep platform integrations, daily lessons/mindset library, Apple Watch app, widgets, or web dashboard.

## MVP Screens

1. **Today Screen** (primary) — displays 3-6 available quests for today as color-coded circles. Tap-and-hold a circle to complete (inner circle expands, haptic feedback). Swipe or tap secondary button to skip. Current streak displayed prominently. Fallback prompts and suggested platform visible on each quest.
2. **Streak Screen** — current streak, longest streak, and a GitHub-style contribution heatmap. Each day is a square on the grid. More quests completed in a day = deeper color intensity (light for 1 quest, darkest for all quests completed). Empty days stay blank. Gives founders an instant visual of their consistency over weeks and months.
3. **Quest History** — past quests with date and status, color-coded by quest type for quick visual scanning.
4. **Draft Helper** — can live inside the Today screen. Quest prompt, template, copy button.
5. **Settings** — project name, preferred platforms, quest frequency, reset streak.

## MVP Build Order

1. Static quest system (hardcoded quest list, assign 3-6 quests per day based on category rotation)
2. Completion and streaks
3. Quest history
4. Draft helper with templates
5. Onboarding (use project name inside quest prompts)
6. Polish (animations, visual feedback, satisfying streak UI)

## Key Risks

- Quests feel repetitive → rotate by product stage, build enough variety across 5 quest categories.
- Users don't want to post daily → allow "drafted it" as valid completion.
- App feels like homework → tap-hold circle mechanic + haptic feedback + colors make it feel rewarding. Colors must be distinctive and beautiful.
- Tap-hold interaction isn't intuitive → teach the gesture during onboarding. Tap-and-hold is the only way to complete (skip is a separate swipe/button action).
- Streak pressure causes quitting → "don't miss twice" grace day prevents harsh resets. Comeback quests ease founders back in.
- Users expect auto-posting → start with copy/export only.
- Scope creep → protect the core loop. Color-coded circles, one completion per day for streak. That's it.

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
4. Reveal (18-30s): I built Fable. Duolingo for marketing your app. One quest a day. Share a screenshot. Ask your audience a question. Post a small win. Tap-and-hold to complete. Keep the streak alive.
5. Proof (30-45s): Show the app — today screen with colored quest circles, tap-and-hold a circle (inner circle expands), haptic feedback, streak goes up. Visual satisfaction.
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
