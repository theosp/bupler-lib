Reverse Compatibility and Versioning
====================================

The development of a library should be with responsibility for the works that
is already based on it - to avoid affecting, or worse breaking them, i.e. to
maintain reverse compatibility. But often it turns out that the library design
or direction are wrong. In this cases the need to maintain reverse
compatibility restricts the possibility to perform drastic changes on the
library and might lead to frustration that in turn can hurt the library
development and future.

To overcome this problem, Bupler adopted the notion of a "version" and a
"release". Each version can have multiple releases. For example, for example
the version is something like 2.5 or 3.0, while the release is something like
2.5.1 or 3.0a1.

Bupler maintains reverse compatibility only within a version releases, And each
new Bupler version is free to change anything.

The following is required for this development method:
    * Each code that uses Bupler should state which Bupler version it uses.
    * Each Bupler installation should install the latest release of all the
      available versions.
