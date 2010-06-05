Bupler's Distribution Structure and Setup Script
============================================

Versioning and Backward Compatibility - Principles
--------------------------------------------------

The development of a library should be done with responsibility for the works
that are already based on it - to avoid affecting, or worse breaking them, i.e.
to maintain backward compatibility. But often it turns out that the library
design or direction are wrong. In these cases the need to maintain backward
compatibility restricts the possibility to perform drastic changes on the
library and might lead to frustration that in turn can hurt the library
development and future.

To overcome this problem, Bupler adopted the notion of a "version" and a
"release". Each version can have multiple releases. For example, the version is
something like 2.5 or 3.0, while the release is something like 2.5.1 or 3.0a1.

Bupler maintains backward compatibility only between releases of the same
version, and lets new versions change anything.

The following is required for this development method:
    * Each code that uses Bupler should state which Bupler version it uses.
    * Each Bupler installation should install the latest release of all the
      available versions.

Distribution Folder Structure and setup.sh
------------------------------------------

The way this development method is implemented in the distribution structure
and setup script is as follow:

* Each version X.Y has a directory src/X.Y in which there are its init file
  named "bupler" and a folder named "lib" containing the version's library
  files.

  All the files on src/X.Y are of the latest X.Y release.

* The setup script copies the init file of each version to
  $BUPLER_INIT_PATH/buplerX.Y[#bupler_init_and_lib_paths] .

  So in order to use version 1.0 a script can do
  the following::

      $ . bupler1.0

  (Assuming $BUPLER_INIT_PATH is in the environment's $PATH)


* The setup script copies the lib folder of each version to
  $BUPLER_LIB_PATH/buplerX.Y[#bupler_init_and_lib_paths] .

.. [#bupler_init_and_lib_paths] $BUPLER_INIT_PATH and $BUPLER_LIB_PATH are
   defined on the "setup_settings", under the distribution root folder.
