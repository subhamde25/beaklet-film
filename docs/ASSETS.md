# Assets

Every file the film uses: where it came from, its licence, how it was processed, and where it
lands in the cut. "Archived" files were used by an earlier version and are kept for history. The
final `index.html` does not reference them.

**Storage:** `*.mp4` files are stored with **Git LFS** (`assets/hd60/` and `deliverables/`). Audio,
fonts, SVGs and images are ordinary git files. Raw source clips (`assets/clips/`), the v1 1080p
upscales (`assets/hd/`), stabiliser scratch (`assets/tmp/`), `renders/` and `previews/` are not in
the repo. `tools/prep-footage.sh` rebuilds them from the Drive download.

---

## 1. Footage — `assets/hd60/` (LFS)

Ten clips were supplied by Beaklet: six vertical 480×854 and four horizontal 854×480, all at
about 24 fps. The handheld macro shots had 2–3.5 px of jitter at 1080p, which the zooms made
worse. `tools/prep-footage.sh` produced the 60 fps versions the composition plays:

| Project name | Raw Drive file | What it shows | Treatment | Output | Where in the film |
|---|---|---|---|---|---|
| `writing` | `4f08b6a1-…` | nib writing in a notebook | stabilised, 0.75×, 60 fps | 1080×1920 | 5.7–8.8 s (iris reveal, "Introducing Beaklet") |
| `cap-rise-a` | `655d3997-…` | camera rises up the cap to the beak clip | stabilised, 0.6× | 1080×1920 | panel 3 (8.7 s), "Its beak became our clip" (17 s) |
| `cap-rise-b` | `8beedfc4-…` | same move, second take | stabilised, 0.6× | 1080×1920 | "Cultures" (25.9 s) |
| `duo-wide` | `d3114442-…` | cap upright + pen lying, wide | stabilised, 0.7× | 1080×1920 | "Cities" (24.4 s) |
| `cap-logo` | `d3fd4e77-…` | cap-top close-up with the bird logo | stabilised, 0.6× | 1080×1920 | panel 1 (8.7 s), "One shape" (21 s) |
| `duo-angle` | `ef09769e-…` | cap + nib, low angle | stabilised, 0.6× | 1080×1920 | panel 2 (8.7 s), "Collect the world" (36.4 s) |
| `hero-h` | `d78e6718-…` | cap upright + nib (16:9) | stabilised, 0.6× | 1440×810 | showcase hero + detail inset (29.65 s) |
| `disc-flip-h` | `234ac68c-…` | wooden disc tumbling (16:9) | trimmed to raw 18–24 s, 60 fps | 1440×810 | showcase "FIG. 04 — Motion" (27.4 s) |
| `lying-dark-h` | `d1b57cdc-…` | pen lying, low key (16:9) | 60 fps | 1440×810 | showcase "FIG. 05 — Form" (28.9 s) |
| `lying-sweep-h` | `c7f66e13-…` | pen lying, light sweep (16:9) | 60 fps | 1440×810 | showcase "FIG. 07 — Light study" (33.6 s) |

Processing in detail: vid.stab detect (shakiness 7, accuracy 15) → transform (smoothing 40, 4% zoom)
→ `setpts` slow-down → `minterpolate` to 60 fps (mci / aobmc / bidir) → lanczos upscale, unsharp,
`eq` contrast 1.05 / saturation 1.06 → H.264 CRF 14. Measured jitter after processing: 0–0.3 px.

The 16:9 clips play inside the **showcase card** (960×540) rather than as bare bands. A blurred,
darkened copy of the same clip fills the 9:16 frame behind the card.

## 2. Voiceover — `assets/audio/vo*.mp3`

Fish Audio TTS, voice **"Adrian"** (Fish official, deep, measured storyteller,
id `bf322df2096a46f18c579d0baa36f41d`).

| File | Line | Starts |
|---|---|---|
| `vo1.mp3` | "You type all day. … When did you last… *write?*" | 0.8 s |
| `vo2.mp3` | "Guided by a curious traveller… the Malabar Pied Hornbill." | 13.0 s |
| `vo3.mp3` | "Every city. Every culture. Every story he finds… becomes a pen." | 24.5 s |
| `vo4.mp3` | "Beaklet. … Write again." | 41.0 s |

## 3. Music — `assets/audio/`

| File | Track | Licence | Status |
|---|---|---|---|
| `bgm-prologue.mp3` | "Prologue" by Hyperreal (Jamendo 1076983) | CC BY 3.0 | **Used.** Starts 1.07 s into the track so its big drop lands on "becomes a pen" (29.65 s). Faded out at 40.0–40.55 s. Carved under the VO (EQ dips plus a ≤ −6.7 dB level duck) and dipped −3.5 dB at 27.8–28.85 s |
| `bgm-rise.mp3` | "Rise" by Meydän (Wikimedia Commons) | CC BY 4.0 | Archived (v1–v2). Its section changes at 12.0 / 24.4 / 36.4 s still set the edit's beat grid |

Prologue was chosen from five preview cuts: Rise, Prologue, The City (e s c p), Final Stretch
(oncoming way) and Helios Tilt (CM ONNI).

## 4. Sound effects

Levels are written as target peaks (dBFS) in a comment beside each `<audio>` cue in `index.html`.
Rule of thumb: effects sit 7–14 dB under the voice, section booms 3–5 dB under it.

### Used in the final cut (v9)

| Time | Cue id | File | Source · licence | On screen |
|---|---|---|---|---|
| 0.39 | `sfx-drop-in` | `sfx3/drop-deep.mp3` | paespedro "Single Water Drop" · CC0 | the ink drop lands |
| 0.8–1.7 | `k1`–`k7` | `.media/…/sfx_003.mp3` | jim-ph "keyboard5" · CC0 | TYPE / TAP / SCROLL / SWIPE |
| 4.30 | `sfx-ink-drop` | `sfx3/drop-cave.mp3` | Selulance "Cave Water Droplet 2" · CC0 | the drop hits (tail faded by 5.4 s) |
| 4.46 / 42.44 | `nib1` / `nib2` | `.media/…/sfx_004.mp3` | ListenTonyBoy "Pen Signature Signing 2" · CC0 | *write?* / *Write again.* |
| 4.98 | `sx-iris` | `sfx4/iris-whoosh.mp3` | Kinoton "Deep Whoosh #6" (EQ'd) · CC0 | mustard wipe → iris into footage |
| 6.66 | `sx-brand-twinkle` | `sfx4/brand-twinkle.mp3` | LaurenPonder "Crystal Twinkle" · CC0 | "Beaklet" letters rise |
| 8.52 | `sx-panel1` | `sfx4/panel-paper1.mp3` | MTJohnson "Sliding Envelope" · CC0 | panel 1 slides in |
| 8.71 | `sx-panel2` | `sfx4/panel-flick.mp3` | qubodup "Page Flip" (442858) · CC0 | panel 2 flicks in |
| 8.73 | `sx-panel3` | `sfx4/panel-paper3.mp3` | "Sliding Envelope", pitched −3 semitones · CC0 | panel 3 (heavier) |
| 9.97 | `sx-rise-drop` | `sfx4/rise-into-drop.mp3` | HowardV "White Noise Short Reverse Whoosh" · CC0 | reverse air into the drop |
| 10.26 | `sx-stamp` | `sfx4/stamp.mp3` | kermite607 "Stamp" · CC0 | *Worth keeping.* banner |
| 12.0 · 24.36 · 36.4 · 40.5 | `boom1`–`boom4` | `.media/…/sfx_002.mp3` | MeijstroAudio "Deep Cinematic Impact" · **CC BY 4.0** | section changes and the end card |
| 12.35 | `sx-pencil` | `sfx4/pencil-sketch.mp3` | Rinus_Marais "Pen scribbling sfx" · CC0 | hornbill line art sketches itself |
| 12.69 | `sx-wing` | `.media/…/sfx_011.mp3` | AgentDD "BirdFlap1" · **CC BY 3.0** | the hornbill |
| 16.78 | `sx-dive` | `sfx4/dive-whoosh.mp3` | qubodup "Swosh … air sound" (60026) · CC0 | camera dives into the beak |
| 20.74 | `sx-cap-click` | `sfx4/cap-click.mp3` | major_internau "Pen Click 1" · CC0 | cut to the cap close-up |
| 25.29 | `sx-page-a` | `sfx4/page-turn-a.mp3` | esperri "Book Turn Page 2" · CC0 | journal page turn (Cultures) |
| 26.39 | `sx-disc-rattle` | `.media/…/sfx_005.mp3` | original_sound "Risers – Horror Whooshes Tension Builder 1" · **CC BY 3.0** | the wooden disc spins; the rattle stops on its settle at 28.79 s |
| 27.00 | `sx-shutter-a` | `sfx4/shutter-a.mp3` | cabled_mess "Camera shutter analogue SLR 01" · CC0 | showcase card lands |
| 28.55 | `sx-page-b` | `sfx4/page-turn-b.mp3` | qubodup "Page Flip" (454707) · CC0 | journal page turn (Form) |
| 29.57 | `sfx-pen-drop` | `sfx3/drop-cave.mp3` | Selulance · CC0 | "becomes a pen" (ink moment) |
| 30.17 | `sx-ting` | `sfx3/glass-ting.mp3` | LuttoAudio "Glass Ting" · CC0 | detail inset + callout ring |
| 33.22 | `sx-shutter-b` | `sfx4/shutter-b.mp3` | cabled_mess "Camera shutter analogue SLR 02" · CC0 | light-study card |
| 34.35 | `sx-shimmer` | `sfx4/light-shimmer.mp3` | adh.dreaming "Shimmer" · CC0 | key light sweeps the pen |
| 36.21 | `sx-push` | `sfx4/push-whoosh.mp3` | qubodup "Swoosh 15 Windy" · CC0 | card pushes through |
| 39.98 | `sx-rise-logo` | `sfx4/rise-into-logo.mp3` | SlavicMagic "Backwards Whoosh" · CC0 | reverse swell into the end card |

The start times listed are the `data-start` values. Each sound's loudest point is offset to land on
its frame (for example, the iris whoosh starts at 4.98 s and peaks at 5.80 s).

`sfx3/` and `sfx4/` files were EQ'd (high-pass, gentle low-pass to soften harsh highs), trimmed and
normalised to −1 dBFS before placement.

### Archived (earlier versions)

| File | Was used for | Removed in |
|---|---|---|
| `sfx2/dw1.mp3`, `dw6.mp3` (Kinoton Deep Whoosh #1/#6) | v3 cut/card whooshes | v5 (dw6 lives on as `sfx4/iris-whoosh.mp3`) |
| `sfx2/cinimp.mp3`, `softimp.mp3` (Rizzard impacts) | v3 card + "becomes a pen" hit | v5 (the 30 s hit was too loud) |
| `sfx2/wl2.mp3`, `wl5.mp3` (moogy73 low wooshes) | v3 transitions | v5 |
| `sfx2/revglass.mp3` (burnttoys reversed cymbal) | v3 swell into 29.65 s | v5 |
| `sfx3/drop-warm.mp3`, `drop-bright.mp3` | v5–v6 water drops on the 21 / 25.9 / 28.9 s cuts | v7 (one sound reused everywhere) |
| `sfx3/swoosh-air.mp3` (creator_GT "Swoosh 06") | v4 panel slide | v5 |
| `sfx4/ink-swirl.mp3` (Joao_Janz "Water Swirl") | v7 ink-spread at 5.6 s | v8 (too watery) |
| `sfx4/disc-spin.mp3` (SpaceJoe "Coin Spin – 6", cut + pitched) | v8 disc spin | v9 (replaced with the rattle you picked) |
| `.media/…/sfx_001, 006, 007, 008, 009, 010` | bundled whoosh/click/chime, flag2 page turn, tim.kahn thump | v3–v5 |

`.media/manifest.jsonl` is the media-use ledger, holding the Openverse IDs and credits of every
resolved file. `.media/audio/sfx/CREDITS.md` lists the CC BY attributions it produced.

## 5. Type, brand and watermark

| File | What | Licence / source |
|---|---|---|
| `assets/fonts/InstrumentSerif-Regular.ttf`, `-Italic.ttf` | display serif + the italic "ink" voice | SIL OFL (google/fonts) |
| Space Mono | the "screen" voice, labels | bundled by HyperFrames (no file needed) |
| `assets/brand/beaklet-wordmark.svg` | BEAKLET wordmark with the wave-line crossbar | extracted as vectors from *Beaklet brand book.pdf* (p. 02) |
| `assets/brand/beaklet-monogram.svg` | oval hornbill/nib monogram (without the ® mark) | brand book p. 04 |
| `assets/img/sd-watermark.png` | white "SD▶" watermark, top-right at 55% | yours |

The two SVGs are **inlined** in `index.html` (S7 end card), so each path can animate. The files
here are the source vectors.

Brand-book reference for future work: Primary Blue `#2C45C4`, Charcoal `#374151`, Muted Gold
`#92816D`, Ivory `#F9FAFB`, Slate `#64748B`; primary typeface Urbanist, script "Humble Signation",
tagline "Craft Stories". The film keeps its mustard/ink palette, which comes from this pen's own
colours. Only the end card uses the official lockup.

## 6. Compositions — `compositions/`

| File | From | Use |
|---|---|---|
| `organic-light-leak-overlay.html` | HyperFrames registry block | warm leak on the 12 s drop, at 40% opacity |
| `components/grain-overlay.html`, `vignette.html` | registry components | reference only. `index.html` carries its own seeded, seek-safe grain and vignette |
