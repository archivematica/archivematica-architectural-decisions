source "https://rubygems.org"

# GitHub Pages builds the published site with its own gem set (see
# https://pages.github.com/versions.json); this Gemfile pins the gems that
# shape the rendered pages to the versions GitHub Pages runs, except
# jekyll-seo-tag, which is pinned to a newer release.
gem "jekyll", "3.10.0"
gem "jekyll-seo-tag", "2.9.1"
gem "jekyll-theme-primer", "0.6.0"
gem "kramdown", "2.4.0"
gem "kramdown-parser-gfm", "1.1.0"

# Required by safe_yaml and liquid, which do not declare them; bundled gems
# since Ruby 3.4, so Bundler needs them listed.
gem "base64"
gem "bigdecimal"

# Plugins the site uses; GitHub Pages enables all of them by default.
group :jekyll_plugins do
  gem "jekyll-default-layout", "0.1.5"
  gem "jekyll-github-metadata", "2.16.1"
  gem "jekyll-optional-front-matter", "0.3.2"
  gem "jekyll-readme-index", "0.3.0"
  gem "jekyll-relative-links", "0.6.1"
  gem "jekyll-titles-from-headings", "0.5.3"
end
