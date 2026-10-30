#!/bin/bash
# Rebuild assets/hd60/ (the 60 fps, stabilised footage the composition plays) from the raw Drive clips.
#
#   tools/prep-footage.sh            # all ten clips
#   tools/prep-footage.sh hero-h     # one clip by its project name
#
# Pipeline per clip (see docs/ASSETS.md for the why):
#   1. copy the raw UUID-named clip from the Drive folder to assets/clips/<name>.mp4
#   2. handheld clips: vid.stab 2-pass (shakiness 7, smoothing 40, 4% zoom to hide edges)
#   3. slow to the listed speed and motion-interpolate to 60 fps (minterpolate, mci/aobmc)
#   4. lanczos upscale + light sharpen + gentle contrast/saturation, H.264 CRF 14, 1 s GOP
# Static clips skip 2–3 and are only converted to 60 fps.
# Needs ffmpeg with libvidstab, and python on PATH.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"   # beaklet-film/
RAW="$(cd "$ROOT/.." && pwd)"              # the Drive download folder holding the UUID clips
A="$ROOT/assets"
mkdir -p "$A/clips" "$A/hd60" "$A/tmp"

# name | raw file | mode (stab|static) | speed | width x height
CLIPS="
writing|4f08b6a1-b6ab-41de-9946-6e233f14162f.mp4|stab|0.75|1080x1920
cap-rise-a|655d3997-d68e-4daa-a28f-8bf4de56422c.mp4|stab|0.6|1080x1920
cap-rise-b|8beedfc4-1724-4a90-8d67-13749e86109d.mp4|stab|0.6|1080x1920
duo-wide|d3114442-e183-42a9-9ddf-76351b2b886f.mp4|stab|0.7|1080x1920
cap-logo|d3fd4e77-70bb-4e1c-aa44-d80ca597d9dd.mp4|stab|0.6|1080x1920
duo-angle|ef09769e-adf2-415d-8878-46522a8200a1.mp4|stab|0.6|1080x1920
hero-h|d78e6718-8d81-4343-bd09-706ea42889da.mp4|stab|0.6|1440x810
lying-sweep-h|c7f66e13-9627-4e48-9d6a-33c51648c09d.mp4|static|1|1440x810
lying-dark-h|d1b57cdc-d655-4163-b017-b0af9b2ce200.mp4|static|1|1440x810
disc-flip-h|234ac68c-90a5-4d6a-bf31-cc68e94ffacd.mp4|static|1|1440x810
"

GRADE="unsharp=5:5:0.6:5:5:0.0,eq=contrast=1.05:saturation=1.06,format=yuv420p"
ENC="-c:v libx264 -crf 14 -preset medium -r 60 -g 60 -keyint_min 60"

prep() {
  local n=$1 raw=$2 mode=$3 sp=$4 size=$5 W H
  W=${size%x*}; H=${size#*x}
  [ -s "$A/clips/$n.mp4" ] || cp "$RAW/$raw" "$A/clips/$n.mp4"
  local in="$A/clips/$n.mp4" out="$A/hd60/$n.mp4"

  if [ "$mode" = "static" ]; then
    local trim=""
    # the disc flip only needs its tumble (raw 18–24 s); the composition seeks inside this cut
    [ "$n" = "disc-flip-h" ] && trim="-ss 18 -t 6"
    ffmpeg -v error -y $trim -i "$in" -an -vf "fps=60,scale=${W}:-2:flags=lanczos,$GRADE" $ENC "$out"
  else
    local trf="$A/tmp/$n.trf" mid="$A/tmp/$n-stab.mp4"
    [ -s "$trf" ] || (cd "$A/tmp" && ffmpeg -v error -y -i "$in" -vf "vidstabdetect=shakiness=7:accuracy=15:result=$n.trf" -f null -)
    (cd "$A/tmp" && ffmpeg -v error -y -i "$in" -an -vf "vidstabtransform=input=$n.trf:smoothing=40:zoom=4:optzoom=0:interpol=bicubic" -c:v libx264 -crf 12 -preset fast "$mid")
    local pts; pts=$(python -c "print(1/$sp)")
    ffmpeg -v error -y -i "$mid" -an \
      -vf "setpts=${pts}*PTS,minterpolate=fps=60:mi_mode=mci:mc_mode=aobmc:me_mode=bidir:vsbmc=1,scale=${W}:${H}:flags=lanczos,$GRADE" \
      $ENC "$out"
  fi
  echo "done  $n  $(ffprobe -v error -show_entries format=duration -of csv=p=0 "$out") s"
}

echo "$CLIPS" | while IFS='|' read -r n raw mode sp size; do
  [ -z "$n" ] && continue
  if [ $# -eq 0 ] || [ "$1" = "$n" ]; then prep "$n" "$raw" "$mode" "$sp" "$size"; fi
done
