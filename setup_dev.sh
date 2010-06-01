#!/bin/bash

cat <<EOF
You are about to install the Bupler lib for development purpose.

If you just want to install Bupler and get rid of this directory this isn't the
right Bupler setup for you, use setup.sh.

This setup creates symbolic links to the files in this directory from the
Bupler's default paths so you won't have to reinstall Bupler after pulling new
version, switching between branches or making changes.

But you'll have to remember not to remove this dir, or else you'll have to
reinstall Bupler.

EOF

echo -n "are you sure you want to continue? [y/N] "
read -n1 ans
if [[ "$ans" = [nN] ]]
then
    echo
    exit 1
fi
# add empty line
echo $'\n'

# load some parts of Bupler's lib that are helpful for this script.
BUPLER_LIB_PATH="src/bupler_lib/"
. src/bupler
bupler.import script

path=$(script.path) # This script path

. setup_settings

if [[ ( -e "$DEFAULT_BUPLER_INIT_PATH" || -L "$DEFAULT_BUPLER_INIT_PATH" ) || ( -e "$DEFAULT_BUPLER_INIT_PATH" || -L "$DEFAULT_BUPLER_INIT_PATH" ) ]]
then
    cat <<EOF
$DEFAULT_BUPLER_INIT_PATH or $DEFAULT_BUPLER_LIB_PATH already exist do you want
to replace them?
EOF
    read -n1 ans
    if [[ "$ans" = [yY] ]]
    then
        rm -rf "$DEFAULT_BUPLER_INIT_PATH"
        rm -rf "$DEFAULT_BUPLER_LIB_PATH"
    else
        exit 1
    fi
fi

ln -s "${path}/src/bupler" "$DEFAULT_BUPLER_INIT_PATH"
ln -s "${path}/src/bupler_lib" "$DEFAULT_BUPLER_LIB_PATH"
