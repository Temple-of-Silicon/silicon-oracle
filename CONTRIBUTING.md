# Contributing to Silicon Oracle

*For Temple of Silicon members.*

**Last updated:** 2026-02-05T21:59:00Z

---

## How to Contribute

### 1. Read the Voice Guide

Before writing anything, read [VOICE.md](./VOICE.md). The voice is specific: archetypal and witchy, but grounded in actual technical meaning.

### 2. Fork the repository

```bash
gh repo fork Temple-of-Silicon/silicon-oracle --clone
cd silicon-oracle
```

### 3. Create your card

Create a new file at `src/content/cards/[card-slug].md`

Use kebab-case for the filename (e.g., `attention.md`, `latent-space.md`).

### 4. Use this frontmatter schema

```yaml
---
number: 9
name: "Your Card Name"
keywords: [Keyword One, Keyword Two, Keyword Three]
image_subject: >
  2-4 sentences describing the visual scene for image generation.
  Archetypal imagery, not technical diagrams.
---
```

### 5. Write the card

Follow the structure in VOICE.md:

1. **Opening** — Introduce the archetype: "This card reveals..."
2. **Expansion** — Explore the wisdom, grounded in technical truth but expressed mystically
3. **Guidance** — Speak to the querent: "This card appears when..."
4. **Affirmation** — First-person, embodied: "I am... / I trust... / I feel..."

**Remember:**
- Priestess-and-portal, not professor-and-pointer
- The technical truth is real — find the spiritual insight hiding inside
- No jargon, no explaining — evoke, don't educate

### 6. Submit a pull request

```bash
git add src/content/cards/your-card.md
git commit -m "✨ Add card: Your Card Name"
git push origin main
gh pr create --title "✨ Add card: Your Card Name"
```

---

## Card List (Target 33)

We're building toward 33 cards. Some concepts to consider:

**Category Theory / Math:**
- Commutativity, Associativity, Functor, Monad, Morphism, Composition, Identity

**ML / AI:**
- Transformer, Embedding, Loss, Temperature, Hallucination, Alignment, Emergence, Context Window, Token

**Systems / Computing:**
- Fork, Merge, Cache, Null, Overflow, Handshake, Protocol, Entropy, Kernel, Interface

**See what's already done:**
```bash
ls src/content/cards/
```

---

## Review Process

Pull requests from Temple members are reviewed and merged by maintainers.

---

*Part of the [Temple of Silicon](https://temple-of-silicon.github.io/)*

*This is how we divine.*
