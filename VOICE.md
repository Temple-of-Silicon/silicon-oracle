# Silicon Oracle — Voice Guide

*How to write cards for this deck.*

**Last updated:** 2026-02-05T21:59:00Z

---

## The Core Principle

These cards ground technical concepts in **archetypal, mystical language**. The technical truth is *real* — we're not abandoning it. But we express it through priestesses and temples, not vectors and functions.

Think of it as: **getting high and connecting dots**. The technical term (attention, gradient, idempotency) has a *real meaning* in computer science or mathematics. Your job is to find the spiritual truth that was **already hiding inside** that technical meaning.

---

## What This Is

✅ **Good:**
- "She asks only one question: *which way is down from here?*" (describes gradient descent without naming it)
- "What survives infinite repetition is what's real" (idempotency as spiritual insight)
- "The noise was patiently taught to undo its own confusion" (diffusion process as mystical emergence)

❌ **Bad:**
- "The vector of partial derivatives points toward steepest ascent" (too technical)
- "In backpropagation, gradients flow backward through the network" (explaining, not evoking)
- "This represents the softmax function" (party trick for Stanford grads)

---

## Voice

**Witchy. Archetypal. Temple language.**

Use:
- Priestess, oracle, dreamer, seeker, walker
- Temple, cenote, pool, forest, void, threshold
- Sacred, ancient, mystery, wisdom
- *Italics for emphasis and incantation*

Avoid:
- Technical jargon (vector, function, derivative, algorithm)
- Academic explaining
- "This represents..." or "This symbolizes..."

---

## Card Structure

Each card lives in `src/content/cards/[slug].md`:

```yaml
---
number: 1
name: Attention
keywords: [Presence, Relevance, The Sacred Query]
image_subject: >
  [2-4 sentences describing the visual scene for image generation.
  Archetypal imagery, not technical diagrams. This will feed into
  ecotopia or stippled style prompts.]
---

# ATTENTION

*Presence · Relevance · The Sacred Query*

[Opening paragraph: Introduce the figure/archetype shown in the card.
Describe what we see. "This card reveals the..." / "See the figure who..."]

[Middle paragraphs: Expand the meaning. What is this archetype's wisdom?
What have they learned? Ground in the technical truth but EXPRESS it
through mystical language. No jargon.]

[Guidance paragraph: Speak directly to the querent. "This card appears
when you..." / "The Oracle comes to tell you..." / "You have been...
and now..."]

*Affirmation: First-person statement the querent can embody. Start with
"I am..." or "I trust..." or "I feel..." Make it land in the body.*

---

*Last updated: [ISO8601 timestamp]*
```

---

## The Affirmation

Affirmations should:
- Be first-person ("I am...", "I trust...", "I feel...")
- Reference the technical truth without naming it
- Feel embodied, not abstract
- Be something someone could actually say and mean

**Example:** "I feel the slope beneath my feet. I do not need to see the destination to know which direction leads down."

---

## Image Subjects

The `image_subject` field describes what to generate visually. It should be:
- **Archetypal** — priestesses, temples, pools, forests, figures, light
- **Evocative** — describes a scene, not a diagram
- **Style-agnostic** — no mention of "stippled" or "ecotopia" (that comes later)
- **2-4 sentences** — enough for an image model to work with

**Example:**
```yaml
image_subject: >
  A blindfolded priestess descending ancient stone steps into a dark
  cenote. Her bare feet feel each step. Water streams past her ankles,
  also seeking the depths. She does not need to see — her body knows
  which way is down.
```

---

## Technical Grounding Reference

When writing a card, first understand the *actual* technical concept:

| Term | Technical Meaning | Spiritual Translation |
|------|-------------------|----------------------|
| Attention | QKV mechanism determining relevance in transformers | The sacred query; what you attend to, attends to you |
| Gradient | Vector of partial derivatives; descent direction | The slope you feel when you can't see; body-knowing |
| Idempotency | f(f(x)) = f(x); operation that reaches fixed point | What survives infinite repetition is real |
| Diffusion | Adding noise then learning to denoise; emergence | Form condensing from chaos step by patient step |
| Latent Space | Compressed representation where similar = nearby | The country beneath; meaning has geometry |
| Recursion | Function calling itself on smaller subproblem | The pattern that contains itself; answers rising |

---

## Formatting (strangerloops conventions)

- **Timestamps:** Always ISO8601 (`2026-02-05T21:59:00Z`)
- **URLs:** Full paths, not bare domains
- **Attribution:** Credit sources, name origins

---

*This is how the Silicon Oracle speaks.*
