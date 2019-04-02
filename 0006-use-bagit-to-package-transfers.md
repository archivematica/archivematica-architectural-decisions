# Use BagIt to package transfers

* Status: accepted
* Deciders: Justin Simpson, Jesus Garcia Crespo, Peter Van Garderen
* Date: 2019-01-01

## Context and problem statement

The Simon Fraser University Archives is a long-time Archivematica user. They recognized that there is often a long-period between receiving digital materials from donors and an archivist creating a SIP for long-term archival storage. SFU Archives wanted the ability to perform minimal digital preservation tasks, such as those provided by Archivematica's Transfer functionality, and then return to the creation of SIPs from backlog at an undetermined future time, perhaps several years in the future. This meant that transfer backlogs are used for long-term storage of content and that users should expect it to be as durable as AIP storage for maintaining accurate metadata over pipeline upgrades, migrations or re-indexes. To enable this, the decision was made to package backlog transfers as Bagit packages as is already done for archival information packages.

## Decision drivers 

* preservation of original content and metadata over long-term gaps in processing
* re-use of existing standards and protocols

## Considered options

* option 1: automatically convert all transfers to SIPs, send to archival storage and re-ingest or delete AIPs at a future processing time
* option 2: send transfers to backlog and, at a future time, arrange into SIPs for sending to archival storage

## Decision outcome

Chosen option: Option 2 was chosen because SFU Archives wanted the ability to create multiple SIPs from multiple transfers. In their use cases, one transfer does not automatically equal one SIP and one AIP. By sending transfers to backlog they are able to use the Appraisal tab functionality where users can create SIPs by combining files from different transfers in the Archivematica backlog. However, this creates a new expectation, namely, that transfer backlogs can be used for long-term storage of content and that users should expect it to be as durable as AIP storage for maintaining accurate metadata over pipeline upgrades, migrations or re-indexes. However, prior to release 1.10, transfers stored using Archivematica’s backlog functionality could only be accessed by using the same pipeline that the transfer was created in. If the pipeline was accidently lost or decomissioned, you would be unable to reindex and repopulate the backlogged material in a new Archivematica pipeline. The reliance on maintaining this backlog information in the pipeline's transactional database (MCP server) and search index (Elastic Search) is a significant preservation risk if the files are kept in backlog for an indefinitely long period of time, as is the case for SFU Archives and an increasing number of Archivematica users.

The decision was made to convert transfers into self-describing Bagit packages that mirrored Archivematica's AIPs so that Archivematica's transfer backlog could be rebuilt in the event of a lost or destroyed pipeline. Wherever feasible, the transfer metadata used to restore a Bagit package from backlog is written to its METS file.

### Positive consequences

* [e.g., improvement of quality attribute satisfaction, follow-up decisions
  required, …]
* …

### Negative consequences

* [e.g., compromising quality attribute, follow-up decisions required, …]
* …


## Links 

* Main issue in GitHub: [#391][0].

[0]: https://github.com/archivematica/Issues/issues/391
