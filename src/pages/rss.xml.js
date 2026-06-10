import rss from '@astrojs/rss';

export async function GET(context) {
  const articles = Object.entries(import.meta.glob('../content/articles/*.mdx', { eager: true }));
  
  const items = articles
    .sort(([, a], [, b]) => 
      new Date(b.frontmatter?.pubDate || b.frontmatter?.date || 0).getTime() - new Date(a.frontmatter?.pubDate || a.frontmatter?.date || 0).getTime()
    )
    .map(([path, article]) => {
      const { title, description, pubDate, date, metaDescription, category } = article.frontmatter;
      const slug = path.split('/').pop()?.replace('.mdx', '') || '';
      return {
        title,
        description: metaDescription || description,
        pubDate: new Date(pubDate || date),
        link: `/articles/${slug}/`,
        categories: category ? [category] : [],
      };
    });

  return rss({
    title: 'AutoPilot Sites — AI Tools Reviews & Comparisons',
    description: 'Independent reviews and comparisons of the best AI tools, software, and SaaS products.',
    site: context.site || 'https://autopilotsites.ai',
    items,
    trailingSlash: true,
  });
}
