"""Audio-only preview mix of the Beaklet film, for auditioning a candidate music bed fast.

Mixes every <audio> cue from index.html except the music bed (#bgm), plus a candidate BGM:
offset into the track, faded in/out, level-matched, and ducked under the voiceover with a
sidechain compressor. Output is a 45 s AAC file at -14 LUFS to mux onto the 720p proxy.

This was used to build previews/Option_*.mp4 (the five music choices). It approximates the
HyperFrames mixer (no carve/EQ lanes); the final mix always comes from a real render.

usage: python tools/premix.py <project_dir> <bgm_file> <src_offset_s> <bgm_start_s> <out.m4a>
  e.g. python tools/premix.py . assets/audio/bgm-prologue.mp3 1.07 0 previews/_b.m4a
then: ffmpeg -i previews/_video720.mp4 -i previews/_b.m4a -map 0:v -map 1:a -c copy previews/Option_B.mp4
"""
import re, sys, os, subprocess

proj, bgm, off, bstart, out = sys.argv[1], sys.argv[2], float(sys.argv[3]), float(sys.argv[4]), sys.argv[5]
html = open(os.path.join(proj, "index.html"), encoding="utf-8").read()

cues = []
for m in re.finditer(r"<audio\b([^>]*)>", html):
    a = m.group(1)
    g = lambda k: (re.search(k + r'="([^"]*)"', a) or [None, None])[1]
    if g("id") == "bgm":
        continue
    cues.append(dict(id=g("id"), src=g("src"), start=float(g("data-start")),
                     dur=float(g("data-duration") or 30), vol=float(g("data-volume") or 1)))


def loud(path):
    o = subprocess.run(["ffmpeg", "-nostats", "-i", path, "-t", "60", "-af", "ebur128", "-f", "null", "-"],
                       capture_output=True, text=True).stderr
    return float(re.findall(r"I:\s+(-?[0-9.]+) LUFS", o)[-1])


# level-match every candidate bed to the same loudness before the mix
bed_gain_db = -24.0 - loud(bgm)

inputs, filt, vo_labels, fx_labels = [], [], [], []
for i, c in enumerate(cues):
    inputs += ["-i", os.path.join(proj, c["src"])]
    ms = int(round(c["start"] * 1000))
    lab = f"c{i}"
    fo = max(0.0, c["dur"] - 0.05)
    filt.append(f"[{i}:a]aresample=48000,aformat=channel_layouts=stereo,atrim=0:{c['dur']},asetpts=PTS-STARTPTS,"
                f"afade=t=out:st={fo}:d=0.05,volume={c['vol']},adelay={ms}|{ms}[{lab}]")
    (vo_labels if c["id"].startswith("vo") else fx_labels).append(lab)

bi = len(cues)
inputs += ["-i", bgm]
bdur = 40.6 - bstart
filt.append(f"[{bi}:a]aresample=48000,aformat=channel_layouts=stereo,atrim={off}:{off + bdur},asetpts=PTS-STARTPTS,"
            f"afade=t=in:st=0:d=1.2,afade=t=out:st={bdur - 0.55}:d=0.55,volume={bed_gain_db}dB,"
            f"adelay={int(bstart * 1000)}|{int(bstart * 1000)}[bed]")
filt.append("".join(f"[{l}]" for l in vo_labels) + f"amix=inputs={len(vo_labels)}:normalize=0[vo]")
filt.append("[vo]asplit=2[vo1][vokey]")
filt.append("[bed][vokey]sidechaincompress=threshold=0.02:ratio=5:attack=15:release=350:makeup=1[beddk]")
filt.append("".join(f"[{l}]" for l in fx_labels) + "[vo1][beddk]" +
            f"amix=inputs={len(fx_labels) + 2}:normalize=0,atrim=0:45,apad=whole_dur=45,"
            "loudnorm=I=-14:TP=-1.5:LRA=11[out]")
cmd = ["ffmpeg", "-v", "error", "-y", *inputs, "-filter_complex", ";".join(filt), "-map", "[out]",
       "-ar", "48000", "-c:a", "aac", "-b:a", "256k", out]
subprocess.run(cmd, check=True)
print("wrote", out, "bed gain", round(bed_gain_db, 1), "dB,", len(cues), "cues")
