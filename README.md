bupler
======

Obtaining Bupler's Documentation:
---------------------------------
Bupler uses [Sphinx][SphinxHP] for its documentation.

Raw documentation files available under: docs/source (.rst files)

You can view the documentation online on: http://www.bupler.com/ .

Or generate local HTML version of bupler's documentation:

    $ sudo easy_install -U Sphinx # easy_install comes with the python-setuptools package
    $ cd docs
    $ make html

The files will be available under: docs/build/html .

[SphinxHP]: http://sphinx.pocoo.org/
