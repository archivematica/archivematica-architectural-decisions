# Introduce reporting functionality

* Status: WIP
* Deciders: Peter Van Garderen, [Add your name here]
* Date: 2020-05-05 [Most recent draft]

## Context and problem statement
Archivematica users want statistics about what their Archivematica deployments are doing and when, as well as detailed breakdowns of the content in their Archivematica systems. While the existing Archival Storage search and hit display does provide some useful output, it does not aggregate this information or present it in management-style reports.

Work on a comprehensive reporting feature has been blocked in the past because it hasn't been clear where the canonical source of Archivematica statistical and content information is stored or which of these sources is the most convenient, comprehensive, or performant input for building reports. This raises the question whether reporting should be a functionality supported natively by the Archivematica application or externaly by a third-party tool. 

There is also some mixup between logging functionality, reporting features, and the outputs provided by Archivematica's Format Policy Registry (FPR). 

All of this is complicated further by the fact that production Archivematica deployments are often split over multiple processing pipelines and/or storage locations.

Examples of the types of reporting information that users want from their Archivematica systems include:
* How many files are in archival storage?
* How many AIPs are in archival storage?
* How many files are in a specified AIP?
* an overview of which and how many files of a specific file format (i.e. PRONOM PUID) are in all AIPs in archival storage (either a list for one file format, or a list of all files, grouped per file format with info on the AIP name/UUID, storage volume, and storage location) 
* an overview of all AIPs stored in Archivematica with their name, UUID, storage location, creation date, amount in Mb/Gb/Tb, preferably grouped by storage location
* a report of the total number of files per file format and data volume ingested during one year
* a report for each version of a given file format, including the number of files and total data volume
* for each version of a file format, a report of how many files contain a second manifestation (can be a presentation (access) copy, an anonymous version or an original file or another conversion version of a file)
* a report of the file formats (and/or Mime Types) in a given accession 
* a report summarizing specific technical properties in a file such as: tables and images in a Word document and calculation formulas in an Excel file.
* a report listing all Backlog packages and AIPs that have been deleted
* an overview of which files have had new access formats generated as a result of a re-ingest and when (date/time)
* an overview of the file formats that are registered to be accepted, sorted in alphabetical order
* an overview of what rules have been set for approved file formats for preservation and for access, sorted per file format
* How many [video, image, plain text etc.] files are in archival storage?	
* What is the total volume of [video, image, plain text etc.] files in archival storage?
* How many files with PRONOM puid X have been normalized?	
* How many files with PRONOM puid X have not been normalized?	
* How many [video, image, plain text etc.] files have been normalized?
* How many [video, image, plain text etc.] files have not been normalized?	
* How many files were ingested between date X and date Y?	
* How many files with PRONOM puid X are invalid/not well-formed?
* How many files with format name X are invalid/not well-formed?
* How many AIPs have corresponding DIPs?
* How many AIPs do not have corresponding DIPs?
* How many transfers or SIPs had processing failures in the last week, month, or year. What were the errors they experienced? How many of these went unresolved?




## Decision drivers

* A sponsored client project would like to implement Archivematica reporting features

## Considered options

1. Improve display of search hits in Backlog and Archival Storage tabs. Allow download of results as CSV.
2. Build hard-coded, GUI & print-formatted reports into the Backlog and Archival Storage tabs. Use ElasticSearch index(es) and/or METS XML files in Storage Service as report content source. Allow download as PDF.
3. Integrate open-source [Kibana](https://www.elastic.co/kibana) dashboard widgets into the Archivematica Dashboard using the ElasticSearch index(es) as report content source.
4. Integrate open-source third-party reporting tools (e.g. [Pentaho Report Designer](https://help.pentaho.com/Documentation/8.0/Products/Report_Designer), [Jasper Reports](https://community.jaspersoft.com/project/jasperreports-library)) into the Archivematica Dashboard using ElasticSearch index(es) and/or METS XML files in the Storage Service as report content source.
5. Implement opern-source third-party reporting tools (e.g. Pentaho, Jasper) external to Archivematica using AIP METS XML information requested from the Storage Service as report content source.
6. Expose ElasticSearch index API(s) to external third-party open-source reporting tools (e.g. Kibana, Pentaho, Jasper)
7. Build hard-coded, GUI & print-formatted reports into a new external reporting tool using AIP METS XML information requested from the Storage Service as report content source (e.g. [AIPscan](https://github.com/peterVG/AIPscan))
8. Find a way to connect Archivematica content to Software as a Service reporting (SaaS) reporting solutions (e.g. [Tableau](https://www.tableau.com/))
9. Use Archivematica pipeline MySQL database and log files as content source for chosen reporting solution (instead of or in addition to ElasticSearch index(es) and AIP METS XML files).


## Decision outcome

Chosen option: "[option 1]", because [justification. e.g., only option, which
meets k.o. criterion decision driver | which resolves force force | … | comes
out best (see below)].

### Positive consequences <!-- optional -->

* [e.g., improvement of quality attribute satisfaction, follow-up decisions
  required, …]
* …

### Negative consequences <!-- optional -->

* [e.g., compromising quality attribute, follow-up decisions required, …]
* …

## Pros and cons of the options <!-- optional -->

### [option 1]

[example | description | pointer to more information | …] <!-- optional -->

* _Good, because [argument a]_
* Good, because [argument b]
* Bad, because [argument c]
* … <!-- numbers of pros and cons can vary -->

### [option 2]

[example | description | pointer to more information | …] <!-- optional -->

* Good, because [argument a]
* Good, because [argument b]
* Bad, because [argument c]
* … <!-- numbers of pros and cons can vary -->

### [option 3]

[example | description | pointer to more information | …] <!-- optional -->

* Good, because [argument a]
* Good, because [argument b]
* Bad, because [argument c]
* … <!-- numbers of pros and cons can vary -->

## Links <!-- optional -->

* ADR-0010-Archivematica-original-design-principles [link when it's available]. Archivematica's reporting options are heavily influenced by the original technical architecture decision to make file-based Archival Information Packages (AIPs) the focus of digital preservation processing and the canonical source of preserved data.
* JISC (University of York, University of Hull) Research Data Management [requirements for METS parsing](https://wiki.archivematica.org/Research_data_management#METS_questions)
