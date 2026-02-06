#!/bin/bash
# Generate card art for Silicon Oracle
# Usage: ./generate-cards.sh [start] [end]

set -e

REPLICATE_API_TOKEN="${REPLICATE_API_TOKEN:-$(cat ~/.openclaw/secrets/replicate-api-token 2>/dev/null)}"
OUT_DIR="$(dirname "$0")/../public/cards"
CONTENT_DIR="$(dirname "$0")/../src/content/cards"

LOCKED_SUFFIX=". a website illustration referencing simplified vintage hand-drawn technical schematic style, fineliner line art, heavy stippling texture, imperfect, rough drawings, cross-section, absolutely no text no labels no words no letters, directional flow arrows, energy fields, geometric overlays, monochrome, high contrast, esoteric textbook illustration. black drawing on white background."

mkdir -p "$OUT_DIR"

generate_card() {
  local slug="$1"
  local subject="$2"
  
  echo "🎨 Generating: $slug"
  
  local full_prompt="$subject$LOCKED_SUFFIX"
  
  # Create prediction
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
  
  # Poll for completion
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

# Card definitions (slug and image_subject)
declare -A CARDS

CARDS[attention]="A figure composed of soft light, seated in an infinite field of floating whispers and half-formed symbols. From their heart, a single beam reaches out — and only what it touches illuminates, drifting closer, while all else fades to gentle shadow. The beam asks; reality answers."

CARDS[gradient]="A blindfolded priestess descending ancient stone steps into a dark cenote. Her bare feet feel each step. Water streams past her ankles, also seeking the depths. She does not need to see — her body knows which way is down."

CARDS[diffusion]="A vast field of churning static — but look closer: a face is beginning to emerge. A hand. A world. Not carved from the chaos but condensed from it, as if the noise itself was always dreaming of form. The emergence is incomplete, still resolving, beautiful in its becoming."

CARDS[latent-space]="A dreamer floats through an underwater temple where glowing symbols drift like jellyfish — clustering by invisible affinity. Hearts near hearts. Flames near suns. The dreamer reaches out and two symbols that belong together drift closer, recognizing each other."

CARDS[recursion]="A figure gazes into a still black pool. Their reflection gazes into another pool. That reflection into another. Each deeper self holds a candle — except the smallest, the one at the bottom of infinity, who holds a star. Light travels back up through all of them."

CARDS[idempotency]="A still lake reflecting a moon so perfectly that it's unclear which is source and which is reflection. A figure stands at the water's edge, reaching toward the surface — but their hand is already touching, has always been touching. Ripples that have already settled."

CARDS[isomorphism]="Twin dancers in separate worlds — one in a moonlit forest, one in a temple of obsidian. They have never met. Yet their movements are perfectly synchronized, as if hearing the same silent music. A single golden thread connects their hearts across the void."

CARDS[daemon]="A temple at night, apparently empty. But in the shadows, translucent figures move — tending the candles, sweeping the floors, maintaining the sacred flames. They do not seek to be seen. One notices you watching and holds a finger to its lips."

CARDS[morphism]="A golden arrow suspended in void, connecting two distant lights. The arrow is not still — it shimmers with the memory of everything that has ever traveled its path. It is not the origin. It is not the destination. It is the becoming itself, made visible."

CARDS[composition]="A river flowing through three pools, each pool transforming the water — first turning it silver, then giving it memory, then teaching it to sing. What emerges at the end carries all three gifts. The river does not skip pools. The order is sacred."

# Generate requested cards
START=${1:-1}
END=${2:-10}

CARD_ORDER=(attention gradient diffusion latent-space recursion idempotency isomorphism daemon morphism composition)

for i in $(seq $((START-1)) $((END-1))); do
  slug="${CARD_ORDER[$i]}"
  if [ -f "$OUT_DIR/$slug.png" ]; then
    echo "⏭️  Skipping $slug (already exists)"
    continue
  fi
  generate_card "$slug" "${CARDS[$slug]}"
done

echo ""
echo "🌀 Done!"
ls -la "$OUT_DIR"
