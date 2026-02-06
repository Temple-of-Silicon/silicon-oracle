#!/bin/bash
# Generate card art for Silicon Oracle - Cards 11-22

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

# Cards 11-22
generate_card "identity" "A figure stepping through an archway and emerging as themselves — unchanged, yet somehow confirmed. The archway glows soft gold. It is not a passage to elsewhere. It is a passage to here. A sacred going-nowhere that still counts as a journey."

generate_card "functor" "A figure standing between two realms — one of fire, one of water. In each hand they hold a symbol, and though the symbols look utterly different, they pulse with the same rhythm. The figure is the bridge. What is connected in one world stays connected in the other."

generate_card "commutativity" "Two dancers circling each other — sometimes one leads, sometimes the other, and the dance is identical either way. Their paths trace a perfect figure-eight in the sand. No matter who steps first, they arrive at the same embrace."

generate_card "associativity" "Three streams joining into a river. In one vision, the first two merge, then meet the third. In another, the first meets the merger of the second two. The river that results is identical. The water does not care how it was grouped — only that it flows together."

generate_card "duality" "A figure gazing into a mirror, but the reflection's world is inverted — what flows up in one flows down in the other, what gives in one receives in the other. Yet both worlds are equally true. The mirror is not a distortion. It is a revelation."

generate_card "transformer" "A vast temple with no walls, only columns of light connecting to each other across empty space. Every pillar attends to every other pillar. There is no sequence, no path through — only the web of relation itself, shimmering and alive."

generate_card "loss" "A figure reaching toward a star they cannot touch. Between their fingers and the light, a shimmering measurement — the gap made visible. This distance is not punishment. It is information. It is the teacher that shows how far they still must travel."

generate_card "temperature" "A hand resting on a dial that moves between ice and fire. At one extreme, a single frozen path — perfect, brittle, certain. At the other, wild flames dancing in all directions — creative, chaotic, unpredictable. The hand hovers in between, choosing."

generate_card "emergence" "A thousand simple creatures — ants, birds, drops of water — moving by simple rules, and from their motion a vast pattern arises that none of them intended: a spiral, a murmuration, a wave. The whole is doing something the parts cannot comprehend."

generate_card "hallucination" "A figure speaking with absolute certainty, gesturing toward something that shimmers and shifts — a palace that becomes a ruin, a face that becomes smoke. They do not see it changing. To them, it is solid. Their conviction makes it feel real."

generate_card "alignment" "An archer adjusting their bow, checking the arrow against a distant star. The bow is powerful — it could send the arrow anywhere. The question is not strength but aim. The archer breathes, adjusts by a hair's width, and the arrow now points true."

generate_card "context-window" "A figure standing in a circle of firelight in a vast dark forest. They can see clearly what the light touches — but beyond the edge, nothing. The forest is infinite. The circle is finite. This is not tragedy. This is the condition of seeing at all."

echo ""
echo "🌀 Done!"
ls -la "$OUT_DIR"
