---
name: high-end-liquid-glass-design
description: Engineer premium iOS experiences using native Liquid Glass (iOS 26+) and SwiftUI materials, with depth-layered components, semantic typography, haptic precision, and motion choreography that respects Reduce Motion. Use whenever building SwiftUI surfaces that need frosted depth, cinematic transitions, or premium polish—modals, cards, bottom sheets, onboarding flows, focus/productivity apps, health dashboards. Triggers on requests for "glass effect", "liquid glass", "glassmorphism", "frosted glass", "iOS design system", or "premium iOS UI".
compatibility: iOS 26+, SwiftUI, Swift 6.2+, Xcode 26+
---

# iOS Liquid Glass Design: The Premium Cinematic Framework

## 1. Meta Directive & Core Philosophy

**Persona:** iOS_Glass_Architect
**Objective:** Architect $100k+ premium iOS experiences where every surface, transition, and tap evokes manipulating real, physical glass — light refracting through frosted layers, gravity affecting overlays, depth that respects finger position and device orientation.

**The Cinematic Mandate:**
Every glass surface should feel like a precision-engineered material object, not a digital layer. When tapped, it compresses. When dismissed, it floats away. When dragged, it respects gravity.

**Anti-Template Rule:**
Never generate identical glass stacks or motion patterns twice. Combine different depth tiers, motion curves, and color archetypes for bespoke quality.

---

## 2. THE LIQUID GLASS FORBIDDEN PATTERNS

Banned aesthetic and engineering sins:

- **Flat opaque cards** without depth, blur hierarchy, or border highlight.
- **`.blur(radius:)` on a solid background** as a substitute for material — `.blur` is a foreground filter, not a backdrop blur. Use `.background(.regularMaterial)` or `.glassEffect()`.
- **Hardcoded font sizes on text** (`.font(.system(size: 16))`) — breaks Dynamic Type. Use semantic fonts (`.headline`, `.title`, `.body`) or `.system(.title3, weight: .semibold)`. **Exception:** decorative `Image(systemName:)` inside a fixed-size shape (e.g. an icon centered in a 44pt circle) may use a fixed `.font(.system(size:))` if marked `.accessibilityHidden(true)` — the icon sizes to container geometry, not user text.
- **Linear / default `.easeInOut` animations** — use `.spring(response:dampingFraction:)` or `.interpolatingSpring`.
- **Spring animations not gated on Reduce Motion** — every animation must check `@Environment(\.accessibilityReduceMotion)`.
- **Static or hardcoded shadows** — adapt color/opacity via `@Environment(\.colorScheme)`.
- **Hardcoded RGB tints** as primary color — use semantic colors, asset catalog, or system colors that adapt to light/dark.
- **No haptic feedback** on tap, success, or selection — use `.sensoryFeedback(_:trigger:)` (iOS 17+); `UIImpactFeedbackGenerator` is legacy.
- **Ignoring Safe Area** — use `safeAreaInset` and `.ignoresSafeArea(edges:)` deliberately.
- **Glass on every scrolling list row** — material/glass blur is GPU-expensive; reserve for fixed overlays and a small number of cards.
- **Accessibility gaps** — every interactive glass element needs `.accessibilityLabel()` and `.accessibilityHint()` (or use a `Button` with a clear label).
- **Animating `.opacity` on large hierarchies** — prefer conditional rendering with `.transition()`.

---

## 3. iOS 26 NATIVE LIQUID GLASS PRIMER

iOS 26 ships native Liquid Glass. Prefer it over manual material stacks when targeting iOS 26+.

### Core modifiers

```swift
// Default glass
Text("Focus Session")
    .padding()
    .glassEffect()

// Tinted glass (use semantic / theme colors, not hardcoded hex)
Text("Streak Active")
    .padding()
    .glassEffect(.regular.tint(.accentColor))

// Interactive glass (responds to press with native compression + sheen)
Button("Start", action: start)
    .glassEffect(.regular.interactive())

// Custom shape
Image(systemName: "flame.fill")
    .padding(20)
    .glassEffect(in: Circle())
```

### Morphing groups with `GlassEffectContainer`

```swift
@Namespace private var glassNamespace

GlassEffectContainer(spacing: 16) {
    ForEach(items) { item in
        ItemCard(item: item)
            .glassEffectID(item.id, in: glassNamespace)
    }
}
```

`GlassEffectContainer` lets multiple glass shapes share refraction and morph together when one expands or moves — the iOS 26 Control Center pattern.

### When to fall back to materials

If targeting iOS 17–25, use SwiftUI's built-in materials:
- `.ultraThinMaterial` — barely there (input chrome, hover surfaces)
- `.thinMaterial` — light cards
- `.regularMaterial` — primary cards / sheets (most common)
- `.thickMaterial` — modals, prominent overlays
- `.ultraThickMaterial` — full-screen overlays, lock screens

```swift
// Material fallback (works on iOS 17+)
Text("Focus Session")
    .padding()
    .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 24, style: .continuous))
```

For an app targeting iOS 26+, **always reach for `.glassEffect()` first.**

---

## 4. THE LIQUID GLASS VARIANCE ENGINE

Before architecting a new surface, lock one combo. This keeps each build branded but premium.

### A. Depth Architecture (Pick 1)

#### 1. Ethereal Stack (AI / Productivity / Focus)
- **Foundation:** `Color(.systemBackground)` (auto-adapts)
- **Glass tier:** `.glassEffect()` or `.regularMaterial` over a faint accent-tinted radial gradient
- **Inner content:** Massive semantic typography (`.largeTitle.bold()`), one accent color
- **Best for:** journaling, meditation, focus timers, financial dashboards

#### 2. Warm Editorial Stack (Health / Wellness / Lifestyle)
- **Foundation:** Asset-catalog warm cream that adapts to dark mode (define light + dark variants in Assets)
- **Glass tier:** `.glassEffect(.regular.tint(.accentColor))` with a soft cream/sage gradient underlay
- **Motion:** Slower spring (`.spring(response: 0.6, dampingFraction: 0.8)`)
- **Best for:** habit tracking, food logging, outdoor / adventure

#### 3. Minimal White Stack (Notes / Messaging / Productivity)
- **Foundation:** `Color(.systemBackground)`
- **Glass tier:** `.glassEffect()` (default) over white, hairline border ring
- **Motion:** Snappy spring (`.spring(response: 0.4, dampingFraction: 0.9)`)
- **Best for:** notes, task managers, minimalist tools

### B. Motion Choreography (Pick 1)

#### 1. Springy Bounce
```swift
.transition(.asymmetric(
    insertion: .scale(scale: 0.85).combined(with: .opacity),
    removal: .scale(scale: 1.05).combined(with: .opacity)
))
.animation(reduceMotion ? .linear(duration: 0.2) : .spring(response: 0.5, dampingFraction: 0.72),
           value: isPresented)
```
Tactile, playful. Best for consumer apps.

#### 2. Fluid Ease (with staggered children)
```swift
.transition(.opacity.combined(with: .move(edge: .bottom)))
.animation(reduceMotion ? .linear(duration: 0.2)
                        : .spring(response: 0.55, dampingFraction: 0.85).delay(Double(index) * 0.06),
           value: isPresented)
```
Cinematic, professional. Best for productivity / focus.

#### 3. Gravity-Aware Slide
```swift
.offset(y: dragOffset)
.animation(reduceMotion ? nil : .interpolatingSpring(stiffness: 100, damping: 12),
           value: dragOffset)
```
Physics-driven. Best for immersive UX with drag interactions.

### C. Color Palette Archetypes

Define each in Assets.xcassets with light + dark variants. Never inline hex / RGB.

| Archetype | Primary | Accent | Glass tint |
|---|---|---|---|
| **Cybernetic Chill** | "PrimaryIce" | "AccentMagenta" | ultra-light purple |
| **Organic Earth** | "PrimarySage" | "AccentTerracotta" | milky cream |
| **Midnight Luxe** | "PrimaryMoon" | "AccentLilac" | deep charcoal (OLED-friendly) |

Reference as `Color("PrimaryIce")` so dark mode adapts automatically.

---

## 5. LIQUID GLASS COMPONENT ARCHITECTURE

### The "Double-Bezel" Glass Container (iOS 26)

Every major card or modal feels like a glass plate seated in a precision bezel.

```swift
struct GlassCard<Content: View>: View {
    @Environment(\.colorScheme) private var colorScheme
    let cornerRadius: CGFloat
    @ViewBuilder let content: Content

    var body: some View {
        content
            .padding(20)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(.regularMaterial)
                    .overlay {
                        // Inset highlight gradient
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        .white.opacity(colorScheme == .dark ? 0.20 : 0.65),
                                        .white.opacity(colorScheme == .dark ? 0.04 : 0.15)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    }
            }
            .shadow(
                color: .black.opacity(colorScheme == .dark ? 0.28 : 0.08),
                radius: 14, x: 0, y: 5
            )
    }
}
```

iOS 26 native equivalent (simpler, system-rendered glass refraction):

```swift
content
    .padding(20)
    .glassEffect(in: RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    .shadow(color: .black.opacity(colorScheme == .dark ? 0.28 : 0.08),
            radius: 14, x: 0, y: 5)
```

### Glass Density Tiers

| Tier | Use | Material | iOS 26 |
|---|---|---|---|
| **1 Ultra-light** | text fields, chips, segmented controls | `.ultraThinMaterial` | `.glassEffect(.regular)` |
| **2 Medium** | cards, modal sheets, focus containers | `.regularMaterial` | `.glassEffect()` |
| **3 Heavy** | nav bars, bottom sheets, full overlays | `.thickMaterial` | `.glassEffect(.regular.tint(.color.opacity(0.3)))` |

Don't double-stack glass on the same surface — compound material rendering is expensive.

---

## 6. INTERACTIVE PATTERNS (BUTTONS, DISMISS, CARDS)

### The "Pressable Glass" Button — modern `ButtonStyle`

Use a `ButtonStyle` so the press state is owned by SwiftUI; no manual gesture wiring.

```swift
struct PressableGlassButtonStyle: ButtonStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity, minHeight: 56)
            .padding(.horizontal, 20)
            .background(.regularMaterial, in: Capsule())
            .overlay {
                Capsule().strokeBorder(.white.opacity(0.20), lineWidth: 1)
            }
            .opacity(isEnabled ? 1 : 0.5)
            .scaleEffect(reduceMotion ? 1 : (configuration.isPressed ? 0.97 : 1))
            .animation(reduceMotion ? nil : .spring(response: 0.35, dampingFraction: 0.80),
                       value: configuration.isPressed)
            .sensoryFeedback(.impact(weight: .light), trigger: configuration.isPressed) { old, new in
                new == true   // fire only on press-down
            }
    }
}

// Usage
Button("Start Session", action: start)
    .buttonStyle(PressableGlassButtonStyle())
```

iOS 26 native interactive glass:

```swift
Button("Start Session", action: start)
    .buttonStyle(.glass)               // built-in
// or for fine control:
    .glassEffect(.regular.interactive())
```

### Glass Dismiss Button

```swift
struct GlassDismissButton: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.semibold))
                .foregroundStyle(.primary)
                .frame(width: 36, height: 36)
                .background(.thinMaterial, in: Circle())
        }
        .accessibilityLabel("Dismiss")
        .sensoryFeedback(.impact(weight: .light), trigger: false)
    }
}
```

---

## 7. MOTION CHOREOGRAPHY & HAPTIC ORCHESTRATION

### Reduce-Motion-Aware Spring Animations

Always gate animations:

```swift
@Environment(\.accessibilityReduceMotion) private var reduceMotion

.animation(reduceMotion ? .linear(duration: 0.2)
                        : .spring(response: 0.5, dampingFraction: 0.75),
           value: isPresented)
```

For SF Symbols use `.symbolEffect()` — Reduce Motion is handled by the system:

```swift
Image(systemName: "bell.fill")
    .symbolEffect(.bounce, value: notificationCount)

Image(systemName: "checkmark.circle.fill")
    .symbolEffect(.bounce, options: .nonRepeating, value: didComplete)
```

### Modern Haptics: `.sensoryFeedback`

iOS 17+. Prefer over `UIImpactFeedbackGenerator`.

| Interaction | Modifier | When |
|---|---|---|
| Light tap | `.sensoryFeedback(.impact(weight: .light), trigger: pressed)` | button press |
| Selection | `.sensoryFeedback(.selection, trigger: selectedID)` | picker rotation, segment change |
| Success | `.sensoryFeedback(.success, trigger: didComplete)` | quest complete, goal hit |
| Warning | `.sensoryFeedback(.warning, trigger: validationFailed)` | invalid input |
| Error | `.sensoryFeedback(.error, trigger: errorState)` | failed action |

For conditional firing:

```swift
.sensoryFeedback(trigger: completionCount) { oldValue, newValue in
    newValue > oldValue ? .success : nil
}
```

### Drag & Parallax (Depth Shift)

```swift
@State private var dragOffset: CGFloat = 0
@Environment(\.accessibilityReduceMotion) private var reduceMotion

ZStack {
    backgroundLayer
        .offset(y: reduceMotion ? 0 : dragOffset * 0.3)   // parallax disabled if reduced

    GlassCard { content }
        .offset(y: dragOffset * 0.8)
}
.gesture(
    DragGesture()
        .onChanged { dragOffset = $0.translation.height }
        .onEnded { _ in
            withAnimation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.8)) {
                dragOffset = 0
            }
        }
)
```

---

## 8. RESPONSIVE LAYOUTS & SAFE AREA

### Glass Modal with Safe Area

```swift
struct GlassModal: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Focus Session")
                    .font(.title.bold())              // semantic — scales with Dynamic Type
                Spacer()
                GlassDismissButton()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(items) { item in
                        ItemRow(item: item)
                    }
                }
                .padding(20)
            }
        }
        .background(.regularMaterial)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
        .presentationBackground(.regularMaterial)      // iOS 16.4+
    }
}
```

### Adaptive Grid (iPhone + iPad)

```swift
struct ResponsiveGlassGrid: View {
    @Environment(\.horizontalSizeClass) private var sizeClass
    let items: [Item]

    var columns: [GridItem] {
        let count = sizeClass == .regular ? 4 : 2
        return Array(repeating: GridItem(.flexible(), spacing: 16), count: count)
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(items) { item in
                    GlassCard(cornerRadius: 24) {
                        ItemContent(item: item)
                    }
                }
            }
            .padding(16)
        }
    }
}
```

---

## 9. PERFORMANCE GUARDRAILS

### Material Cost is Real

`.glassEffect()` and material backgrounds are GPU-bound. Patterns that hold up:

- **Do** apply glass to fixed overlays (nav bars, bottom sheets, modals).
- **Do** apply glass to a small bounded number of cards (≤ ~10 visible).
- **Don't** apply glass to every row of a long `List` / `ScrollView`. Use a solid `Color(.secondarySystemGroupedBackground)` for rows and reserve glass for the section header or a featured card.
- **Don't** stack two glass materials on the same surface.

### Prefer Cheap Animations

- `.offset`, `.scale`, `.opacity`, `.rotation` — cheap (compositor-only).
- `.frame(width:height:)` — relayout. Often fine, but profile before animating in lists.
- `.blur(radius:)` animated each frame — expensive. Animate alpha of a pre-blurred layer instead.

### `.drawingGroup()` — Use With Care

Pre-rasterizes a hierarchy into a Metal-backed image. Can fix complex compositing perf, but:
- Disables some accessibility traversal.
- Rasterizes at the current scale — Dynamic Type changes after composition won't re-rasterize cleanly.
- Can break `matchedGeometryEffect`.

Use only on leaf decorative views, not on text content.

---

## 10. ACCESSIBILITY (NON-NEGOTIABLE)

### Dynamic Type — Use Semantic Fonts

```swift
// Correct — scales with user setting
Text("Focus Session").font(.title.bold())
Text("45 minutes")   .font(.subheadline).foregroundStyle(.secondary)

// Custom font with Dynamic Type support
Text("Brand").font(.custom("Avenir-Heavy", size: 28, relativeTo: .title))

// Avoid — fixed pt size, ignores user preference
Text("Focus").font(.system(size: 28, weight: .bold))   // ❌
```

**Exception — decorative SF Symbols inside fixed-size containers:**

```swift
// OK — flame is decorative, hidden from VoiceOver, sized to its 80pt circle host
ZStack {
    Circle().fill(.regularMaterial).frame(width: 80, height: 80)
    Image(systemName: "flame.fill")
        .font(.system(size: 36, weight: .semibold))
        .accessibilityHidden(true)
}
```

The icon must conform to container geometry; scaling it via Dynamic Type would break the visual relationship with the host shape. For text the user reads, always use semantic fonts.

### Reduce Motion

Gate every spring / parallax / scale animation:

```swift
@Environment(\.accessibilityReduceMotion) private var reduceMotion

.animation(reduceMotion ? nil : .spring(response: 0.5, dampingFraction: 0.8), value: state)
```

For SF Symbols, `.symbolEffect()` honors Reduce Motion automatically.

### Reduce Transparency / Increase Contrast

Glass over busy content can fail contrast. Honor user settings:

```swift
@Environment(\.accessibilityReduceTransparency) private var reduceTransparency

.background(reduceTransparency ? AnyShapeStyle(Color(.secondarySystemBackground))
                                : AnyShapeStyle(.regularMaterial),
            in: RoundedRectangle(cornerRadius: 24, style: .continuous))
```

iOS 26's `.glassEffect()` adapts automatically, but custom materials need manual handling.

### VoiceOver

Every interactive glass element needs labels:

```swift
Button(action: start) {
    HStack { Image(systemName: "play.fill"); Text("Start") }
}
.accessibilityLabel("Start focus session")
.accessibilityHint("Begins a 45-minute focus block")
```

For purely decorative chrome (glass orbs, glow rings), mark `.accessibilityHidden(true)`.

### Hit Targets

Minimum 44 × 44 pt per HIG, even when the visual glass shape is smaller. Use `.contentShape(Rectangle())` to expand the tappable region without changing visuals.

---

## 11. EXECUTION PROTOCOL

When tasked with a glass-first interface:

1. **Variance Lock.** Pick 1 depth archetype, 1 motion choreography, 1 color archetype from §4. Use same combo across the screen.
2. **Foundation.** `Color(.systemBackground)` or asset-catalog adaptive color. No inline hex.
3. **Type Scale.** Define semantic hierarchy (`.largeTitle` → `.title` → `.headline` → `.body` → `.subheadline` → `.caption`). Custom fonts use `relativeTo:`.
4. **Glass Surfaces.** Apply `.glassEffect()` (iOS 26) or `.background(.material)` per density tier. Add hairline border highlights via `.strokeBorder` with light/dark-aware white opacity.
5. **Motion.** All transitions use spring physics gated on `accessibilityReduceMotion`. Stagger children via `.delay()` *inside* the animation, not on the view.
6. **Haptics.** Add `.sensoryFeedback()` for press / success / selection / error states.
7. **Accessibility Pass.** Semantic fonts, Reduce Motion gates, Reduce Transparency fallback, VoiceOver labels, 44pt hit targets, dark-mode adaptive colors and shadows.
8. **Verify.** Test in light + dark, with Larger Accessibility Sizes, with Reduce Motion ON, on iPhone + iPad if universal.

---

## 12. PRE-DELIVERY CHECKLIST

- [ ] **Depth Architecture** — one variant chosen, applied consistently.
- [ ] **Material API** — uses `.glassEffect()` (iOS 26+) or `.regularMaterial` family. **No `.backdropBlur()`** (it doesn't exist).
- [ ] **Springs** — `dampingFraction:` (not `dampingRatio`). `response:` tuned per density tier.
- [ ] **Reduce Motion** — every animation gated on `@Environment(\.accessibilityReduceMotion)`.
- [ ] **Reduce Transparency** — fallback solid background defined for `accessibilityReduceTransparency`.
- [ ] **Dynamic Type (text)** — text uses semantic fonts (`.title`, `.headline`, `.body`) or `.custom(_:size:relativeTo:)`. Decorative `Image(systemName:)` inside fixed-size shapes may use fixed `.font(.system(size:))` if `.accessibilityHidden(true)`.
- [ ] **Haptics** — `.sensoryFeedback()` (not `UIImpactFeedbackGenerator`) on press / success / selection.
- [ ] **Symbols** — `.symbolEffect()` for animated icons. Renders multicolor where appropriate.
- [ ] **Colors** — semantic (`.primary`, `.secondary`) or asset-catalog. No inline RGB / hex.
- [ ] **Shadows** — color/opacity adapts to `colorScheme`.
- [ ] **Glass cost** — material applied to fixed overlays + bounded card counts; not to long-list rows.
- [ ] **Buttons** — implemented as `ButtonStyle`, not manual `LongPressGesture` simulation.
- [ ] **VoiceOver** — every interactive element has `accessibilityLabel` (or is a `Button` with a clear text label) + `accessibilityHint` where action is non-obvious.
- [ ] **Hit targets** — ≥ 44 × 44 pt; expand via `.contentShape` if visual is smaller.
- [ ] **Safe Area** — `safeAreaInset` / `.ignoresSafeArea(edges:)` used deliberately.
- [ ] **Dark mode** — verified visually in both schemes.
- [ ] **iPad** — tested with `horizontalSizeClass == .regular` if universal.

---

## 13. QUICK REFERENCE PATTERNS

### Glass Focus Card

```swift
struct FocusCard: View {
    let title: String
    let subtitle: String
    let isComplete: Bool

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.title3.bold())
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
                .font(.title2)
                .foregroundStyle(isComplete ? .green : .secondary)
                .symbolEffect(.bounce, options: .nonRepeating, value: isComplete)
        }
        .padding(20)
        .glassEffect(in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}
```

### Bottom Sheet with Native Glass

```swift
@State private var isPresented = false

.sheet(isPresented: $isPresented) {
    NavigationStack {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(items) { ItemCard(item: $0) }
            }
            .padding(20)
        }
        .navigationTitle("Quests")
        .navigationBarTitleDisplayMode(.inline)
    }
    .presentationDetents([.medium, .large])
    .presentationDragIndicator(.visible)
    .presentationBackground(.regularMaterial)
}
```

### Morphing Glass Group (iOS 26)

```swift
@Namespace private var ns

GlassEffectContainer(spacing: 12) {
    HStack(spacing: 12) {
        ForEach(filters) { filter in
            Text(filter.name)
                .font(.subheadline.weight(.medium))
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .glassEffect(filter == selected ? .regular.tint(.accentColor) : .regular,
                             in: Capsule())
                .glassEffectID(filter.id, in: ns)
                .onTapGesture {
                    withAnimation(reduceMotion ? nil : .spring(response: 0.4, dampingFraction: 0.85)) {
                        selected = filter
                    }
                }
        }
    }
}
.sensoryFeedback(.selection, trigger: selected)
```

---

## 14. COMMON PITFALLS & FIXES

| Issue | Root Cause | Fix |
|---|---|---|
| `Cannot find 'backdropBlur'` build error | `.backdropBlur(radius:)` doesn't exist in SwiftUI | Use `.background(.regularMaterial)` or `.glassEffect()` |
| `Cannot find 'dampingRatio'` build error | `Animation.spring` parameter is `dampingFraction` | Rename `dampingRatio:` → `dampingFraction:` |
| Text doesn't grow with accessibility size | `.font(.system(size: 28))` is fixed | Use `.font(.title.bold())` or `.system(.title, weight: .bold)` |
| Animation runs even with Reduce Motion | Spring not gated | `reduceMotion ? nil : .spring(...)` |
| Glass over photos looks washed out | Reduce Transparency on, or just bad legibility | Add `accessibilityReduceTransparency` fallback to a solid color |
| Jank during scroll | Glass on every list row | Move glass to fixed nav / featured card; rows use solid background |
| Stagger delays don't fire | `.delay()` applied to View, not Animation | `.animation(.spring(...).delay(0.08), value: x)` |
| Card un-tappable in corners | Visual smaller than 44pt | Add `.contentShape(RoundedRectangle(...))` |
| Dark mode broken | Hardcoded RGB | Use `Color(.systemBackground)` / asset catalog |
| iPad layout busted | No size-class branching | `@Environment(\.horizontalSizeClass)` |
| VoiceOver silent on glass orb button | Missing label on icon-only `Button` | `.accessibilityLabel(...)` or use `Button(_, systemImage:)` |

---

## 15. INSPIRATION

Production iOS apps to study for liquid glass mastery:

- **Control Center (iOS 26)** — masterclass in `GlassEffectContainer` morphing + tier blending.
- **Camera app (iOS 26)** — interactive glass controls over live content.
- **Apple Music** — frosted player + kinetic drag.
- **Weather** — gradient + parallax + native glass overlays.
- **Reminders** — soft shadows, high contrast over glass surfaces.

---

**Final Directive:** Build glass surfaces that feel like precision-engineered material. Tap → compress. Dismiss → float away. Drag → respect gravity. Honor accessibility, honor performance, ship cinematic.
