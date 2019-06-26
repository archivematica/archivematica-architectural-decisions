# Contributing

## When to submit an ADR

The purpose of an ADR is to record an over-arching technical decision made by the development team in the Archivematica 
project. An ADR is akin to a policy in other contexts- it describes a way that future features or changes should be 
implemented, rather than describing the features themselves (to submit a feature idea, head to the Issues repo).  
Developers will use ADRs to understand how code should be written and analysts and end-users to understand implementation 
decisions.

Examples of situations when an ADR is appropriate:

* A change to how code is formatted 
* Major architectural changes (e.g. bringing together or separation of components, upgrade of major dependencies, etc.)
* Deprecation of existing features

ADRs may be written retroactively to make a record of core features or functionality.

## How to submit an ADR

ADRs must be submitted as a pull request to this repo. To get started, first review currently accepted ADRs, then use the 
template to write yours.

ADRs can be submitted in WIP form if desired but in all cases should be submitted with the status “proposed.”

While ADRs are often technically focused, it’s good practice to write them in plain, understandable language (The 
Archivematica docs wiki provides good guidance on this subject).

When you submit an ADR be sure to assign at least one reviewer. If you’re concerned about understandability you might
include a reviewer of a different background than your own (e.g. assign an analyst as a reviewer if you are a developer 
and vice versa).

## How an ADR is reviewed and merged

The purpose for code review of an ADR is:

* clarity of language
* formatting
* ADR number collisions 

Once the ADR is approved it can be merged by the submitter. While the code review ensures understandability of the ADR, 
all Archivematica team and community members are encouraged to participate in discussion about the proposed changes. 

When merging remember also to update the Accepted log.

## ADR statuses

After discussion and code review the ADR may be merged with the status accepted (or rejected, or remain in proposed if 
deemed more appropriate). ADRs can also be deprecated, or superseded by another ADR.

## Changes to the ADR process:

To propose changes to ADR templates or these guidelines, file an issue in the Archivematica Issues repo.

## More information:

More information on MADR is available at https://adr.github.io/madr/. General information about architectural decision records is available at https://adr.github.io/.

