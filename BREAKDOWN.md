# Beaklet — 45s Cinematic Brand Film · Breakdown

**Format (v9):** 2160×3840 **4K, 60 fps**, 9:16, 45.0 s · **Final (mastered −14 LUFS):** `renders/Beaklet_BrandFilm_45s_4K60_v9_SD.mp4` · earlier cuts kept in `renders/`
**Concept:** **SCREEN → INK.** The film opens in a typed monospace font (the screen) and hands its voice to an italic serif in beak-mustard (the pen).
The hornbill is drawn as 2D line art, then match-cut into the real beak-shaped pen clip.

---

## 1. Colour palette (sampled from the pen itself)

| Role | Hex | Where it comes from |
|---|---|---|
| Background · Ink black (warm) | `#0E0B09` | the black studio sweep in every clip, tinted warm (never pure #000) |
| Foreground · Cap cream | `#F1E6D6` | the blush-cream cap |
| Accent · Beak mustard | `#E0A82E` | the beak clip + cap top — the ONLY accent |
| Secondary · Muted taupe | `#B3A291` | labels / meta text |

One accent only, so every mustard element reads as "Beaklet".

## 2. Typography

- **Instrument Serif** (regular + *italic*): display voice. The italic in mustard is the "ink" register (*write?*, *became our clip.*, *Write again.*).
- **Space Mono**: the "screen" register: typed hook, chapter labels (`01 — SCREEN` … `06 — CRAFT`), tracked-out eyebrows.
- Serif + mono pairing = human vs machine, which is the whole story.

## 3. The hook (0–6 s), rebuilt in v2

References: the Rotoris reel, the engraving-style ad (one accent dot carried through every scene, big kinetic words) and the Majin promo (frame-filling type, sunburst, diagonal banner).

1. **0.0** A mustard **ink drop** falls into frame and squashes on landing; ruled notebook lines and a margin rule draw out from the centre.
2. **0.6** The drop opens into a **phone outline** that draws itself.
3. **0.8–2.0** Frame-filling mono **TYPE. / TAP. / SCROLL. / SWIPE.** slam in on each keystroke, each with its own entrance (blur-slam, side-snap, scroll-up, skew-swipe). VO: "You type all day."
4. **2.0** SWIPE gets swiped off; the phone collapses back into the drop.
5. **2.9** *when did you last…* rises word by word with the VO; the drop falls, trailing an ink line.
6. **4.4** Impact: ripples plus a slow **sunburst**, and **write?** erupts at 380px with a nib scratch and hand-drawn underline.
7. **5.3** The drop swells into a **mustard colour wipe**, then an **iris opens through it** into the handwriting footage.

## 4. Scene-by-scene (cuts locked to the music)

The BGM "Rise" has three hard section changes: **12.0 s** (bass drop), **24.4 s** and **36.4 s** (crash swells). Every act turn sits on one.

| # | Time | Picture | Type / motion | Sound |
|---|---|---|---|---|
| 01 Screen | 0.0–5.7 | ink drop → phone → kinetic slam → drop falls → sunburst | see §3 | VO1, drop + thump, 7 keystrokes, swipe swish, impact sub, nib scratch, wipe whoosh |
| 02 Ink | 5.7–12.0 | iris into handwriting macro → **stacked 3-panel collage** (FIG. 01 beak · 02 nib · 03 cap) | "INTRODUCING / **Beaklet** / *pens for a generation raised on screens.*" → panels slide in alternately → mustard diagonal banner slam *Worth keeping.* → everything slams out to black | riser into the drop, panel swishes, banner hit |
| 03 The Guide | **12.0**–17.0 | 2D hornbill line art on a breathing mustard glow + light leak | stroke-draw → casque/beak fill → eye pop; *the Malabar Pied Hornbill*; camera dives into the beak | **boom + sub drop**, wing flap, VO2, swish |
| 04 The Signature | 17.0–24.4 | match cut: real beak clip rising → logo-cap macro | masked line reveals: "Its beak / *became our clip.*" → "One shape. / *Endless stories.*" | cap click on cut |
| 05 Worlds | **24.4**–33.6 | 2 full-frame beat-cuts, then the **16:9 showcase card** (disc → lying pen → hero) | words on VO beats, each with a 2D line icon drawing in: Cities (skyline) · Cultures (dome) · *Art* (brush) · Architecture (column) · *History* (hourglass) → "becomes / *a pen.*" | boom, swishes on each cut, VO3, sub hit |
| 06 Craft | 33.6–40.4 | showcase card "FIG. 07 — Light study" with a key-light pass → card pushes through → **36.4** full-frame hero angle | "Premium. / *Never old-fashioned.*" → "COLLECTIBLE WRITING INSTRUMENTS / Collect / *the world.*" | page turn, boom, whoosh build |
| 07 End card | 40.4–45.0 | cream flash → ink black + glow | **official brand lockup from the Beaklet brand book**: the oval hornbill monogram opens and the bird flies in, then the **BEAKLET** wordmark (wave crossbar) rises letter by letter, *Write again.* inked + underline | music cuts to silence → boom + sub, chime, VO4 "Beaklet. Write again.", nib scratch |

## 5. Motion-graphics system

- **16:9 showcase (v2):** the four horizontal clips (27.4–36.4 s) never sit as bare bands any more. They play inside **one persistent framed card**: a perspective settle on entry, mustard crop marks, a blueprint dimension line, and a `FIG. 04–07` label that changes with each cut. Behind the card, a **blurred, darkened copy of the same shot** fills the 9:16 frame.
  On the hero shot a **detail inset** zooms 2.3× on the beak clip, with a drawn callout ring and leader line. The card exits by pushing through into the next full-frame shot.
- **Masked line reveals** (expo.out) for headlines; **blur-to-sharp letter rises** for brand moments; **ink wipes** for every mustard italic.
- **Stroke-draw** everywhere ink appears: hornbill, icons, underlines, clip glyph.
- **Chapter labels** top-left (mono + mustard rule), like a film's reel markers.
- Finishing: seeded film grain (12 fps), vignette, light leak on the drop, flash into the end card, slow Ken Burns on every shot.
- **Footage (v2):** the shaky handheld clips measured 2–3.5px of jitter at 1080p. Each one was **stabilized** (vid.stab, 2-pass, smoothing 40), **slowed** to 0.6–0.75× and **motion-interpolated to 60 fps**, which leaves about 0–0.3px of jitter. They were then upscaled with lanczos and a light sharpen. Ken Burns moves were reduced so they no longer amplify shake.
- 4K output: type, vectors and graphics render natively crisp at 2160×3840. The source footage is 480p, so it's upscaled and stays slightly soft compared with the graphics.

## 6. Sound design

- **BGM (v3, your pick from 5 previews):** "Prologue" by Hyperreal, CC BY 3.0. It's a trailer-style build: a quiet intro, a pulse that comes in around 12s, and a riser into a silence break. It starts at 1.07s into the track, so the **big drop lands exactly on "becomes a pen" (29.65s)**.
  It fades in over 1.2s and cuts to silence at 40.5s, so the logo lands on a boom. Under every VO line the bed is **EQ-carved, with a gentle level duck of up to about −6.7 dB** (HyperFrames carve). v6 fixes a bug that had left the carve inactive in earlier renders, which takes the drop under "becomes a pen" down about 5 dB.
- **VO:** Fish Audio "Adrian" (deep, measured storyteller), 4 lines.
- **SFX (v8): one sound per moment, chosen for what's on screen.** Every cue's loudest point is timed to its frame. Effects sit 7–10 dB under the voice and booms 3–5 dB under it.

  | Time | On screen | Sound |
  |---|---|---|
  | 0.4 · 4.3 · 29.6 | the ink drop lands / hits / "becomes a pen" | **water drops** (only on the ink moments) |
  | 0.8–1.7 · 4.5 · 42.4 | TYPE/TAP/SCROLL/SWIPE · *write?* · *Write again.* | keyboard taps · fountain-nib scratch |
  | 5.8 | the drop swells into the mustard wipe, iris opens into the footage | **deep airy whoosh** (the water swirl was removed, and the drop's watery tail now fades by 5.4s) |
  | 6.9 | "Beaklet" letters rise | **crystal twinkle** |
  | 8.8 · 9.0 · 9.1 | three panels slide in | **paper slide · paper flick · heavier paper slide** |
  | 10.3 | *Worth keeping.* banner | **rubber stamp** |
  | 12.0 | the drop | reverse air rise → **boom** |
  | 12.1–13.4 | hornbill line art draws itself | **pencil sketching** + **soft wing flap** |
  | 16.9 | camera dives into the beak | **air zoom whoosh** |
  | 21.0 | cut to the cap close-up | **pen click** |
  | 24.4 · 36.4 | section swells | **boom** |
  | 25.9 · 28.9 | journal-style word cuts | **two different page turns** |
  | 27.4 · 33.6 | "FIG." showcase card / light study | **two analogue camera shutters** |
  | 27.0–28.79 | the wooden disc tumbles, spins on its edge and settles | **metallic "coin" rattle**, the sound you picked from Preview_v4's 8–10s. It builds as the disc tumbles and stops dead on the settle at 28.79s |
  | 30.2 | detail inset + callout ring | tiny **glass ting** |
  | 34.8 | key light sweeps the pen | **soft shimmer** |
  | 36.3 · 40.45 | push-throughs | **air whoosh** · **reverse swell** into the end-card boom |

## 7. Watermark

`SD` mark (your `SD_watermark_white.png`), top-right at 55% opacity for the full film, outside the Reels UI zones.

## 8. Credits (required for CC BY assets, put these in the post caption or description)

- Music: "Prologue" by Hyperreal, CC BY 3.0, https://www.jamendo.com/track/1076983
- "Deep Cinematic Impact" by MeijstroAudio, CC BY 4.0, freesound.org/s/377303
- "Risers - Horror Whooshes Tension Builder 1" by original_sound, CC BY 3.0, freesound.org/s/494981
- "BirdFlap1.wav" by AgentDD, CC BY 3.0, freesound.org/s/246225
- Water drops, paper, stamp, pen click, page turns, shutters, whooshes, shimmer, keyboard and nib: CC0 (no credit needed). Font: Instrument Serif (OFL). Logo artwork: Beaklet brand book.
