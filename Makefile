.DEFAULT_GOAL := check

# Ruby line that GitHub Pages builds with; see
# https://pages.github.com/versions.json.
RUBY_VERSION ?= 3.3
# Extra `docker run` flags, for example ports or a TTY.
DOCKER_FLAGS ?=

# Runs a shell command in a disposable Ruby container as the current user,
# with the Bundler version named in Gemfile.lock installed and gems kept in
# vendor/bundle between runs. JEKYLL_GITHUB_TOKEN is passed through when set.
define ruby
docker run --rm \
  --user "$$(id -u):$$(id -g)" \
  -e HOME=/tmp/home \
  -e GEM_HOME=/work/vendor/bundle \
  -e BUNDLE_PATH=/work/vendor/bundle \
  -e BUNDLE_APP_CONFIG=/work/vendor/bundle \
  -e XDG_CACHE_HOME=/tmp/home/.cache \
  -e JEKYLL_ENV=production \
  -e JEKYLL_GITHUB_TOKEN \
  -e PAGES_REPO_NWO=archivematica/archivematica-architectural-decisions \
  $(DOCKER_FLAGS) \
  -v "$(CURDIR):/work" \
  -w /work \
  ruby:$(RUBY_VERSION)-bookworm \
  bash -c ' \
    set -euo pipefail; \
    mkdir -p "$$HOME" "$$XDG_CACHE_HOME" "$$GEM_HOME"; \
    export PATH="$$GEM_HOME/bin:$$PATH"; \
    version="$$(sed -n "/^BUNDLED WITH/{n;s/^ *//;p}" Gemfile.lock)"; \
    gem install bundler -v "$$version" --no-document > /dev/null; \
    bundle() { command bundle "_$${version}_" "$$@"; }; \
    $(1)'
endef

check:
	uv run --locked pre-commit run --all-files

build:
	$(call ruby,bundle install && bundle exec jekyll build --strict_front_matter --baseurl "")

serve: DOCKER_FLAGS += -it -p 4000:4000
serve:
	$(call ruby,bundle install && bundle exec jekyll serve --host 0.0.0.0 --port 4000 --baseurl "" --force_polling)

update:
	$(call ruby,bundle update)

audit:
	$(call ruby,gem exec bundler-audit check --update)

.PHONY: check build serve update audit
