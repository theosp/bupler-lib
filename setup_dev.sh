#!/bin/bash

cat <<EOF
You are about to install the Bupler's lib for development purpose.

If you just want to install Bupler and get rid of this directory this isn't the
right Bupler setup for you, use setup.sh.

This setup creates symbolic links to the files in this directory from the
Bupler's default paths so you won't have to reinstall Bupler after pulling new
version, switching between branches or making changes.

But you'll have to remember not to remove this dir, or else you'll have to
reinstall Bupler.

EOF

# Load some parts of Bupler's lib that are helpful for this script.
BUPLER_LIB_PATH="src/bupler_lib/"
. src/bupler
bupler.import script

path=$(script.path) # This script path

. setup_settings

ln -s "${path}/src/bupler" "$DEFAULT_BUPLER_INIT_PATH"
ln -s "${path}/src/bupler_lib" "$DEFAULT_BUPLER_LIB_PATH"
