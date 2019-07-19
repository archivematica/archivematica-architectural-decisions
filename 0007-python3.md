# Refactor to Python 3

* Status: proposed
* Deciders: Justin Simpson, Sarah Romkey, Darren Craze, Joel Simpson, David
 Juhasz, Jesús García Crespo, Pieter Van Garderen, Sara Allain, Ashley Blewer,
 Santiago Rodríguez Collazo, Miguel Angel Medinilla Luque, José Raddaoui Marín,
* Date: 2019-07-19

## Context and problem statement

Python 2 will not be supported past January 1, 2020. Archivematica is not fully
compatible with Python 3 yet. To avoid security and compatibility issues after
this date, Archivematica and all of its required components will need to run in
a Python 3 environment.

Components:

* am/compose
* archivematica-storage-service
* MCPServer
* MCPClient
* Dashboard
* archivematica-common
* mets-reader-writer
* ammcpc
* agentarchives
* fixity
* automation-tools
* archivematica-acceptance-tests
* amclient

## Decision drivers <!-- optional -->

* Archivematica is built on Python 2
* Python 2 will no longer be supported after January 1, 2020

## Considered options

1. Refactor to Python 3

## Decision outcome

Chosen option: 1, because refactoring Archivematica and all required components
to Python 3 is the only option to ensure that Archivematica continues to be a
safe, stable environment.

Epic for Python 3 refactoring: archivematica/Issues#508

### Positive consequences

* Archivematica will be upgraded to a stable version of Python
* Archivematica developers will be able to take advantage of new features in
 Python
* The most recent version of Python 3 at time of writing is Python 3.9, which
 will be maintained until June 2025; further versions of Python 3 are expected which
 will extend this end of life date, which means that the Archivematica codebase
 is guaranteed to have at least 5 years of Python support

### Negative consequences

* This is a very large task and components need to be tackled in priority order,
 so it will take a considerable amount of time to get everything refactored
* Releasing the Python 3 work once all components are refactored will take the
 place of a feature release

## Links <!-- optional -->

* [PEP 373 -- Python 2.7 Release Schedule](https://www.python.org/dev/peps/pep-0373/)
* [PEP 596 -- Python 3.9 Release Schedule](https://www.python.org/dev/peps/pep-0596/)
