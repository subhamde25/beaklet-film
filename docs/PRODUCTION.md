# Production notes

How the film is built, rendered and revised, plus the decisions and fixes along the way.

## Pipeline

```
Drive clips ──tools/prep-footage.sh──▶ assets/hd60/ (stabilised, slowed, 60 fps)
                                              │
assets/audio + .media (VO, music, SFX) ───────┤
assets/brand + fonts + watermark ─────────────┤
                                              ▼
                                         index.html  (HyperFrames: one composition,
                                              │       one paused GSAP timeline in global time)
              npx hyperframes check ──────────┤
                                              ▼
            4K 60 fps render (segmented, low-memory) ──▶ renders/*-raw.mp4
                                              │
                    tools/mux-and-master.sh ──▶ −14 LUFS master ──▶ deliverables/
```

## Composition structure

`index.html` is a single, monolithic composition: 1080×1920, 45 s, rendered at DPR 2 for 4K.
All motion lives on one paused GSAP timeline in **global time**, registered as
`window.__timelines["main"]`.

- **Footage layer:** untimed wrappers (`.vwrap`, `.panel`, `.card`) hold timed `<video class="clip">`
  elements. Ken Burns, zooms and masks animate the wrappers, never the timed video.
- **Scenes:** `#s1`–`#s7` are timed overlay `div`s that hold the type and vector graphics.
  Text slots that share a position are switched with `visibility` windows, so the layout audit
  never sees two of them at once.
- **Showcase (27.4–36.4 s):** `#sc-fill` (blurred copy of the clip), `#sc-card` (the 16:9 clip),
  `#sc-inset` (2.25× detail on the beak clip), `#sc-chrome` (crop marks, dimension line,
  FIG. labels, callout).
- **Finishing:** light-leak sub-composition at 12 s, cream flash into the end card, vignette,
  seeded 12 fps grain, and the SD watermark.
- **Audio:** each `<audio>` cue sets `data-start` so the sound's **peak** lands on its frame. Its
  target peak level (dBFS) is noted in a comment beside the cue.

## Checks

```bash
npx hyperframes lint                     # quick structural pass
npx hyperframes check --timeout 20000    # lint + runtime + layout + motion + contrast
npx hyperframes snapshot --at 5.9,12.6,27.7,31.2,41.8 --timeout 20000
```

The 60 fps sources are heavy, so use `--timeout 20000`. With the default 3 s timeout, check can
report a false `404` on an audio file. Expected warnings: `nested_structure_needs_subcomposition`
(×7) and `composition_file_too_large`. The film is intentionally monolithic.

## Rendering

**Final picture (4K, 60 fps), about 40–48 minutes:**

```bash
HF_SEGMENTED_CAPTURE=true npx hyperframes render -q delivery --fps 60 --resolution portrait-4k \
  --low-memory-mode --resume --player-ready-timeout 180000 --browser-timeout 300 \
  --protocol-timeout 600000 -o renders/beaklet-4k60-raw.mp4
```

The build machine has about 7 GB RAM. The first plain 4K render died at frame 1016/2700 with
0.1 GB free. Segmented capture with `--resume` keeps finished segments if a run crashes.

### Audio-only revisions

When only `<audio>` cues or the music automation change, the picture is identical, so skip the
4K render:

```bash
HF_SEGMENTED_CAPTURE=true npx hyperframes render -q draft --fps 30 --low-memory-mode --resume \
  -o renders/_audio-draft.mp4                                         # ~9 min, same mixer
tools/mux-and-master.sh renders/beaklet-v5-4k60-raw.mp4 renders/_audio-draft.mp4 \
  deliverables/Beaklet_BrandFilm_45s_4K60_vN_SD.mp4
```

v6–v9 were all made this way on the v5 picture.

### Mastering

`tools/mux-and-master.sh` runs two-pass `loudnorm` to **−14 LUFS integrated, −1.2 dBTP**, with
AAC 256k audio and the video stream copied untouched. The final measures −13.8 LUFS.

### Auditioning music

`tools/premix.py` builds a fast ffmpeg mix: every cue plus a candidate bed, level-matched and
sidechain-ducked under the VO. Mux it onto a 720p proxy to compare tracks. The five
`previews/Option_*.mp4` files were made this way.

## Verifying sound changes

Every audio revision was checked by measuring the render, not by trusting the numbers in the HTML:

- **Band-limited levels.** Full-band peaks are dominated by music bass. Crisp sounds (paper,
  shutters, clicks) were measured above 3 kHz, whooshes in a band around 900 Hz.
- **Mix subtraction.** Subtract the previous render (gain-matched on an unchanged window) to
  isolate exactly what a change added, and how far it sits under the mix.
- **Timing.** The loudest point of the isolated sound is checked against its target frame. The
  disc strike landed at 28.054 s against a 28.05 s target.

## Version history

| Version | Date | What changed | Why |
|---|---|---|---|
| v1 | 19 Oct | 1080p30 cut: typewriter hook, hornbill line art, letterbox bands, "Rise" by Meydän, Fish VO | first delivery |
| v2 | 19 Oct | **New hook:** ink-drop through-object, phone outline, TYPE/TAP/SCROLL/SWIPE slam, sunburst, mustard iris. **6–12 s:** stacked FIG. panels and a diagonal banner. **Footage** stabilised, slowed, 60 fps. **16:9 shots** in a showcase card. First **4K 60** | hook not attractive enough. Clips shaking. 16:9 shots looked odd. References: Rotoris reel, engraving-style ad, Majin promo |
| v3 | 19 Oct | Music → **"Prologue" (Hyperreal)**, picked from 5 preview cuts. Premium CC0 whooshes and impacts replace every bundled swish | 26–29 s SFX sounded unprofessional, and a more engaging track was wanted |
| v4 | 19 Oct | (preview only) all SFX rebalanced under the VO, water-drop transitions | SFX too loud, especially at 30 s |
| v5 | 19 Oct | Fewer effects: water drops + booms only. **Official logo** on the end card | user chose "fewer effects" and "real logo on end card" from the brand book |
| v6 | 19 Oct | **Bug fix:** the music `<audio>` had two `data-automation` attributes, so the browser dropped the carve. Merged them, with the level duck scaled to ≤ −6.7 dB | the drop under "becomes a pen" was louder than the voice |
| v7 | 19 Oct | A distinct, story-matched sound for every moment from 5 to 40 s. Masked cues raised and retimed | the middle felt silent, and the same drop was reused on every cut |
| v8 | 19 Oct | 5 s water swirl → deep whoosh into the iris (drop tail faded by 5.4 s). Disc spin cut to the footage's tracked motion | the water sound was disliked, and the disc needed a real spin sound |
| **v9** | 19 Oct | The disc shot uses the "coin" rattle (riser) from the v4 preview, stopping on the settle at 28.79 s | your pick from the earlier version |

## Gotchas (learned the hard way)

1. **Never put two `data-automation` attributes on one element.** HTML keeps only the first.
   `carve.mjs` appended a second one, which silently disabled the carve in v1–v5. Merge lanes into
   one JSON (`volume` + `fx.n1–n7.gain`).
2. **The carve's level lane is aggressive** (down to −19 dB with a slow release). Scale it: v6+
   uses ×0.35, so at most −6.7 dB.
3. **Sound levels set by sample peak can still be inaudible.** A spin or rattle's body sits about
   25 dB under its strike. Compress first, then level by the body's RMS.
4. **The 60 fps sources had sparse keyframes** (4.2 s GOP), which the compiler flags as a seek risk.
   Renders were fine, but `prep-footage.sh` now encodes with a 1 s GOP.
5. **Wrap any render you background in a wait on its PID**, not a log grep: "0 error(s)" matches
   `rror`.
6. **Instagram embed for references:** `/p/<id>/embed/` exposes the reel's video without login.
