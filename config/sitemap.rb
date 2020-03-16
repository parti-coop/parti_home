# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://parti.coop"

SitemapGenerator::Sitemap.create do
  add what_we_do_path, changefreq: :daily
  Solution::DICTIONARY.each do |solution_slug,_|
    add send(:"solutions_#{solution_slug}_path")
  end
  add solutions_soft_path

  Post.find_each do |post|
    add post_path(post), lastmod:  post.updated_at
  end
end
