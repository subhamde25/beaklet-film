# Beaklet — 45s Cinematic Brand Film

A 45-second vertical (9:16) brand film for **Beaklet**, a story-driven writing-instruments brand
(≈ ₹3,000 fountain pens, mascot: the Malabar Pied Hornbill). Built as a motion-graphics and
editing test assignment, authored in [HyperFrames](https://hyperframes.heygen.com) (HTML + GSAP),
and rendered to **4K 60 fps**.

| | |
|---|---|
| **Final cut** | [`deliverables/Beaklet_BrandFilm_45s_4K60_v9_SD.mp4`](deliverables/) (2160×3840, 60 fps, 45.0 s, −13.8 LUFS, Git LFS) |
| **Concept** | **Screen → Ink.** A typed monospace "screen" voice hands over to an italic-serif "ink" voice |
| **Palette** | ink black `#0E0B09` · cap cream `#F1E6D6` · beak mustard `#E0A82E` · taupe `#B3A291` |
| **Type** | Instrument Serif (display + italic "ink") · Space Mono (screen/labels) |
| **Music** | "Prologue" by Hyperreal (CC BY 3.0), timed so its big drop lands on "becomes a pen" |
| **Voice** | Fish Audio "Adrian" (deep storyteller), 4 lines |
| **Logo** | Official BEAKLET wordmark and hornbill monogram, extracted as vectors from the brand book |
| **Watermark** | SD mark, top-right, 55% opacity |

> Creative rationale, the scene-by-scene beat sheet and the full sound cue sheet are in
> [`BREAKDOWN.md`](BREAKDOWN.md). The confirmed brief is in [`BRIEF.md`](BRIEF.md).

## The film in one glance

| Time | Scene | What happens |
|---|---|---|
| 0–5.7 s | **01 Screen** (hook) | An ink drop falls into frame. A phone outline draws itself, and TYPE · TAP · SCROLL · SWIPE slam in on keystrokes. The drop falls, and ***write?*** erupts over a sunburst. The drop swells into a mustard wipe, which irises open into the footage |
| 5.7–12 s | **02 Ink** | "Introducing **Beaklet**" over a handwriting macro shot. Three stacked "FIG." panels slide in, a ***Worth keeping.*** banner stamps across, and everything slams out for the drop |
| 12–17 s | **03 The Guide** | A 2D gold line drawing of the hornbill sketches itself, then the camera dives into its beak |
| 17–24.4 s | **04 The Signature** | Match cut to the real beak-shaped clip: "Its beak / *became our clip.*" → "One shape. / *Endless stories.*" |
| 24.4–33.6 s | **05 Worlds** | Cities · Cultures · *Art* · Architecture · *History* with line icons. The 16:9 shots play inside a "FIG." showcase card with a detail inset → "becomes / *a pen.*" |
| 33.6–40.4 s | **06 Craft** | A light-study card ("Premium. / *Never old-fashioned.*") pushes through to "Collect / *the world.*" |
| 40.4–45 s | **07 End card** | The official monogram and wordmark animate in, then ***Write again.*** |

## Project layout

```
beaklet-film/
├── index.html                 # the whole film: one composition, one global-time GSAP timeline
├── compositions/              # registry blocks (light leak) + pasted components (grain, vignette)
├── assets/
│   ├── audio/                 # VO (vo1–4), music beds, SFX sets sfx2/ sfx3/ sfx4/
│   ├── brand/                 # official wordmark + monogram SVGs (from the brand book)
│   ├── fonts/                 # Instrument Serif (OFL), embedded via @font-face
│   ├── img/                   # SD watermark
│   ├── hd60/                  # final footage: stabilised, slowed, 60 fps                    [Git LFS]
│   ├── clips/  hd/            # raw copies / v1 1080p upscales                                [not in repo]
│   └── tmp/                   # stabiliser scratch (.trf, -stab.mp4)                          [not in repo]
├── .media/                    # media-use ledger: Openverse/bundled SFX + CREDITS.md
├── tools/
│   ├── prep-footage.sh        # raw Drive clips → assets/hd60 (stabilise, slow, 60 fps, grade)
│   ├── mux-and-master.sh      # new audio onto an existing picture + -14 LUFS master
│   └── premix.py              # quick audio-only mix to audition a music bed
├── docs/
│   ├── ASSETS.md              # every asset: source, licence, processing, used/archived
│   └── PRODUCTION.md          # render pipeline, audio workflow, version history, gotchas
├── deliverables/              # final mastered film (v9)                                      [Git LFS]
├── previews/                  # 720p review cuts (music options, sound preview)               [not in repo]
├── renders/                   # every 4K / 1080p render and audio draft                       [not in repo]
├── BRIEF.md · BREAKDOWN.md    # brief + creative/sound breakdown
└── hyperframes.json · package.json · meta.json
```

The final film and the 60 fps footage are stored with **Git LFS**. Raw clips, old renders and
previews stay out of the repo. [`docs/ASSETS.md`](docs/ASSETS.md) explains where each file comes
from and how to rebuild it.

## Quick start

Requirements: Git LFS, Node.js 18+, ffmpeg (with `libvidstab`) and Python 3 on `PATH`.

```bash
git lfs install && git lfs pull          # fetch the 60 fps footage + final film
npm install                              # @hyperframes/core (needed by the audio carve script)
# tools/prep-footage.sh                  # only to rebuild assets/hd60 from the raw Drive clips
npx hyperframes preview --background     # Studio preview at http://localhost:3002
npx hyperframes check --timeout 20000    # lint + layout + contrast (must pass before rendering)
```

### Render the final (4K, 60 fps)

The machine this was built on has ~7 GB RAM. A plain 4K render ran out of memory and crashed at
46%, so always render in segmented, low-memory, resumable mode:

```bash
HF_SEGMENTED_CAPTURE=true npx hyperframes render -q delivery --fps 60 --resolution portrait-4k \
  --low-memory-mode --resume --player-ready-timeout 180000 --browser-timeout 300 \
  --protocol-timeout 600000 -o renders/beaklet-4k60-raw.mp4
tools/mux-and-master.sh renders/beaklet-4k60-raw.mp4 renders/beaklet-4k60-raw.mp4 deliverables/Beaklet_final.mp4
```

That takes about 40–48 minutes. If only the **audio** changed, skip it: see
[Audio-only revisions](docs/PRODUCTION.md#audio-only-revisions), which takes about 9 minutes.

## Version history (summary)

| Version | Change |
|---|---|
| v1 | First cut, 1080p30, "Rise" music, typewriter hook |
| v2 | New hook (ink drop, kinetic slam, sunburst, iris). Shaky clips stabilised + slowed + 60 fps. 16:9 shots in a showcase card. 4K 60 |
| v3 | Music → "Prologue" (picked from 5 previews). Premium SFX replace the bundled swishes |
| v5–v6 | Fewer, softer SFX (water drops + booms). Official logo on the end card. **Fixed the music carve** (duplicate `data-automation` attribute) |
| v7 | A distinct, story-matched sound for every moment from 5 to 40 s |
| v8 | 5 s water swirl → deep whoosh into the iris. Disc spin synced to the footage |
| **v9 (final)** | The "coin" rattle from the v4 preview on the disc shot (27–29 s), stopping on the settle |

Full details are in [`docs/PRODUCTION.md`](docs/PRODUCTION.md#version-history).

## Credits

- Music: "Prologue" by **Hyperreal**, CC BY 3.0 — https://www.jamendo.com/track/1076983
- "Deep Cinematic Impact" by **MeijstroAudio**, CC BY 4.0 — freesound.org/s/377303
- "Risers – Horror Whooshes Tension Builder 1" by **original_sound**, CC BY 3.0 — freesound.org/s/494981
- "BirdFlap1.wav" by **AgentDD**, CC BY 3.0 — freesound.org/s/246225
- All other sound effects: CC0 (Freesound via Openverse) or the HyperFrames bundled library
- Voice: Fish Audio "Adrian". Font: Instrument Serif (SIL OFL). Logo artwork: Beaklet brand book
- Footage: supplied by Beaklet for the assignment

Post the four CC BY credit lines with the video (in the caption or description).
