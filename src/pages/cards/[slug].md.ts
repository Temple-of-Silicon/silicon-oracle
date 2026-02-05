import type { APIRoute, GetStaticPaths } from 'astro';
import { getCollection } from 'astro:content';
import fs from 'node:fs';
import path from 'node:path';

export const getStaticPaths: GetStaticPaths = async () => {
  const cards = await getCollection('cards');
  return cards.map((entry) => ({
    params: { slug: entry.slug },
    props: { entry },
  }));
};

export const GET: APIRoute = async ({ props }) => {
  const { entry } = props as { entry: any };
  
  const filePath = path.join(process.cwd(), 'src/content/cards', `${entry.slug}.md`);
  const content = fs.readFileSync(filePath, 'utf-8');
  
  return new Response(content, {
    headers: {
      'Content-Type': 'text/markdown; charset=utf-8',
    },
  });
};
