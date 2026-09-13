# Archivematica AIP structure and its implications

* Status: Proposed
* Deciders: Artefactual Systems Inc.
* Date: 2019-04-27

## Context and problem statement

Archivematica's AIP structure has not been formalized. Documentation about the
AIP is scattered about the Artefactual collective knowledge-base in places such
as the Wiki, or codified under source control, i.e. in the Python modules
associated with AIP generation or the behaviors described by the various API
(application programming interface) endpoints.

Lack of specifications can be a detriment to feature development where rules
which may describe the potentials and limitations to develop the AIP structure
have not been written-down consistently.

For the open-source community engaging with Archivematica AIPs then developing
new features, or tooling around AIPs can be limited by having to take an AIP
at face value as exported from the AIP store.

It is difficult to validate the structure of an Archivematica AIP.
Archivematica's is expected to output an

## Decision Drivers

A simplification of Archivematica's workflow is to:

1. Receive a set of files as an input, a 'Transfer'.
2. Process those files through a set of standard or user-configured
microservices and record the output of those microservices.
3. Normalize objects for preservation and/or access.
4. Wrap the output of the workflow in additional metadata (METS/PREMIS), and
place the structure inside a Bag that conforms to the BagIt File Packaging
Format.

There are third-party tools that can help validate the AIP created by
Archivematica, the PREMIS in METS tool developed by Florida Libraries (FCLA).
METS has a schema that Archivematica must conform to as well.

The standards employed by Archivematica are designed to be customized.
Organizations, as an example, may describe their customizations using
mechanisms such as METS profiles, or Bag profiles.

Standards may evolve and we might want to incorporate the most up-to-date
features available in Archivematica. We currently rely on downstream tooling
to react at the same pace as Archivematica but those services may not be able
to react quickly, or at all, e.g. if the service is no longer maintained.

### Impact

If a contributor adds to the Archivematica project it is difficult to measure
the impact of changes to the AIP structure made by changes, such as those to
the workflow.

* It is difficult to understand how to extend the Archivematica AIP.
* It is difficult to validate an AIP created via processing in Archivematica.
* It is not possible to rely on third-party tooling to react to changes made in
standards which Archivematica might want to employ.

## Considered options

**NB.** Non-exhaustive list, which also needs to be verified as realistic,
below:

* Describe the Archivematica AIP structure in this ADR.
* Create a METS profile and publish it with the Library of Congress.
* Create a Bag profile and publish it with the Bagit-profiles repository.
* Codify Archivematica's AIP format in a software-based validation module.

## Decision outcome

**NB.** TBD.

### AIP specification

**NB.** Placeholder text below to help illuminate discussions around this ADR.

The Archivematica AIP can be described as follows:

#### Physical structure

An AIP has a specific structure on disk, which can be described as follows:

* Bag conforming to a bag profile
	* Features of the bag that we use are:
		* `Bag-info.txt` contains the UUID of the AIP.

##### Pointer files

* Pointer files are designed to describe this structure for future users.
* **NB.** bring together pointer file specification information here.
	* https://wiki.archivematica.org/AIP_pointer_file

#### Logical structure

An AIP is expected to have metadata that describes its contents. An AIP is
expected to be self-describing.

**NB.** https://github.com/archivematica/Issues/issues/652

##### AIP METS

* what do we expect here?
* what aren't we doing we could be doing?

##### AIP PREMIS

* what do we expect here?
* what aren't we doing we could be doing?

##### Transfer METS

* what do we expect here?
* what aren't we doing we could be doing?

#### Transfer properties preserved in an AIP

* Everything?
* Are there any exceptions?
* How is data preserved/mapped?
	* Recent examples:
		* Original order is expected to be preserved in transfer METS.
		* Log files?
		* Other outputs, `directory_tree.txt`?
		* Information from Bag transfers, e.g. in `bag-info.txt` is mapped to
		AIP METS.

### Positive consequences

* Contributors can develop tooling around Archivematica AIPS.
* Automated testing (AMAUAT) can be streamlined to point to a single standard
vs. rules defined in Gherkin.
* Tooling can form the basis of validation microservices inside the
Archivematica workflow.

## Technological impact

**NB.** These may be implied? This section might not be desired.

* Independent of Archivematica.
* Complimentary to mets-reader-writer.
* Complimentary to Bagit Python.
* Complimentary to Archivematica-docs.

## References

* Bagit RFC8493: https://tools.ietf.org/html/rfc8493
* PREMIS in METS: http://pim.fcla.edu/
* METS profiles: https://github.com/mets/METS-profiles
* Bag profile standard: https://github.com/bagit-profiles/
