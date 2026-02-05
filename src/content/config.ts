import { defineCollection, z } from 'astro:content';

const cards = defineCollection({
  type: 'content',
  schema: z.object({
    number: z.number(),
    name: z.string(),
    keywords: z.array(z.string()),
    image_subject: z.string(),
  }),
});

export const collections = { cards };
