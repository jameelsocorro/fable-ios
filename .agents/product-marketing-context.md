# Product Marketing Context: Shoyo

*Last updated: 2026-05-03*

> ## Validation Status
>
> Shoyo is **pre-launch**. No users, no beta testers, no validated metrics, and no testimonials yet.
>
> **What is verified:**
> - Founder's own story and lived experience: multiple app launches, distribution lessons, and the silence-on-launch pattern.
> - Current app implementation: onboarding, platform picker, static quest catalog, Today tab, plus-button completion, Streaks tab, SwiftData persistence.
> - Current product direction: Shoyo-native mascot-led onboarding, platform orbs, glassy/native iOS surfaces, monochrome primary action color.
> - Brand name rationale: Shoyo is short for "show your work" / "showyowork."
>
> **What is hypothesized and must be validated before use as proof:**
> - Personas beyond the founder himself.
> - Customer language beyond founder-verbatim phrases.
> - Objections and switching dynamics.
> - Competitive conclusions beyond obvious category alternatives.
> - All metrics, testimonials, retention claims, audience-growth claims, and proof-of-results claims.
>
> When using this doc with marketing skills, treat hypothesized sections as starting points, not facts. Never put fabricated metrics, customer quotes, or outcome claims into landing copy, sales copy, pitches, or launch content.

---

## Founder Story

**Why it exists (founder's own words, lightly tightened):**

I've built multiple apps over the years. Most of them failed — not because they were bad products, but because they had no audience. A few made some money. One is truly making money.

The pattern was always the same: I'd get excited building, then never share the app until it was finished. By the time it was done, the excitement was gone — making content for it felt hard, I didn't know where to start with marketing, and the momentum I had while building had already died.

So I'm building Shoyo for myself first. It's the app I wish I'd had during every previous launch: something that nudges me to post about what I'm building, *while* I'm building it. No content strategy, no overthinking — just "here's a quest, post on the platform you said you'd grow on, keep your streak alive."

If it works for me — someone who's launched and learned this lesson the hard way — it'll work for other indie founders like me.

---

## Product Overview

**One-liner:**
Shoyo helps indie founders show their work before launch with daily platform-specific quests and forgiving streaks.

**Brand name:**
Shoyo is short for "show your work" / "showyowork" — a compact name that makes the product promise explicit: keep showing the work while you build, not after launch momentum has already died.

**What it does:**

During onboarding, the user picks the social platforms they want to grow on. Shoyo then surfaces fixed platform-specific quests — concrete actions like:

- "Post on Threads"
- "Post a Reel on Instagram"
- "Post a Story on Instagram"
- "Post a Short on YouTube"
- "Share in a subreddit"

The user completes a quest manually with the visible plus button after they do the action. The card fills with the platform color, haptic feedback fires, and the completion contributes to streaks and activity history. One completed quest per day keeps the overall streak alive. One missed day is forgiven; two missed days in a row resets the streak.

It's not a content tool. It's not a scheduler. It's not an auto-posting app. It's an **accountability layer** — the part most founders are missing.

**Product category:**
Founder accountability tool / build-in-public companion app / gamified visibility habit tracker.

**Product type:**
Mobile app (iOS MVP, iPhone-first).

**Business model:**
Pricing is TBD. Treat the core MVP as free during validation. Avoid promising Pro, freemium, or paid gates until packaging is deliberately defined.

---

## Current Product Surface

The app is no longer default SwiftUI scaffolding. Current implemented surfaces include:

- Mascot-led welcome screen with Oreo.
- Floating social platform orb picker.
- SwiftData profile and quest completion persistence.
- Static quest catalog covering Instagram, TikTok, Threads, YouTube, Facebook, LinkedIn, X, Bluesky, and Reddit.
- Today tab with platform-filtered quest cards.
- Plus-button completion, undo, animated color fill, and haptic feedback.
- Recent-day selector in Today.
- Streaks tab with total completions, current streak, completion rate, 12-month activity board, and per-quest seven-day strips.
- Settings tab placeholder.

The product has moved away from the old Atoms-inspired UI/UX direction. Marketing and product copy should describe Shoyo's own mascot-led, glassy, native iOS direction instead of old Atoms-derived patterns.

---

## Target Audience

**Who Shoyo is for:**
Solo builders and indie founders actively working on a product they intend to launch. They are good at building, understand distribution matters, and want to grow on a small number of social platforms — but they do not consistently share progress while building.

**Decision-maker:**
The founder themselves. Single user, no procurement cycle, impulse download.

**Primary use case:**
Staying visible on chosen platforms *while* building, so an audience exists by the time they launch.

**Jobs to be done:**
1. Show up daily on the platforms I've committed to growing on.
2. Stop doing the "I'll start sharing once it's done" thing.
3. Build a streak so showing up becomes the default, not a daily decision.
4. Miss a day without feeling like the whole habit is ruined.
5. Make visibility feel rewarding, not like another marketing chore.
6. Build an audience as a side effect of consistency — without realizing it's happening.

**Use cases:**
- Indie iOS / Mac developer who's launched apps before and watched them ship to silence.
- SaaS / no-code founder who knows distribution matters but can't keep posting consistently past week 2.
- Founder in public who has accounts on Threads, X, Instagram, TikTok, YouTube, or LinkedIn but needs focus and a daily push.
- Side-project builder preparing for launch who feels weird about self-promotion and needs a quest as the excuse to do it.

---

## Personas

> Beyond the founder himself, personas are hypothesized. Validate by talking to real builders before treating them as confirmed.

| Persona | Cares about | Challenge | Value we promise |
| --- | --- | --- | --- |
| **The Founder Himself (verified)** | Shipping apps, having distribution this time | Excited while building, shares too late, then loses momentum | Daily quests force visibility while building, before momentum dies |
| **The Repeat Launcher (hypothesized)** | Avoiding launch-to-silence again | Has shipped audience-less products before; knows it's the problem; can't fix the discipline gap alone | Streak + fixed quests remove the daily "what do I post?" decision |
| **The First-Time Builder (hypothesized)** | Building right from day one | Doesn't know what to post or where; intimidated by marketing | Fixed platform-specific quests give a paved path: just do this thing today |

---

## Problems & Pain Points

**Core problem (founder verbatim):**
Building great apps but launching them to silence — because you didn't share *while* building. By the time you finish, the excitement is gone, content is hard, and you don't know where to start with marketing. Momentum dies, then the launch dies with it.

**Why this happens (root causes):**
- "I'm very excited building something but I really don't share that app until I finish it."
- "After I finish it I'm not really excited to share about it."
- "It's hard to make content around it."
- "I really don't know how to start marketing it."
- "I lost the momentum of sharing."
- Sharing while building feels like showing off.
- No daily structure means posting is a fresh decision every day, and most days the answer becomes "later."

**Why current solutions fall short:**
- **Generic habit trackers** (Streaks, Done, Habitica): closest mechanic, but generic — they don't know you're a founder trying to grow on Instagram, Threads, X, or YouTube. The quest list is whatever you type in. No founder framing, no platform specificity.
- **Social schedulers** (Buffer, Later, Plann, Hootsuite): solve the "schedule a post I already wrote" problem. They don't solve the "did I show up today?" problem.
- **Notion / Airtable build-in-public templates:** DIY, require self-discipline, and are easy to abandon by week 2.
- **Social platforms directly:** infinite feed, no structure, no streak — easy to scroll instead of post.
- **Marketing courses and advice threads:** passive; they educate but don't create a daily action.
- **Going solo on willpower:** what most founders try; what most founders fail at.

**What it costs them:**
- Apps shipping to 100 downloads when they could have launched with people already watching.
- Hours wondering "what do I post?" when the needed behavior is often just "post something real on the platform you chose, today."
- Momentum dying between feature ship and launch day.
- Inconsistency that makes an audience assume the founder quit.

**Emotional tension:**
- Dread: "I should be posting but I don't know what to say."
- Guilt: "I'm avoiding marketing and it's going to hurt my launch."
- Anxiety: "Will anyone care about what I built?"
- Frustration: "I'm great at building, terrible at being visible."
- Fear: "If I miss a week, my audience will forget about me."

---

## Competitive Landscape

**Direct-ish competitors (same mechanic, adjacent user):**
- **Generic habit trackers** (Streaks, Done, Habitica): closest mechanic, but generic and not founder-specific. No platform-aware quests, no founder framing.
- **Notion / Airtable build-in-public templates:** closest in spirit, but DIY and abandoned easily.

**Secondary competitors (different mechanic, same job):**
- **Buffer / Later / Plann / Hootsuite:** scheduling tools — they help once you've decided to write the post. They don't tell you to show up today, and they don't reward consistency the way a streak does.
- **The platforms themselves** (Threads, X, Instagram, TikTok, YouTube, LinkedIn, Reddit) used as "I'll just remember to post" solutions: no structure, no streak, no daily nudge.

**Indirect competitors (alternative approach):**
- **Indie Hackers / Product Hunt:** community + launch platforms. Useful, but they don't help you stay visible before launch.
- **Marketing courses and build-in-public advice:** education, not action.
- **Just willpower:** free, ubiquitous, mostly fails.

**Why they fall short for this user:**
- None combine **platform-specific fixed quests** + **forgiving streak gamification** + **founder framing**.
- Habit trackers are too generic; schedulers solve the wrong stage; courses are passive.
- Nothing is built by a founder for founders who've already lived the silence-on-launch lesson.

---

## Differentiation

**The core insight:**
Most build-in-public tools are content tools. Shoyo isn't a content tool — it's an **accountability tool**. The hard part isn't always writing the post; it's deciding to show up today, on the platform you chose, when you'd rather just keep building. Shoyo handles that decision for you.

**Key differentiators:**

1. **Platform-specific quests, not generic prompts.** "Post a Reel on Instagram" is a different quest than "Post on Threads" because the behavior is different. The quest list is curated to the platforms the user actually committed to during onboarding.

2. **You commit to platforms; the streak rewards consistency on them.** Not "post anywhere today" — show up on the platforms you picked. This forces focus instead of spraying across seven networks badly.

3. **Manual completion, not automation.** The user taps the plus button after doing the action. The card fills, haptics fire, and undo appears. Shoyo does not verify, auto-post, or pretend it knows whether the post was good.

4. **Forgiving streaks with grace ("don't miss twice").** One missed day doesn't reset the streak. Two consecutive misses do. This creates accountability without turning one human day into a quit trigger.

5. **Visible consistency history.** Streaks, per-quest strips, and the activity board make showing up tangible over time. The user can see the habit forming.

6. **Built by a founder for founders.** Not a generic productivity company chasing a market — an app the founder is dogfooding through Shoyo's own launch.

7. **Shoyo-native brand experience.** Oreo, platform orbs, glass surfaces, haptics, monochrome primary actions, and polished native iOS motion make the habit feel supportive instead of corporate. This reinforces the loop, but the core differentiation is still platform-specific accountability.

**Why founders choose it:**
You get one thing: a daily nudge to post on the platforms you committed to growing on, gamified enough that you actually do it. Not "be more productive." Not "build a personal brand." Just: "Pick your platforms. Show your work today. Keep the streak alive."

---

## Roadmap Positioning

> Captured here because it shapes long-term positioning. **Do not market features that don't exist yet.** Treat these as possible directions, not promises.

The near-term product work is about making the current MVP coherent:

- Real Settings screen.
- Platform editing and reset.
- Decision on whether project name is part of onboarding.
- Keep supported platforms intentionally limited to Instagram, TikTok, Threads, YouTube, Facebook, LinkedIn, X, Bluesky, and Reddit until the habit loop is validated.
- Clear distinction between overall streak and per-quest streaks.
- Decision on whether recent-day backfill is intentional.

Possible post-MVP directions:

- **Draft help or AI content reframing** — only after the accountability loop is validated. This should help users turn real build progress into draft posts, not replace the act of building.
- **Founder Notes** — short daily journal of what you did on your build today, if journaling becomes part of the product.
- **Widgets / Apple Watch / web dashboard** — only after iPhone retention is proven.
- **Deeper analytics** — once users have meaningful completion and audience history.
- **Founder XP / Academy / Pro packaging** — only if intentionally revived. These should not be central to current positioning.

Together, these could eventually turn Shoyo from "daily accountability for showing your work" into a broader founder visibility companion. The MVP does not promise any of it.

---

## Objections & Anti-Personas

> Hypothesized — not yet heard from real users. Update after founder interviews or beta tests.

| Objection | Response |
| --- | --- |
| "Isn't this just performative build-in-public?" | Shoyo works best if you're actually building. The quest is to show the work, not invent fake progress. |
| "I don't have time to post daily." | Quests are meant to be small and concrete. You only need one completion per day to keep the streak alive. |
| "What if I miss a day?" | One missed day is forgiven. Two consecutive missed days reset the streak. Built for humans. |
| "I don't know what to actually post." | Shoyo tells you the platform action. The content comes from what you're already building. |
| "Will this actually grow my audience?" | If you're building something real and you show up consistently on the platforms you committed to, Shoyo removes the friction of whether to show up today. Audience growth still has to be validated. |
| "Why not just use Buffer or Later?" | Different problem. Schedulers help when you've already decided to write a post. Shoyo's job is making sure you decide to show up in the first place. |

**Anti-persona:**
Shoyo is not a good fit for:

- Founders who are not actually building anything.
- Social media managers or teams needing approval workflows.
- Marketers / creators already posting daily without help.
- Users who want auto-posting, AI-written content, or a scheduler in V1.
- People who want public profiles, social feeds, or community mechanics inside the app.

---

## Switching Dynamics (JTBD Four Forces)

> Hypothesized — validate by interviewing real builders.

**Push (frustrations with status quo):**
- "I built another thing nobody knows about."
- "I'm great at shipping, terrible at sharing."
- "Every habit tracker I've tried feels like homework."
- "I keep telling myself I'll start posting tomorrow."
- "I picked Threads / Instagram / TikTok / X — and I post on none of them."

**Pull (what attracts them to Shoyo):**
- "It tells me where to show up today."
- "I can do one platform-specific action."
- "The streak makes me show up without thinking about it."
- "If I miss once, I haven't failed."
- "It's not a marketing app. It's a 'don't forget to show the work' app."
- "Built by someone who's lived through this. Not corporate."

**Habit (what keeps them stuck):**
- "I've tried posting before and it didn't stick."
- "I already spend time on the platforms — why download another app?"
- "Marketing feels secondary to building."
- "Generic habit apps I've tried before all got abandoned."

**Anxiety (about switching):**
- "Will the streak feel like pressure if I miss?"
- "Is this just another empty gamification gimmick?"
- "Will I still be using this in 3 months?"
- "Will I know what to say?"
- "Will my audience actually grow?"

---

## Customer Language

> Founder verbatim is verified — strongest copy source. Other phrasing is hypothesized; replace with real interview quotes as you collect them.

**How the founder describes the problem (verbatim):**
- "I'm very excited building something but I really don't share that app until I finish it."
- "After I finish it I'm not really excited to share about it."
- "It's hard to make content around it."
- "I really don't know how to start marketing it."
- "I lost the momentum of sharing."
- "Most of [my apps] failed because they don't have any audience."
- "I see a pattern."
- "Build momentum."
- "Visibility while building."
- "Keep [founders] accountable."
- "Gain followers without noticing because you are sharing something."
- "It's much fun to build that way."

**How users may describe what they want (hypothesized):**
- "Just tell me to post on [platform] today."
- "I need a streak to keep me showing up."
- "Make it feel like a game, not marketing."
- "Pick my platforms once, get my quests forever."
- "If I miss once, don't make me feel like I failed."

**Words to use:**
- "Show your work"
- "Visibility while building" / "stay visible"
- "Momentum"
- "Accountable" / "accountability"
- "Build a streak" / "keep the streak alive"
- "Don't miss twice"
- "Post on [platform]" (specific actions, never abstract "share")
- "Show up"
- "While you build"
- "Before launch"
- "Indie founder" / "solo builder"

**Words to avoid or use carefully:**
- "Marketing" (honest in the problem, but can sound like overhead in benefits)
- "Content creation" (chore framing)
- "Growth hacks" (shallow)
- "Personal branding" (off-putting)
- "Engage your audience" (corporate)
- "Content strategy" (too formal)
- "Scheduler" (wrong category)
- Generic "habit tracker" framing (Shoyo is about visibility, not habits in the abstract)

**Glossary:**

| Term | Meaning |
| --- | --- |
| **Quest** | A platform-specific daily action ("Post a Reel on Instagram", "Post on Threads"). |
| **Platform** | A social network the user committed to growing on during onboarding. |
| **Completion** | A manual plus-button commitment that the user did the quest. |
| **Streak** | Consecutive days with at least one completed quest across the user's chosen platforms. |
| **Don't miss twice** | The forgiving streak rule: one missed day is allowed; two consecutive missed days reset the streak. |
| **Activity board** | GitHub-style grid showing completion intensity over time. |
| **Oreo** | Shoyo's companion character in onboarding. |

---

## Brand Voice

**Tone:**
Encouraging, playful, respectful of time, never condescending. Founder-to-founder, not coach-to-student.

**Style:**
Short, punchy, direct. No corporate fluff. Empathetic about the hard parts — silent launches, lost momentum, awkward self-promotion — but focused on today's next action.

**Personality:**
- **Pragmatic** — solves a real problem, not a fantasy.
- **Playful** — gamified, haptic, satisfying.
- **Respectful** — honors the founder's time and autonomy.
- **Accountable** — keeps the founder honest without shame.
- **Clear** — concrete actions, no jargon.

---

## Proof Points

> No proof points yet — pre-launch. Below is what to gather, not what exists. Do not put any results claims into marketing copy until they're real.

**Strongest available proof point right now:**
The founder's own story. Multiple apps shipped, mostly to silence, one truly making money, and the lesson learned about distribution. The dogfooding case study — Shoyo used on Shoyo's own launch — becomes the second proof point once it exists.

**Metrics to collect post-launch:**
- Daily quest completion rate.
- Day-1, Day-7, and Day-30 return rate.
- Streak retention: 7-day, 30-day, 100-day.
- Platform mix: which platforms users pick most often.
- Completion rate by platform and quest.
- User feedback on "did this help you stay visible?"
- Audience growth of beta users on chosen platforms.
- Founder's own audience growth from dogfooding.

**Beta target audiences to recruit:**
- Indie Hackers community founders.
- Product Hunt makers.
- Twitter/X, Threads, and Bluesky build-in-public communities.
- Indie iOS / Mac developers.
- Founders in accelerators or maker communities.
- The founder's own existing audience.

**Testimonials to gather (none exist yet):**
- "Posted on [platform] N days in a row. Audience went from X to Y."
- "First app I'm launching with people actually watching."
- "This is the only streak app I'm still using after a month."
- "I stopped opening Threads just to scroll and started posting first."

**Value themes (with proof status flagged):**

| Theme | Status | Plan to validate |
| --- | --- | --- |
| **Removes the 'do I post today?' decision** | Hypothesis | Compare time-to-post in beta vs. baseline |
| **Builds consistency** | Hypothesis | Track 7-day and 30-day streak retention |
| **Reduces shame from missed days** | Design intent | Survey users after missed-day recovery |
| **Grows audience** | Hypothesis | Track follower delta on chosen platforms over 30/60/90 days |
| **Makes visibility feel doable** | Hypothesis | Survey beta users; track voluntary returns |
| **Respects time** | Design intent | Track average quest completion time |

---

## Goals

**Primary product goal:**
Make Shoyo the app indie founders open before they start building, so showing the work becomes part of the build routine.

**Primary business goal:**
Validate that a platform-specific quest loop can create durable daily visibility behavior before deciding packaging or pricing.

**Dual-purpose secondary goal:**
Use building Shoyo as the founder's own case study + content engine. Document the journey. Stay accountable. Grow Shoyo's audience using Shoyo.

**Conversion actions:**
1. **For users:** Download → choose platforms → complete first quest → feel the feedback → come back tomorrow.
2. **For the founder:** Use Shoyo daily on Shoyo's own launch → produce content about the journey → grow Shoyo's audience using Shoyo.

**Key metrics to track:**
- Day-1 return rate.
- 7-day and 30-day streak retention.
- Daily quest completion rate.
- Average session length.
- Platform selection mix.
- Missed-day recovery rate.
- User feedback on whether Shoyo helped them stay visible.
- Founder's own audience growth as a dogfooding proof point.
