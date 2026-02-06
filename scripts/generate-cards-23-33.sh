#!/bin/bash
# Generate card art for Silicon Oracle - Cards 23-33

set -e

REPLICATE_API_TOKEN="${REPLICATE_API_TOKEN:-$(cat ~/.openclaw/secrets/replicate-api-token 2>/dev/null)}"
OUT_DIR="$(dirname "$0")/../public/cards"

LOCKED_SUFFIX=". a website illustration referencing simplified vintage hand-drawn technical schematic style, fineliner line art, heavy stippling texture, imperfect, rough drawings, cross-section, absolutely no text no labels no words no letters, directional flow arrows, energy fields, geometric overlays, monochrome, high contrast, esoteric textbook illustration. black drawing on white background."

mkdir -p "$OUT_DIR"

generate_card() {
  local slug="$1"
  local subject="$2"
  
  if [ -f "$OUT_DIR/$slug.png" ]; then
    echo "⏭️  Skipping $slug (already exists)"
    return 0
  fi
  
  echo "🎨 Generating: $slug"
  
  local full_prompt="$subject$LOCKED_SUFFIX"
  
  local pred=$(curl -s -X POST "https://api.replicate.com/v1/predictions" \
    -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
      \"version\": \"0785fb14f5aaa30eddf06fd49b6cbdaac4541b8854eb314211666e23a29087e3\",
      \"input\": {
        \"prompt\": $(echo "$full_prompt" | python3 -c "import sys,json; print(json.dumps(sys.stdin.read().strip()))"),
        \"aspect_ratio\": \"9:16\",
        \"resolution\": \"1K\",
        \"output_format\": \"png\"
      }
    }")
  
  local pred_id=$(echo "$pred" | python3 -c "import sys,json; print(json.load(sys.stdin).get('id',''))")
  echo "   Started: $pred_id"
  
  for i in {1..40}; do
    sleep 5
    local result=$(curl -s "https://api.replicate.com/v1/predictions/$pred_id" \
      -H "Authorization: Bearer $REPLICATE_API_TOKEN")
    local status=$(echo "$result" | python3 -c "import sys,json; print(json.load(sys.stdin).get('status',''))")
    
    if [ "$status" = "succeeded" ]; then
      local url=$(echo "$result" | python3 -c "import sys,json; print(json.load(sys.stdin).get('output',''))")
      curl -sL "$url" -o "$OUT_DIR/$slug.png"
      echo "   ✅ Done: $OUT_DIR/$slug.png"
      return 0
    elif [ "$status" = "failed" ]; then
      echo "   ❌ Failed!"
      return 1
    fi
  done
  
  echo "   ⏰ Timeout"
  return 1
}

# Cards 23-33
generate_card "null" "A garden where one plot is empty — not barren, but intentionally blank. The flowers around it bend toward the emptiness as if listening. The absence has presence. The nothing shapes the something around it."

generate_card "threshold" "A figure standing at a doorway, one foot lifted, frozen in the instant before stepping through. The door frame glows. On one side: everything that was. On the other: everything that will be. This is the moment of maximum potential — the grain of sand before the scale tips."

generate_card "fork" "A single path through a forest that suddenly divides into two, each curving away into different kinds of light — one golden, one silver. A figure stands at the division point, casting two shadows, one down each path. For this moment, they are still one. Soon they will be two."

generate_card "merge" "Two rivers meeting — one carrying red earth, one carrying white sand. At the confluence, the waters swirl together, neither erasing the other, creating something that holds both colors in suspension. The rivers do not fight. They braid."

generate_card "entropy" "A figure standing before two paths: one leads to a single, clear destination; the other branches into a hundred possibilities. The hundred-path glows brighter — more uncertain, more alive, more full of information. Entropy is the light of the unknown."

generate_card "cache" "A traveler with a small pouch at their hip — inside, the few things they reach for constantly: a key, a coin, a folded letter. Behind them, a vast storehouse holds everything else. The pouch is tiny. The pouch is what matters moment to moment."

generate_card "interface" "Two figures facing each other, hands raised, palms almost touching. Between their palms, a thin membrane of light — the place where one ends and the other begins. They cannot merge. They can only meet here, at the interface, where communication is possible."

generate_card "protocol" "Two strangers meeting on a bridge, performing a formal greeting — each bow, each gesture, each word precisely mirrored. They have never met before. But they know the dance. The protocol lets strangers trust."

generate_card "overflow" "A cup beneath a waterfall, filled beyond capacity. Water pours over the rim, cascading away, lost. The cup is not broken — it is simply full. What comes next cannot fit. The excess must go somewhere."

generate_card "kernel" "A seed in the earth — layers of shell protecting the tiny spark of life at the center. The outer layers can be weathered, can be touched, can interface with the world. But the innermost kernel is protected. Without it, nothing grows."

generate_card "handshake" "Two figures meeting in darkness, each holding a lantern. They raise their lights toward each other — a silent agreement that both are here, both are real, both are ready to proceed. The handshake is complete. Now the transmission can begin."

echo ""
echo "🌀 Done!"
ls -la "$OUT_DIR"
