# Post store DIP callback

* Status: proposed
* Date: 2019-04-09

## Context and problem statement

Archivematica allows to upload DIPs to a group of access systems (AtoM/Binder,
ArchivesSpace, etc.). However, integrating a new access system in the current
workflow is not an easy task, specially if you only need to notify the existence
of a new DIP in the Storage Service. Moreover, the DIP upload is performed from
Archivematica before the DIP is stored in the Storage Service, which is not
ideal for this kind of notifications.

For access systems that are able to import a DIP without needing its full
upload, the Storage Service should be able to notify them when a new DIP has
been stored. Similar to [the existing post store callback system][0], which is
only used for AIP storage at this point.

## Decision drivers

* Notify access systems when DIPs are stored in the Storage Service.
* Make clear the current post store callbacks are only for stored AIPs.

## Considered options

1. Add post store DIP callback in Storage Service.
2. Modify DIP upload workflow in Archivematica.
3. Create script in Automation Tools.

## Decision outcome

Chosen option: "1. Add post store DIP callback in Storage Service", because it
extends an existing functionality that allows the integration with multiple
access systems. If the time allows, it may also give us the option to further
improve the callbacks to:

* Limit them to specified storage locations.
* Allow request customization (headers and body).
* Report errors in the Storage Service interface.

[0]: https://www.archivematica.org/en/docs/storage-service-0.14/administrators/#service-callbacks
