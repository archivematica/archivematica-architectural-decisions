# Archivematica Architectural Decision Records

Welcome to the Architectural Decision Record repository for the Archivematica project.

This repo captures decisions, and decisions in progress, for how Archivematica
code is written and major changes to the architecture or functionality of the
project.

If you’re looking for a place to file a bug, enhancement, or non-architectural
feature, please visit the [Issues](https://github.com/archivematica/Issues)
repo.

Information on creating new ADRs can be found in the [CONTRIBUTING] document.

A list of currently accepted records can be found in the [Accepted log].

## Working on the site locally

This repository is also a [Jekyll] site, published by GitHub Pages at
<https://adr.archivematica.org/>. GitHub builds the published site with its own
set of gems (see the [GitHub Pages dependency versions]); the `Gemfile` here
pins the same versions so that local previews render the same way.

The only tools needed locally are [Docker], [uv] and `make`. Everything Ruby
related runs inside a disposable container, as your user, with gems cached in
`vendor/bundle/`:

- `make check` runs the pre-commit hooks (markdownlint) through uv.
- `make build` builds the site into `_site/`; the CI workflow runs the same
  target.
- `make serve` serves the site at <http://127.0.0.1:4000/> and rebuilds it as
  files change.
- `make update` refreshes `Gemfile.lock`; gems pinned in the `Gemfile` only
  move when the pins are edited.
- `make audit` checks `Gemfile.lock` for gems with known vulnerabilities.

The first run downloads the Ruby image and compiles a few gems, so it takes a
couple of minutes; later runs take seconds. `RUBY_VERSION` selects the Ruby
line, which defaults to the one GitHub Pages runs:

```shell
make build RUBY_VERSION=3.4
```

[CONTRIBUTING]: CONTRIBUTING.md
[Accepted log]: accepted-log.md
[Jekyll]: https://jekyllrb.com/
[GitHub Pages dependency versions]: https://pages.github.com/versions.json
[Docker]: https://docs.docker.com/get-started/get-docker/
[uv]: https://docs.astral.sh/uv/
