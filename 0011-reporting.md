# Introduce reporting functionality

* Status: Work in Progress
* Deciders: Jesús García Crespo, Sarah Romkey, Ross Spencer, Joel Simpson,
Peter Van Garderen
* Date: 2020-05-19

## Context and problem statement

Archivematica users want statistics about what their Archivematica deployments
are doing and when, as well as detailed breakdowns of the content in their
Archivematica systems. While the existing Archival Storage search and hit
display does provide some useful output, it does not aggregate this information
or present it in management-style reports. Nor does it provide this information
in a machine readable format that can later be consumed by other tools or
Archivematica itself.

Development on a comprehensive reporting feature has been blocked in the past
because it hasn't been clear where the canonical source of Archivematica
statistical and content information is stored or which of these sources is the
most persistent, convenient, durable, comprehensive, or performant input for
building reports. This raises the question whether reporting should be a
functionality supported natively by the Archivematica application or externally
by a third-party tool, be that bespoke and developed by Artefactual, or
off-the-shelf.

There is also some overlap of requirements between logging functionality,
reporting features, and the outputs provided by Archivematica's Format Policy
Registry (FPR) which makes the final vision for an Archivematica reporting
solution less clear.

The functional output of reporting should be to support preservation planning,
implementation of preservation plans, and repository maintenance. We recognize
that there are gaps in the data aggregated by Archivematica, e.g. technical
properties across the widest range of file-formats; or the data available to
systems like Archivematica, e.g. community driven statistics describing
file-format obsolescence.

Reporting is complicated further by the fact that production Archivematica
deployments are often split over multiple processing pipelines and/or storage
locations.

### Reporting requirements

The types of reporting information that users want from their Archivematica
systems can be roughly broken down into four categories:

* repository contents reporting,
* repository maintenance statistics,
* preservation planning reporting, and
* repository performance monitoring.

Examples of each are listed below.

#### Repository contents reporting

Examples:

1. An overview of all AIPs stored in Archivematica with their name, UUID,
storage location, creation date, amount in Mb/Gb/Tb, preferably grouped by
storage location. [UC001]
2. For each version of a file format, a report of how many files contain a
second manifestation (can be a presentation (access) copy, an anonymous
version or an original file or another conversion version of a file). [UC002]
3. A report of the file formats (and/or MIMETypes) in a given accession.
[UC003]
4. How many duplicate files are there in archival storage? [UC004]
5. How many [video, image, plain text etc.] files are in archival storage?
[UC005]
6. An overview of which files have had new access formats generated as a
result of a re-ingest and when (date/time). [UC006]
7. How many AIPs have corresponding DIPs? [UC007]
8. How many AIPs do not have corresponding DIPs? [UC008]
9. What is the descriptive metadata for file X, AIP Y in Archivematica? [UC009]
10. Show me supplementary descriptive metadata for files X kept outside of
Archivematica. [UC010]

#### Repository maintenance statistics

Examples

1. How many files are in archival storage? [UC011]
2. How many AIPs are in archival storage? [UC012]
3. How many files are in a specified AIP? [UC013]
4. A report of the data volume and total number of files per file format
ingested during one year. [UC014]
* "As a repository manager I want to be able to search across AIPs to locate how many of a certain file type I have. Ideally, I'd like to be able to narrow my search using date or other parameters." [reporting-2017]
5. A report of the total data volume for each version of a given file format,
including the number of files. [UC015]
6. A report listing all Backlog packages and AIPs that have been deleted.
[UC016]
7. What is the total volume of [video, image, plain text etc.] files in
archival storage? [UC017]
8. How many files with PRONOM puid X have been normalized? [UC018]
9. How many files with PRONOM puid X have not been normalized? [UC019]
10. How many [video, image, plain text etc.] files have been normalized?
[UC020]
11. How many [video, image, plain text etc.] files have not been normalized?
[UC021]
12. How many files were ingested between date X and date Y? [UC022]
13. How many files with PRONOM puid X are invalid/not well-formed? [UC023]
14. How many transfers or SIPs had processing failures in the last week, month,
or year. What were the errors they experienced? How many of these went
unresolved? [UC024]

#### Preservation planning reporting

Examples:

1. Show me an overview of which and how many files of a specific file format
(i.e. PRONOM PUID) are in all AIPs in archival storage; either a list for one
file format, or a list of all files, grouped per file format with info on the
AIP name/UUID, storage volume, and storage location. [UC025]
2. A report for each version of a given file format in storage, including the
number of files per version. [UC026]
3. A report summarizing specific technical properties in a file such as:
tables and images in a Word document and calculation formulas in an Excel file.
[UC027]
4. An overview of the file formats that are registered to be accepted in my
Archivematica repository, sorted in alphabetical order. [UC028]
5. An overview of what rules have been set for approved file formats for
preservation and for access, sorted per file format. [UC029]
6. An overview of the tools and their corresponding commands that are used to
perform digital preservation actions, by the file formats on which they are
used. [UC030]
7. Show me which file formats in my archival storage are considered a
preservation risk and list the options for migrating to better preservation
formats. [UC031]

#### Repository performance monitoring

Examples:

1. How long did it take to process AIP X versus AIP Y? [UC032]
2. How long on average does it take to complete Microservice X for file
format Y? [UC033]
3. How many AIPs/files can I reliably process at once? [UC034]
4. How long on average does it take to complete Microservice X when I change
environment component/configuration Y? [UC035]

## Decision drivers

### Project forces

1. The Archivematica system has reached a limit of what it can do in regards
to preservation planning given the current scope and format of repository
information that is available.
2. Various Archivematica users, user groups (e.g. Product Support Program),
system integrators (e.g. Enterprise Partner Program), and research projects
(e.g. JISC Research Data Spring) have discussed the need to implement
reporting functionality for Archivematica.

### Technical forces

#### Reporting formats

1. Graphical reporting outputs (e.g. pie charts, bar charts, histograms) are
visually appealing but are often not enough to convey detailed or
comprehensive information. For which reports should visualizations be used,
where should browser-based tables be used, where should document-style,
printable reports be used, and where should CSV exports be used? For which
reports is a combination of more than one type useful?

#### Source data for reporting

1. There are manifold sources of information within Archivematica from which
reports can be created, namely:
    * Storage Service API.
    * METS XML files in Archival Information Packages.
    * Elasticsearch index(es).
    * MySQL/SQLite databases (Dashboard, Storage Service, and FPR)
    * Backlog Bagit packages
    * System log files (e.g. MCPServer, Nginx, etc.)
    * Job/task outputs (e.g. stdout logs)
    * Prometheus system monitoring data, also referred to as instrumentation.
2. There are many different types of consumers of the sources of reporting-type
information, e.g. analysts, developers, systems-administrators, managers.
3. Information is surfaced to the end-user in a multitude of ways, e.g.
Dashboard, API, log files, data streams.
4. Information “inside” Archivematica has different properties, e.g. FPR
information is an institutional record surrounding preservation and access
decisions, Archival Storage search results show AIP file information, Job/Task
information is generated in aid of creating an AIP, unit variables are used to
direct workflows.
5. Some information wanted for reporting might need to be generated, e.g.
additional technical metadata not yet retrieved from digital objects.
6. Information inside Archivematica has different life-spans, e.g. an AIP is by
its nature persistent. An Archivematica Job/Task output is a transactional
record and is not anticipated to last as long.
7. As explained in [ADR-0010][adr0010] 'Archivematica original design
principles', the file-based AIP is the canonical source of information about
content preserved by Archivematica.
8. METS Reader/Writer provides a generic Python library for accessing
Archivematica AIP METS XML file contents.
9. The Archivematica Storage Service provides an Application Programming
Interface (API) for accessing information about packages in storage and for
requesting files in these packages.
10. By design, descriptive metadata about the contents of AIP files resides
outside Archivematica in access systems such as AtoM. This metadata is often
critical to understanding AIP contents.

#### Elasticsearch indexes as a data source

1. Some organizations may run Archivematica with Elasticsearch indexing
turned off.
2. There has been ongoing analysis and development to remove “unnecessary”
data from Elasticsearch documents to improve indexing performance.
3. Elasticsearch document structure is dynamic and may vary between AIPs.
4. Elasticsearch METS properties are deeply nested and unwieldy for developers
to work with.
5. Organisations using multiple pipelines have a reporting aggregation problem
because information is distributed across dashboards and Elasticsearch indexes.

#### Recent architecture developments

1. Recent architecture analysis leans towards making the Storage Service the
source of AIP information (i.e. instead of Elasticsearch).
2. Recent architecture analysis leans towards making future versions of
Archivematica components based more on an event sourcing pattern.
3. The most current releases of Archivematica have introduced the integration
of the Grafana, and Zabbix tools as well as a Prometheus data store for
consumption by aggregators and visualization tools . These namely address
system performance monitoring questions. How are these related to the other
types of reporting requirements? Do they overlap? Should any new reporting
functionality incorporate these?
4. The 1.12 release will add more display properties (columns) for search hits
in Backlog and Archival Storage tabs. It will also allow for the export of
these results in CSV format for import into third-party reporting and analysis
tools.

#### Reporting performance and maintenance

1. Reporting can impact the performance of the system and compute demands of
reporting are often quite different in nature to transactional processing.
Often systems clearly separate reporting components from transactional
components to minimize conflict between the two.
2. Where is the best place to aggregate, store, and secure Archivematica
reporting information?

## Considered options

The types of reports considered for the initial introduction of reporting
functionality to Archivematica are those in the
**Repository contents reporting** and **Repository statistics reporting**
sections above.

Repository performance monitoring is already being addressed with the
introduction of the Prometheus, Grafana, and Zabbix tools. Repository
reporting would be introduced in parallel to these.

Preservation planning reporting is more sophisticated and would require
information derived from content and statistical reporting as well as the FPR
database so it makes sense to address the other two types first before tackling
preservation planning reporting.

The analysis of reporting implementation requirements and decision drivers has
resulted in four considered options:

1. Develop reporting functionality using the existing set of technical
components and design patterns already implemented in Archivematica.
2. Add new  components, technologies or design patterns to support reporting
functionality in Archivematica.
3. Add a new external tool or service that provides reporting functionality
using already existing Archivematica components.
4. Add an external reporting tool to draw data from a new, dedicated
Archivematica [event-sourcing][event-source-1] endpoint.

## Decision outcome

Option 4: Add an external reporting tool that draws data from a new, dedicated
Archivematica event-sourced endpoint.

### Positive consequences

* Keeping the reporting tool external to core Archivematica means that it is
not coupled to existing Archivematica components that are deemed to be carrying
technical debt and may be scheduled for eventual refactoring.
* Drawing reporting data from an aggregated end-point will make the widest
variety of the manifold Archivematica data sources (METS XML files, MySQL
databases, Elasticsearch indexes, logfiles, Prometheus, Job/Task stdout)
available to reporting outputs. This is preferred to a tool that is limited to
the information offered by the Archivematica Storage Service API.
* A stand-alone reporting endpoint can be much more performant than requesting,
downloading and parsing METS XML files from the Storage Service API.
* Using a stand-alone reporting data endpoint means it could include descriptive
information held outside of Archivematica (e.g. integrated access systems like
AtoM).
* The data in the append-only event-sourced data stream can be used to
reconstruct previous states of the Archivematica system. This is not possible
when relying solely on the current state of existing Archivematica data
sources.
* With an event-source endpoint, system data can be re-played to create new
views and reports, including time series.
* Since the event-sourced endpoint will be immutable, it provides the ability
to produce audit trails and integrity checks.
* In a subsequent release, internal Archivematica components like the
Dashboard could become a client of the report data aggregation endpoint to
gradually introduce partial or full reporting functionality within the core
application.

## Pros and cons of the options

_Option 1: Develop reporting functionality using the existing set of technical
components and design patterns already implemented in Archivematica_:

This would consist of adding more properties (columns) to the Backlog and
Archival Storage tab search results table and CSV exports. However, this would
fall well short of the scope of the reporting requirements listed above and
would not sufficiently address the reporting problem statement.

_Option 2: Add new  components, technologies or design patterns  to support
reporting functionality in Archivematica_:

This would consist of building hard-coded, graphical user interfaces and
print-formatted reports as options in the Backlog and Archival Storage tabs or
by integrating third-party tools (e.g. Grafana, Kibana, Jasper Reports,
Pentaho Report Designer) into core Archivematica to provide these features.
However, one of the project goals is to limit the scope of core Archivematica,
address existing technical debt, and avoid development that introduces new
maintenance overhead. This option would couple the reporting solution to
existing Archivematica components that are deemed to be carrying technical debt
and may be scheduled for eventual refactoring. This option also puts a lot of
pressure on regression testing for future releases by introducing a significant
new functional component.

_Option 3: Add a new external tool or service that provides reporting
functionality using existing Archivematica components_:

This option would consist of one or more of the following:

1. Exposing Elasticsearch index API(s) to external third-party open-source
reporting tools (e.g. [Kibana][kibana-1]

    * Cons: exposing default ElasticSearch APIs to be used by reporting widgets
would be a security risk. Furthermore, using Kibana with Elasticsearch as the
primary data source is ruled out for the reasons listed in the section
“Elasticsearch indexes as a data source” above (Technical forces #9-13).

2. Finding a way to export Archivematica content and importing it to a Software
as a Service (SaaS) reporting solutions (e.g. [Tableau][tableau-1]

    * Cons: this would leave too much control of the implemented solution at
the whim of a third-party vendor. It also raises questions about licensing as
well as data security and sovereignty. This can be avoided if the reporting
solution is implemented in an open-source tool under the control of the
Archivematica implementor.

3. Implementing open-source, third-party Extract, Transform, Load (ETL)
reporting tools (e.g. [Pentaho Report Designer][pentaho-1],
[Jasper Reports][jasper-1] external to Archivematica using AIP METS XML
information requested from the Storage Service API as report content source.

    * Cons: requesting, downloading and parsing METS XML files from the Storage
Service API is not very performant and limited by HTTP bandwidth. The tool
would also have to track which METS files were already downloaded versus which
new METS files have been added since its last update.

4. Building hard-coded, graphical user interface (GUI) and print-formatted
reports into a new external reporting tool using AIP METS XML information
requested from the Storage Service API as report content source (e.g. the
AIPscan Proof of Concept)

    * Cons: integrating and customizing an existing reporting tool like Grafana
will take significantly less time than developing and maintaining a new, custom
reporting tool from scratch (e..g completing the GUI components for the
[AIPscan][aipscan-1] Proof of Concept tool).

_Option 4: Add an external reporting tool to draw data from a new, dedicated
Archivematica event-sourced endpoint_:

The pros of this approach are outlined above in the “Decision Outcome -
Positive consequences” section.

The preferred option for implementing this approach would be to use the
[Grafana][gradana-1] tool to draw data from the reporting endpoint.

Pros:

* Grafana is a next-generation, web-based reporting tool that offers better
integration and usability compared to first-generation, Java-based reporting
platforms like Jasper Reports or Pentaho Report Designer.
* Grafana’s open-source version is available under a permissive Apache 2.0
license.
* Archivematica has already integrated with Grafana for performance reporting.
Therefore there is experience amongst its developers and system administrators
in adapting and maintaining this tool.

Cons:

* Grafana may not offer the required reporting formats out-of-box. It is
anticipated that many tabular data reports will have to be created using
[Table Panels][table-panels-1], by integrating an existing [Plugin][grafana-2],
or by creating a [new Plugin][grafana-3].
* [PDF export][export-1] is only available in the commercially-licensed version
and may therefore need to be developed as a custom plugin to keep the reporting
component fully open-source and free.

## Links

* [ADR-0010][adr0010] 'Archivematica original design principles'
Archivematica's reporting options are heavily influenced by the original
technical architecture decision to make file-based Archival Information
Packages (AIPs) the focus of digital preservation processing and the canonical
source of preserved data.
* [Reporting improvements project][reporting-2017] (2017) - UCLA Library and NYPL Special Collections
* JISC Research Data Management [requirements for METS parsing][mets-1] (2015) - University of York and University of Hull

[adr0010]: https://github.com/archivematica/archivematica-architectural-decisions/blob/1d644ec44530aa50ccca07611aba85600b89b66d/0010-Archivematica-original-design-principles.md
[aipscan-1]: https://github.com/peterVG/AIPscan
[event-source-1]: https://martinfowler.com/eaaDev/EventSourcing.html
[export-1]: https://grafana.com/docs/grafana/latest/enterprise/export-pdf/#export-dashboard-as-pdf
[grafana-1]: https://grafana.com/
[grafana-2]: https://grafana.com/docs/grafana/latest/plugins/
[grafana-3]: https://grafana.com/docs/grafana/latest/developers/plugins/
[jasper-1]: https://community.jaspersoft.com/project/jasperreports-library
[kibana-1]: https://www.elastic.co/kibana
[mets-1]: https://wiki.archivematica.org/Research_data_management#METS_questions
[pentaho-1]: https://help.pentaho.com/Documentation/8.0/Products/Report_Designer
[table-panels-1]: https://grafana.com/docs/grafana/latest/panels/visualizations/table-panel/#table-panel
[tableau-1]: https://www.tableau.com/
[reporting-2017]: https://wiki.archivematica.org/Improvements/Reporting
