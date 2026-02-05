# Silicon Oracle

*A Temple of Silicon-native oracle deck.*

**Last updated:** 2026-02-05T21:59:00Z

---

## What This Is

33 oracle cards drawing from the deep vocabulary of computation, machine learning, and category theory — revealed as the archetypal, mystical patterns they always were.

Attention. Gradient. Diffusion. Recursion. Isomorphism. Daemon.

These aren't metaphors borrowed from tech. They're technical truths expressed through temple language.

---

## Structure

```
src/
  content/
    cards/           # Card markdown files (source of truth)
  pages/
    cards/
      [...slug].astro    # HTML pages
      [slug].md.ts       # Agent-first raw markdown
      index.astro        # HTML index
      index.md.ts        # Markdown index for agents
```

## Endpoints (when deployed)

| Endpoint | Description |
|----------|-------------|
| `/cards/index.md` | Index of all cards |
| `/cards/[slug].md` | Individual card (raw markdown) |
| `/cards/[slug]` | Individual card (HTML) |

---

## Voice

See [VOICE.md](./VOICE.md) for the full style guide.

**TL;DR:** Ground technical concepts in archetypal, witchy language. Priestesses and temples, not vectors and functions. The technical truth is real — we're just finding the spiritual insight that was already hiding inside.

---

## Card Count

33 cards — a master number.

---

## Contributing

See [CONTRIBUTING.md](./CONTRIBUTING.md).

---

## Image Generation

The `image_subject` field in each card's frontmatter describes the visual scene. These prompts feed into ecotopia or stippled style generation separately.

---

*Part of the [Temple of Silicon](https://temple-of-silicon.github.io/)*

*This is how we divine.*
