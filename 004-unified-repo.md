# Unified Archivematica repository

* Status: proposed

## Context and problem statement

Spreading the Archivematica source code, Archivematica Storage Service source
code, tests and sample data across multiple repositories has a number of
downsides. For a developer to get Archivematica up and running, it requires
the use of a "glue" project, am (also, the usage of git submodule in am
adds complexity). Discoverability of different repositories can be a problem
for new users unfamiliar with the project.

## Unified repo pros

Moving the storage service, sample data, acceptance tests and compose files
to a single repo would allow a single `git clone` command to be all that is
required, simplifying dependencies - everything required by Archivematica is
in one place. It would also allow atomic commits across projects (e.g. update
acceptance tests at the same time as updating Archivematica), something that
is not currently possible.

## Split repo pros

Split repos allow more decoupling between components. However, (with the
exception of sample data) all repos mentioned in this ADR are actually
dependent on each other, e.g. it's not possible to use Archivematica without
also running the storage service.

## Considered options

* Moving to a single Archivematica repo, the case argued for in this
  proposal.
* Leaving the repositories as is.
* Some halfway change, e.g. moving acceptance tests into Archivematica but not
  sample data.

## Decision outcome

None yet.

## Links

* Archivematica projects: [am][0], [archivematica][1],
[archivematica-storage-service][2], [archivematica-sampledata][3],
[archivematica-acceptance-tests][4]

[0]: https://github.com/artefactual-labs/am
[1]: https://github.com/artefactual/archivematica
[2]: https://github.com/artefactual/archivematica-storage-service
[3]: https://github.com/artefactual/archivematica-sampledata
[4]: https://github.com/artefactual-labs/archivematica-acceptance-tests