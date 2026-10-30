#!/bin/bash
# Put a new audio mix on an existing picture render, then master to -14 LUFS (Instagram/Reels).
#
#   tools/mux-and-master.sh <picture.mp4> <audio-source.mp4> <final.mp4>
#
# Used for audio-only revisions: render a fast draft (`-q draft --fps 30`) whose mixer output
# is identical to a 4K render, then copy its audio onto the untouched 4K 60 fps picture.
# Two-pass loudnorm: I=-14 LUFS, true peak -1.2 dBTP, picture stream copied untouched.
set -euo pipefail
PIC=$1; AUD=$2; OUT=$3
TMP="${OUT%.mp4}.mux-tmp.mp4"

ffmpeg -v error -y -i "$PIC" -i "$AUD" -map 0:v -map 1:a -c copy "$TMP"

J=$(ffmpeg -nostats -i "$TMP" -af loudnorm=I=-14:TP=-1.2:LRA=11:print_format=json -f null - 2>&1 | sed -n '/{/,/}/p')
g() { echo "$J" | python -c "import sys,json;print(json.load(sys.stdin)['$1'])"; }

ffmpeg -v error -y -i "$TMP" -c:v copy \
  -af "loudnorm=I=-14:TP=-1.2:LRA=11:measured_I=$(g input_i):measured_TP=$(g input_tp):measured_LRA=$(g input_lra):measured_thresh=$(g input_thresh):offset=$(g target_offset):linear=true,aresample=48000" \
  -c:a aac -b:a 256k -movflags +faststart "$OUT"
rm -f "$TMP"

ffmpeg -nostats -i "$OUT" -vn -af ebur128 -f null - 2>&1 | grep -A3 Summary | grep "I:"
ffprobe -v error -show_entries format=duration:stream=width,height,r_frame_rate -of compact "$OUT"
