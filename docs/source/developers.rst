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


Bupler's Terminology and Structure
==================================

Modules:
--------

Each file in the Bupler library is called "module" and should deal with one
subject (like strings, tests, etc...) the module file name defines the module
name.

Currently there is no definition for how to set module variables, therefore
modules has only functions.

To implement the concept of namespaces that BASH doesn't have we require each
Bupler module's function to be prefixed with the module name and a dot. (like
the string module's string.len() function )

Classes:
--------

BASH isn't object oriented language, therefore it has no concept of classes.

Bupler's classes are **bash functions** that imitates class behavior, they
get a name "foo" for a new object and (optionally) some initial values and
generate functions of the form foo.method_name() .

Classes Data:
-------------

There is (currently) one limitation though: Unlike real object oriented
languages' classes Bupler's classes has no attributes. All the data about an
object should be stored in a variable named after the object name.

So, for example, you can know for sure that all the object specific data of
an object 'abc' of the string.String class is accessible by $abc .

The potential benefit you can get from this design is the ability to work
with an object both as an object and as a regular variable.

Back to the example: if we've initiated abc to "Hello world":
$ string.String abc "hello world"

we can use its method abc.len to get its length but we can also change its
value in the tradition bash way by using:
abc="new value"
and all abc methods will still be usable and will work with "new value"

Bupler's naming conventions:
============================

Modules:
--------

* Modules should have short, all-lowercase names.
* Underscores can be used in the module name if it improves readability.
* Modules names should be in a singular form.

Functions:
----------

* Functions must be prefixed by their containing module name and a dot.
      For example function "bar" under the "foo" module should be named: "foo.bar".

* Functions should have short, all-lowercase names.
* Underscores can be used in the module name if it improves readability.

Classes:
--------

* class names should be CamelCased.
* As with functions modules should be prefixed with the module name and a
  dot.

Bupler's Documentation Conventions
==================================

Modules:
--------

Each module foo should provide a doc function named: foo.doc() that prints
its documentation.

The module documentation should be as follow:

first line - short (few words) module description
[empty line]
Full description

Functions:
----------
For each function foo.bar() there should be a doc function named:
foo.bar.doc() that prints its documentation.

The function documentation should be as follow:

first line - function synopsis like: foo.bar(param1, param2, ...)
[empty line]
full description
[empty line]
Exit status:
List of possible exit status and the meaning of each one of them:

Classes:
--------

TODO

Good BASH Resources
-------------------

* http://mywiki.wooledge.org/
* POSIX: http://www.opengroup.org/onlinepubs/9699919799/utilities/contents.html
* http://www.bash-hackers.org/wiki/doku.php
* Coreutils FAQ: http://www.gnu.org/software/coreutils/faq/coreutils-faq.html
