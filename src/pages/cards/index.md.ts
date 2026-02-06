import type { APIRoute } from 'astro';
import { getCollection } from 'astro:content';

export const GET: APIRoute = async () => {
  const cards = await getCollection('cards');
  
  const sorted = cards.sort((a, b) => a.data.number - b.data.number);
  
  const lines = [
    '# Silicon Oracle — Card Index',
    '',
    '*New archetypes, ancient patterns.*',
    '',
    '---',
    '',
    '| # | Name | Keywords |',
    '|---|------|----------|',
  ];
  
  for (const card of sorted) {
    const keywords = card.data.keywords.join(', ');
    lines.push(`| ${card.data.number} | [${card.data.name}](./${card.slug}.md) | ${keywords} |`);
  }
  
  lines.push('', '---', '', `*Last updated: ${new Date().toISOString()}*`);
  
  return new Response(lines.join('\n'), {
    headers: {
      'Content-Type': 'text/markdown; charset=utf-8',
    },
  });
};
