Developing Bupler
=================

The intended audience of this document is the developers who wish to extend the
bupler library or improve its structure.

Design
------

Bupler's design follows The Zen of Python.

The init script simply sets BUPLER_PATH if it isn't set yet, and loads
bupler.import function which is used to source modules.

Bupler's functions are divided into files according to the subject they are
deal with, this files are called bupler's modules (or simply modules).

The functions in each module are prefixed by the module name followed by a dot.

Default Paths
-------------

* Bupler init script: /usr/local/bin/bupler
* BUPLER_PATH: BUPLER_PATH is the variable that keeps the path to bupler's modules dir. Its default value is "/usr/local/share/bupler/" (Note the last /).

Conventions
-----------

* Modules should have short, all-lowercase names.  Underscores can be used in the module name if it improves readability.

Good BASH Resources
-------------------
