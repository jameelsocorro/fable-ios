---
version: "beta-3"
name: "Unified Glass Design System"
description: "A single design system merged from the light MentorBridge style and the dark Capital Overview Dashboard style. Brand tokens stay consistent across themes; theme tokens only adapt environment, contrast, density, and surface behavior. Dashboard colors are preserved as data/semantic accents rather than brand colors."
mode_strategy: "dual-theme-with-global-brand-tokens"
default_theme: "light"
source_files:
  - "DESIGN.md"
  - "DESIGN (1).md"

composition:
  layout: "Grid"
  content_width: "Bounded"
  framing: "Glassy"
  grid_strength: "Strong"

color_strategy:
  rule: "Do not redefine brand colors per theme. Light and dark themes may redefine only environmental colors: background, surface, text, border, shadow, blur, and density-specific treatment."
  brand_identity: "Warm sage / sand / earthy brown"
  dashboard_identity: "Indigo / emerald accents are allowed only for data, charts, metrics, technical highlights, and semantic states."

brand:
  primary: "#6E7A67"
  primary_foreground: "#F8F4ED"
  secondary: "#D8CEBF"
  tertiary: "#8A5A37"
  rule: "Primary, secondary, and tertiary are brand-level colors. They must not change between light and dark mode."

palette:
  brand:
    primary: "#6E7A67"
    primary_foreground: "#F8F4ED"
    secondary: "#D8CEBF"
    tertiary: "#8A5A37"
  base_neutrals:
    ink: "#1D1914"
    ink_soft: "#1F1B16"
    cream: "#F8F4ED"
    white: "#FFFFFF"
    warm_surface: "#FBF7F0"
    dark_base: "#111113"
    dark_surface: "#18181C"
    dark_surface_nested: "#1C1C21"
    dark_panel: "#1F2937"
    dark_border: "#374151"
    dark_muted_text: "#9CA3AF"
  dashboard:
    indigo: "#818CF8"
    emerald: "#34D399"
    dark_panel: "#1F2937"
    rule: "Use these as dashboard/data colors, not as primary, secondary, or tertiary brand colors."
  semantic:
    info: "#818CF8"
    success: "#34D399"
    rule: "Only info and success are defined from the source designs. Add warning/error only when the product actually needs those states."

legacy_color_mapping:
  original_light_primary: "#6E7A67 -> brand.primary"
  original_light_secondary: "#D8CEBF -> brand.secondary"
  original_light_tertiary: "#8A5A37 -> brand.tertiary"
  original_light_neutral: "#1D1914 -> theme.light.text_primary / palette.base_neutrals.ink"
  original_dark_primary: "#818CF8 -> dashboard.indigo / semantic.info"
  original_dark_secondary: "#1F2937 -> palette.base_neutrals.dark_panel / theme.dark.surface"
  original_dark_tertiary: "#34D399 -> dashboard.emerald / semantic.success"
  original_dark_neutral: "#FFFFFF -> theme.dark.text_primary / palette.base_neutrals.white"

colors:
  light:
    brand_primary: "{brand.primary}"
    brand_secondary: "{brand.secondary}"
    brand_tertiary: "{brand.tertiary}"
    primary_action_background: "{brand.primary}"
    primary_action_foreground: "{brand.primary_foreground}"
    background: "#FFFFFF"
    background_soft: "#F5EFE6"
    surface: "#FBF7F0"
    surface_glass: "rgba(251, 247, 240, 0.88)"
    surface_nested: "rgba(255, 255, 255, 0.46)"
    text_primary: "#1D1914"
    text_secondary: "#1F1B16"
    text_muted: "#5C5145"
    border: "#D8CEBE"
    border_soft: "#DDD2C2"
    selection_background: "#D7C2AB"
    selection_text: "#1F1B16"
    data_info: "#818CF8"
    data_success: "#34D399"
  dark:
    brand_primary: "{brand.primary}"
    brand_secondary: "{brand.secondary}"
    brand_tertiary: "{brand.tertiary}"
    primary_action_background: "{brand.primary}"
    primary_action_foreground: "{brand.primary_foreground}"
    background: "#111113"
    background_soft: "#131316"
    surface: "#18181C"
    surface_panel: "#1F2937"
    surface_nested: "#1C1C21"
    surface_deep: "#111113"
    text_primary: "#FFFFFF"
    text_secondary: "#9CA3AF"
    text_muted: "#9CA3AF"
    border: "#374151"
    border_soft: "rgba(31, 41, 55, 0.6)"
    selection_background: "rgba(110, 122, 103, 0.28)"
    selection_text: "#FFFFFF"
    data_info: "#818CF8"
    data_success: "#34D399"

backgrounds:
  light:
    base: "#FFFFFF"
    surface: "#FBF7F0"
    radial: "radial-gradient(circle at top, rgba(237,228,214,0.9) 0%, rgba(245,239,230,1) 42%, rgba(241,234,223,1) 100%)"
  dark:
    base: "#111113"
    surface: "#18181C"
    gradient: "linear-gradient(to top right, rgba(129, 140, 248, 0.05), rgba(52, 211, 153, 0.05))"
    rule: "The dark background may use dashboard indigo/emerald as a faint atmospheric gradient, but CTAs and brand anchors still use brand.primary."

typography:
  font_family: "Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif"
  display_lg:
    fontSize: "60px"
    fontWeight: 600
    lineHeight: "60px"
    letterSpacing: "-0.025em"
    usage: "Primary landing-page hero display. Prefer this for marketing or brand-led pages."
  headline_lg:
    fontSize: "36px"
    fontWeight: 600
    lineHeight: "40px"
    letterSpacing: "-0.025em"
    usage: "Dashboard or application headline. Prefer this for data-heavy screens."
  body_md:
    fontSize: "14px"
    fontWeight: 400
    lineHeight: "20px"
    usage: "Default application body text and dense UI copy."
  body_md_comfortable:
    fontSize: "14px"
    fontWeight: 400
    lineHeight: "28px"
    usage: "Marketing, FAQ, long-form copy, or airy sections."
  label_md:
    fontSize: "14px"
    fontWeight: 500
    lineHeight: "20px"
    usage: "Default button labels and medium-emphasis labels."
  label_sm:
    fontSize: "12px"
    fontWeight: 400
    lineHeight: "16px"
    usage: "Compact dashboards, metadata, helper labels, and dense controls."

spacing:
  base: "4px"
  scale:
    - "1px"
    - "2px"
    - "4px"
    - "6px"
    - "8px"
    - "10px"
    - "12px"
    - "16px"
    - "20px"
    - "24px"
    - "32px"
    - "40px"
    - "80px"
  section_padding:
    compact: "24px"
    standard: "32px"
    spacious: "40px"
    hero: "80px"
  card_padding:
    compact: "12px"
    standard: "16px"
    spacious: "24px"
  gap:
    compact: "8px"
    standard: "12px"
    spacious: "16px"
    section: "24px"

radii:
  xs: "2px"
  sm: "6px"
  md: "8px"
  lg: "12px"
  xl: "16px"
  xxl: "24px"
  card: "28px"
  shell: "32px"
  full: "9999px"

components:
  button_primary:
    default:
      role: "Main CTA"
      shape: "Pill"
      radius: "9999px"
      padding: "12px"
      typography: "label_md"
      light:
        backgroundColor: "{brand.primary}"
        textColor: "{brand.primary_foreground}"
        border: "0px solid transparent"
      dark:
        backgroundColor: "{brand.primary}"
        textColor: "{brand.primary_foreground}"
        border: "0px solid transparent"
      rule: "Primary CTA color is stable across modes. Do not use dashboard indigo as the main CTA color."
    compact_dashboard:
      role: "Dense dashboard action"
      shape: "Soft rectangle"
      radius: "8px"
      padding: "6px"
      typography: "label_sm"
      light:
        backgroundColor: "#FBF7F0"
        textColor: "#1D1914"
        border: "1px solid rgba(216, 206, 190, 0.75)"
      dark:
        backgroundColor: "#212126"
        textColor: "#9CA3AF"
        border: "1px solid rgba(55, 65, 81, 0.5)"
      rule: "Use this for compact dashboard controls only. If the control represents a data state, it may use data_info or data_success accents."
  button_secondary:
    default:
      role: "Secondary action"
      shape: "Pill"
      radius: "9999px"
      padding: "8px"
      typography: "label_md"
      light:
        backgroundColor: "transparent"
        textColor: "#1F1B16"
        border: "1px solid rgb(215, 203, 187)"
      dark:
        backgroundColor: "transparent"
        textColor: "#FFFFFF"
        border: "1px solid rgba(255, 255, 255, 0.16)"
  button_link:
    default:
      role: "Text link"
      radius: "0px"
      padding: "0px"
      typography: "label_md"
      light:
        textColor: "#5C5145"
      dark:
        textColor: "#9CA3AF"
  card:
    default:
      role: "Primary content surface"
      radius: "28px"
      padding: "24px"
      shadow: "none"
      light:
        backgroundColor: "rgba(251, 247, 240, 0.88)"
        border: "1px solid rgb(216, 206, 190)"
      dark:
        backgroundColor: "#18181C"
        border: "1px solid rgba(31, 41, 55, 0.6)"
    nested:
      role: "Nested surface or secondary panel"
      radius: "16px"
      padding: "16px"
      shadow: "none"
      light:
        backgroundColor: "rgba(255, 255, 255, 0.46)"
        border: "1px solid rgb(221, 210, 194)"
      dark:
        backgroundColor: "#1C1C21"
        border: "1px solid rgba(55, 65, 81, 0.5)"
    compact:
      role: "Dense metric, list, or dashboard block"
      radius: "12px"
      padding: "12px"
      shadow: "none"
      light:
        backgroundColor: "rgba(251, 247, 240, 0.72)"
        border: "1px solid rgb(217, 207, 191)"
      dark:
        backgroundColor: "#111113"
        border: "1px solid rgba(31, 41, 55, 0.4)"

surfaces:
  material: "Glass"
  blur:
    light: "24px"
    dark: "4px"
    rule: "Light mode uses softer/frostier blur; dark mode uses tighter glass to preserve dashboard readability."
  borders:
    light:
      - "1px #D8CEBE"
      - "1px #DDD2C2"
      - "1px #D7CBBB"
      - "1px #D9CFBF"
    dark:
      - "1px #374151"
      - "1px #1F2937"
      - "2px #131316"
      - "1px rgba(110, 122, 103, 0.34) for brand-tinted emphasis only"
  shadows:
    light:
      - "rgba(255, 255, 255, 0.75) 0px 1px 0px 0px inset, rgba(114, 93, 72, 0.04) 0px 1px 0px 0px"
      - "rgba(255, 255, 255, 0.14) 0px 1px 0px 0px inset"
    dark:
      - "rgba(0, 0, 0, 0.05) 0px 1px 2px 0px"
      - "rgba(0, 0, 0, 0.8) 0px 0px 50px -12px"
      - "rgba(0, 0, 0, 0.1) 0px 20px 25px -5px, rgba(0, 0, 0, 0.1) 0px 8px 10px -6px"
  gradient_border_shell:
    light:
      padding: "1px"
      radius: "32px"
      background: "linear-gradient(135deg, rgba(255, 255, 255, 0.72), rgba(173, 150, 127, 0.34), rgba(255, 255, 255, 0.52))"
    dark:
      padding: "1px"
      radius: "32px"
      background: "linear-gradient(135deg, rgba(110, 122, 103, 0.34), rgba(129, 140, 248, 0.16), rgba(255, 255, 255, 0.06))"
      rule: "The dark shell may include subtle indigo as atmospheric detail, but the brand tint should still be visible."

iconography:
  treatment: "Linear"
  sets:
    - "Solar"
  guidance: "Keep icon geometry soft, thin, and compatible with the radius system."

motion:
  default_level: "minimal"
  allowed_levels:
    minimal:
      usage: "Default for product UI, FAQ, forms, cards, and navigation."
      durations:
        - "150ms"
      easings:
        - "ease"
        - "cubic-bezier(0.4, 0, 0.2, 1)"
      hover_patterns:
        - "text"
    expressive:
      usage: "Allowed for dashboard reveals, hero sections, showcase panels, and premium edge treatments."
      durations:
        - "150ms"
        - "300ms"
        - "500ms"
        - "1000ms"
        - "2000ms"
      easings:
        - "ease"
        - "cubic-bezier(0.4, 0, 1)"
      hover_patterns:
        - "text"
        - "stroke"
        - "color"
        - "brightness"
        - "shadow"
  scroll_patterns:
    - "gsap-scrolltrigger"

webgl:
  status: "optional"
  theme_fit: "Best for light mode hero or atmospheric landing sections. Can be adapted for dark mode using lower contrast."
  id: "webgl"
  label: "WebGL"
  stack: "WebGL"
  scene: "Full-bleed background field"
  effect: "Dot-matrix particle field"
  primitives: "Dot particles + soft depth fade"
  motion: "Slow breathing pulse"
  interaction: "Pointer-reactive drift"
  render: "alpha, antialias, DPR clamp, custom shaders"
  techniques:
    - "Dot matrix"
    - "Breathing pulse"
    - "Pointer parallax"
    - "Shader gradients"
    - "Noise fields"
  fallback: "Always preserve a DOM/CSS background fallback."
---

# Unified Glass Design System

This document merges the two design files into a single design system. The safest interpretation is that the files represent two related modes: a warm light mode and a compact dark dashboard mode.

The most important rule is that **brand colors are not theme colors**. A token like `primary`, `secondary`, or `tertiary` should stay consistent across light and dark mode. Theme tokens should only adapt the surrounding environment: background, surface, text, border, shadow, blur, and density.

## 1. Design Direction

The unified system should feel glassy, bounded, structured, and premium. Layout should stay grid-based, content should remain bounded, and surfaces should use border contrast, blur, and subtle depth rather than heavy shadows.

The light theme is warmer, calmer, and more spacious. It is best for landing pages, FAQ sections, onboarding, marketing, and content-heavy screens.

The dark theme is denser, more technical, and more dashboard-like. It is best for analytics, admin views, product showcases, and compact workflows.

## 2. Color Token Rules

### Stable brand tokens

These colors define the product identity. They should not change between light and dark mode.

| Role | Token | Usage |
|---|---:|---|
| Brand Primary | `#6E7A67` | Main brand color, primary CTA, active state, brand emphasis |
| Primary Foreground | `#F8F4ED` | Text/icon color on primary actions |
| Brand Secondary | `#D8CEBF` | Warm supporting tone, dividers, secondary fills |
| Brand Tertiary | `#8A5A37` | Warm earthy accent, highlights, editorial emphasis |

### Theme tokens

These colors are allowed to change per mode.

| Role | Light Mode | Dark Mode |
|---|---:|---:|
| Background | `#FFFFFF` | `#111113` |
| Soft Background | `#F5EFE6` | `#131316` |
| Surface | `#FBF7F0` | `#18181C` |
| Nested Surface | `rgba(255,255,255,0.46)` | `#1C1C21` |
| Panel Surface | `#FBF7F0` | `#1F2937` |
| Text Primary | `#1D1914` | `#FFFFFF` |
| Text Secondary | `#1F1B16` | `#9CA3AF` |
| Text Muted | `#5C5145` | `#9CA3AF` |
| Border | `#D8CEBE` | `#374151` |

### Dashboard and semantic accents

These colors came from the dark dashboard direction. Keep them, but do not treat them as brand colors.

| Role | Token | Usage |
|---|---:|---|
| Data Info / Indigo | `#818CF8` | Charts, metrics, info states, technical glows, graph accents |
| Data Success / Emerald | `#34D399` | Positive metrics, success states, completion indicators |
| Dark Panel | `#1F2937` | Dark-mode panel surface, not a brand secondary color |

## 3. Conflict Resolution

The original files used the same color role names for different purposes. The unified system resolves those conflicts like this:

| Original Conflict | Resolution |
|---|---|
| Light `primary: #6E7A67` vs dark `primary: #818CF8` | `#6E7A67` becomes global `brand.primary`; `#818CF8` becomes `data_info` / dashboard indigo |
| Light `secondary: #D8CEBF` vs dark `secondary: #1F2937` | `#D8CEBF` becomes global `brand.secondary`; `#1F2937` becomes dark `surface_panel` |
| Light `tertiary: #8A5A37` vs dark `tertiary: #34D399` | `#8A5A37` becomes global `brand.tertiary`; `#34D399` becomes `data_success` |
| Light `neutral: #1D1914` vs dark `neutral: #FFFFFF` | `neutral` is removed as a global brand role; use `text_primary` per theme instead |
| Light `accent: #6E7A67` vs dark `accent: #818CF8` | Brand accent follows `brand.primary`; dashboard accent uses `data_info` |

## 4. Composition Rules

- Use a grid layout as the default page structure.
- Keep content width bounded instead of full-width by default.
- Use glass surfaces as the primary visual material.
- Preserve a strong rhythm between panels, cards, controls, and whitespace.
- Use the 4px base spacing system across both light and dark modes.
- Keep brand tokens consistent across themes.

## 5. Light Theme

Use light mode when the interface needs to feel editorial, approachable, calm, or brand-led.

| Role | Token |
|---|---:|
| Brand Primary | `#6E7A67` |
| Brand Secondary | `#D8CEBF` |
| Brand Tertiary | `#8A5A37` |
| Primary Action Background | `#6E7A67` |
| Primary Action Foreground | `#F8F4ED` |
| Background | `#FFFFFF` |
| Soft Background | `#F5EFE6` |
| Surface | `#FBF7F0` |
| Glass Surface | `rgba(251, 247, 240, 0.88)` |
| Nested Surface | `rgba(255, 255, 255, 0.46)` |
| Text Primary | `#1D1914` |
| Text Secondary | `#1F1B16` |
| Muted Text / Link | `#5C5145` |
| Border | `#D8CEBE` |
| Border Soft | `#DDD2C2` |
| Data Info | `#818CF8` |
| Data Success | `#34D399` |

Recommended light background:

```css
background: radial-gradient(
  circle at top,
  rgba(237, 228, 214, 0.9) 0%,
  rgba(245, 239, 230, 1) 42%,
  rgba(241, 234, 223, 1) 100%
);
```

## 6. Dark Theme

Use dark mode when the interface needs to feel technical, focused, premium, compact, or dashboard-oriented.

| Role | Token |
|---|---:|
| Brand Primary | `#6E7A67` |
| Brand Secondary | `#D8CEBF` |
| Brand Tertiary | `#8A5A37` |
| Primary Action Background | `#6E7A67` |
| Primary Action Foreground | `#F8F4ED` |
| Background | `#111113` |
| Soft Background | `#131316` |
| Surface | `#18181C` |
| Panel Surface | `#1F2937` |
| Nested Surface | `#1C1C21` |
| Deep Surface | `#111113` |
| Text Primary | `#FFFFFF` |
| Text Secondary | `#9CA3AF` |
| Muted Text | `#9CA3AF` |
| Border | `#374151` |
| Border Soft | `rgba(31, 41, 55, 0.6)` |
| Data Info | `#818CF8` |
| Data Success | `#34D399` |

Recommended dark background:

```css
background: linear-gradient(
  to top right,
  rgba(129, 140, 248, 0.05),
  rgba(52, 211, 153, 0.05)
);
```

Use the indigo/emerald gradient only as atmosphere. It should not make the product identity look like an indigo brand.

## 7. Typography

Typography uses Inter across display, body, and utility text.

| Token | Size | Weight | Line Height | Usage |
|---|---:|---:|---:|---|
| `display-lg` | 60px | 600 | 60px | Landing page hero, brand-led sections |
| `headline-lg` | 36px | 600 | 40px | Dashboard title, app headline, section headline |
| `body-md` | 14px | 400 | 20px | Default app body, dense UI copy |
| `body-md-comfortable` | 14px | 400 | 28px | FAQ, marketing, long-form content |
| `label-md` | 14px | 500 | 20px | Buttons, tabs, medium-emphasis labels |
| `label-sm` | 12px | 400 | 16px | Metadata, compact labels, dense dashboard controls |

### Typography Resolution

The light file used a larger display style and more relaxed body line-height. The dark file used a smaller headline and denser body/label rhythm. Keep both, but use them by context:

- Use `display-lg` and `body-md-comfortable` for landing pages, FAQ, onboarding, and marketing.
- Use `headline-lg`, `body-md`, and `label-sm` for dashboards, admin screens, metric panels, and dense UI.

## 8. Layout and Spacing

Use 4px as the base rhythm. Larger values should step from that cadence instead of introducing unrelated spacing values.

| Token | Value |
|---|---:|
| Base | 4px |
| Compact section padding | 24px |
| Standard section padding | 32px |
| Spacious section padding | 40px |
| Hero section padding | 80px |
| Compact card padding | 12px |
| Standard card padding | 16px |
| Spacious card padding | 24px |
| Compact gap | 8px |
| Standard gap | 12px |
| Spacious gap | 16px |
| Section gap | 24px |

Allowed spacing scale:

```txt
1px, 2px, 4px, 6px, 8px, 10px, 12px, 16px, 20px, 24px, 32px, 40px, 80px
```

## 9. Radius System

Use a shared radius family. Do not invent unrelated values unless a component requires it.

| Token | Value | Usage |
|---|---:|---|
| `xs` | 2px | Tiny details, hairline UI |
| `sm` | 6px | Small controls or compact surfaces |
| `md` | 8px | Compact dashboard buttons |
| `lg` | 12px | Compact cards, metric blocks |
| `xl` | 16px | Nested cards and standard panels |
| `xxl` | 24px | Large sections and roomy panels |
| `card` | 28px | Main light-mode cards |
| `shell` | 32px | Gradient border shells |
| `full` | 9999px | Pills, primary CTAs, badges |

## 10. Components

### Primary Button

Use this for the main CTA across both modes.

| Property | Value |
|---|---:|
| Shape | Pill |
| Radius | 9999px |
| Padding | 12px |
| Typography | `label-md` |
| Background | `#6E7A67` |
| Text | `#F8F4ED` |

Rule: The primary button should stay sage in both light and dark mode. Do not switch it to indigo in dark mode.

### Compact Dashboard Button

Use this only for dense dashboards or compact app controls.

| Mode | Background | Text | Border | Radius | Padding |
|---|---:|---:|---:|---:|---:|
| Light | `#FBF7F0` | `#1D1914` | `1px rgba(216,206,190,0.75)` | 8px | 6px |
| Dark | `#212126` | `#9CA3AF` | `1px rgba(55,65,81,0.5)` | 8px | 6px |

### Secondary Button

| Mode | Background | Text | Border | Radius | Padding |
|---|---:|---:|---:|---:|---:|
| Light | transparent | `#1F1B16` | `1px rgb(215,203,187)` | 9999px | 8px |
| Dark | transparent | `#FFFFFF` | `1px rgba(255,255,255,0.16)` | 9999px | 8px |

### Link Button

| Mode | Text | Radius | Padding |
|---|---:|---:|---:|
| Light | `#5C5145` | 0px | 0px |
| Dark | `#9CA3AF` | 0px | 0px |

### Cards and Surfaces

| Component | Mode | Background | Border | Radius | Padding |
|---|---|---:|---:|---:|---:|
| Primary Card | Light | `rgba(251,247,240,0.88)` | `1px rgb(216,206,190)` | 28px | 24px |
| Primary Card | Dark | `#18181C` | `1px rgba(31,41,55,0.6)` | 28px | 24px |
| Nested Card | Light | `rgba(255,255,255,0.46)` | `1px rgb(221,210,194)` | 16px | 16px |
| Nested Card | Dark | `#1C1C21` | `1px rgba(55,65,81,0.5)` | 16px | 16px |
| Compact Card | Light | `rgba(251,247,240,0.72)` | `1px rgb(217,207,191)` | 12px | 12px |
| Compact Card | Dark | `#111113` | `1px rgba(31,41,55,0.4)` | 12px | 12px |

## 11. Elevation and Depth

Depth is communicated through glass, border contrast, blur, and restrained shadows. The system should not rely on heavy shadows as the primary depth cue.

### Light Glass

- Blur: 24px
- Border family: `#D8CEBE`, `#DDD2C2`, `#D7CBBB`, `#D9CFBF`
- Shadow: mostly inset white highlights and very soft warm shadows

Gradient border shell:

```css
background: linear-gradient(
  135deg,
  rgba(255, 255, 255, 0.72),
  rgba(173, 150, 127, 0.34),
  rgba(255, 255, 255, 0.52)
);
padding: 1px;
border-radius: 32px;
```

### Dark Glass

- Blur: 4px
- Border family: `#374151`, `#1F2937`, `#131316`
- Shadow: low-opacity black shadows for compact depth

Gradient border shell:

```css
background: linear-gradient(
  135deg,
  rgba(110, 122, 103, 0.34),
  rgba(129, 140, 248, 0.16),
  rgba(255, 255, 255, 0.06)
);
padding: 1px;
border-radius: 32px;
```

## 12. Iconography

- Treatment: Linear
- Icon set: Solar
- Keep icons thin, soft, and compatible with rounded glass surfaces.
- Avoid mixing filled icon families unless a specific active state needs it.

## 13. Motion

Motion should default to minimal. Use expressive motion only where the interface is presenting a premium hero, dashboard reveal, or showcase moment.

| Level | Usage | Durations | Hover |
|---|---|---|---|
| Minimal | Product UI, forms, FAQ, navigation | 150ms | text |
| Expressive | Hero, dashboard reveals, showcase panels | 150ms, 300ms, 500ms, 1000ms, 2000ms | text, stroke, color, brightness, shadow |

Allowed scroll pattern:

```txt
gsap-scrolltrigger
```

## 14. WebGL Background

WebGL is optional. It should not be required for the whole system.

Use it for atmospheric hero sections, especially when the screen needs to feel technical, meditative, or premium.

- Scene: Full-bleed background field
- Effect: Dot-matrix particle field
- Primitives: Dot particles + soft depth fade
- Motion: Slow breathing pulse
- Interaction: Pointer-reactive drift
- Render: alpha, antialias, DPR clamp, custom shaders
- Techniques: dot matrix, breathing pulse, pointer parallax, shader gradients, noise fields
- Fallback: Always preserve a DOM/CSS background fallback

## 15. Do's and Don'ts

### Do

- Do keep `#6E7A67` as the global primary color.
- Do keep `#D8CEBF` as the global secondary brand color.
- Do keep `#8A5A37` as the global tertiary brand color.
- Do use `#818CF8` for info, charts, dashboard highlights, and technical accents.
- Do use `#34D399` for success states and positive metrics.
- Do let backgrounds, surfaces, text, and borders change per theme.
- Do keep spacing aligned to the 4px rhythm.
- Do reuse the glass material consistently.

### Don't

- Don't redefine `primary` in dark mode.
- Don't use `#818CF8` as the main brand CTA color.
- Don't use `#34D399` as the global tertiary brand color.
- Don't treat `neutral` as a global brand color, because neutral changes by theme.
- Don't mix unrelated shadow, blur, or surface recipes.
- Don't add new accent colors unless the product needs a clear semantic state.

## 16. Implementation Notes

Recommended token structure:

```ts
export const brand = {
  primary: '#6E7A67',
  primaryForeground: '#F8F4ED',
  secondary: '#D8CEBF',
  tertiary: '#8A5A37',
} as const;

export const data = {
  info: '#818CF8',
  success: '#34D399',
} as const;

export const themes = {
  light: {
    background: '#FFFFFF',
    backgroundSoft: '#F5EFE6',
    surface: '#FBF7F0',
    surfaceGlass: 'rgba(251, 247, 240, 0.88)',
    surfaceNested: 'rgba(255, 255, 255, 0.46)',
    textPrimary: '#1D1914',
    textSecondary: '#1F1B16',
    textMuted: '#5C5145',
    border: '#D8CEBE',
  },
  dark: {
    background: '#111113',
    backgroundSoft: '#131316',
    surface: '#18181C',
    surfacePanel: '#1F2937',
    surfaceNested: '#1C1C21',
    textPrimary: '#FFFFFF',
    textSecondary: '#9CA3AF',
    textMuted: '#9CA3AF',
    border: '#374151',
  },
} as const;
```

