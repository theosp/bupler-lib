#!/bin/bash

if [[ -e "setup_settings" ]]
then
    . setup_settings # load the custom setup_settings
else
    . setup_settings.default # load the default setup_settings.
fi

# load the bupler module for the bupler.script_pwd()
. modules/bupler
script_pwd=$(bupler.script_pwd)

cat <<EOF
Bupler Setup
============

You are about to setup the Bupler lib.

SETUP PATHS
-----------

The modules files will be copied to: $LIB_PATH
Symlink to the bupler module ($LIB_PATH/bupler) will be created
on: $BUPLER_MODULE_SYMLINK_DIR

To change this parameters::

    $ cp setup_settings.default setup_settings
    $ vi setup_settings

EOF
if [[ "$PATH" != *$BUPLER_MODULE_SYMLINK_DIR* ]]
then
    cat <<EOF
Error
-----

The default directory on which we put the symlink to the bupler module::

    $BUPLER_MODULE_SYMLINK_DIR 

isn't part of your environment variable \$PATH ::

    $PATH

That means you won't be able to initiate Bupler by doing::

    $ . bupler

select one of your \$PATH's folders to create the symlink to the bupler
module on::

EOF

    # Set array PATHS with PATH's folders as values
    IFS=":"
    PATHS=( "" $PATH ) # "" is for beginning PATHS from 1
    unset IFS

    echo "0. Quit"
    for ((i=1; $i < ${#PATHS[@]}; i++ ))
    do
        echo $i". "${PATHS[$i]}
    done

    read -p "Select a folder [1-${#PATHS[@]}] or 0 to exit (default - 0): " -n1 ans 
    echo # just to add new line

    if [[ "$ans" != [1-${#PATHS[@]}] ]] # if $ans isn't within 1 to ${#PATHS[@]}
    then
        exit
    else
        BUPLER_MODULE_SYMLINK_DIR="${PATHS[$ans]}"
        echo "${PATHS[$ans]} was chosen"

        cat >setup_settings <<EOF 
LIB_PATH="/usr/local/share/bupler"
BUPLER_MODULE_SYMLINK_DIR="${PATHS[$ans]}"
EOF
    fi
fi

DEV_MODE=0
echo -n "Do you want to install bupler in development mode? [y/N/h] type h for help "
read -n1 ans
echo
if [[ "$ans" = [yYhH] ]]
then
    if [[ "$ans" = [hH] ]]
    then
        cat <<EOF

Development Mode
----------------

In contrast to the regular setup, installing bupler in development mode creates
symbolic link to the modules folder in this directory on $LIB_PATH instead of
coping it there. That way you won't have to reinstall Bupler after pulling new
version, switching between branches or making changes.

But you'll have to remember not to remove this directory, otherwise you won't
be able to load Bupler.

EOF

        echo -n "Do you want to install bupler in dev mode? [y/N] "
        read -n1 ans
        echo
    fi
    if [[ "$ans" = [yY] ]]
    then
        DEV_MODE=1
    fi
fi

echo -n "Ready to install Bupler? [y/N] "
read -n1 ans
echo
if [[ "$ans" = [nN] ]]
then
    exit 1
fi

if (( $DEV_MODE ))
then
    echo " * Create symlink to the modules directory: $script_pwd/modules -> $LIB_PATH"
else
    echo " * Copy modules to $LIB_PATH"
fi
if [[ -e "$LIB_PATH" || -L "$LIB_PATH" ]]
then
    echo -n "$LIB_PATH already exists, delete it? [y/N] "
    read -n1 ans
    echo
    if [[ "$ans" = [yY] ]]
    then
        rm -rf $LIB_PATH
    else
        exit 1
    fi
fi

if (( $DEV_MODE ))
then
    ln -s "$script_pwd/modules" $LIB_PATH
else
    cp -r modules $LIB_PATH
fi

BUPLER_MODULE_SYMLINK="$BUPLER_MODULE_SYMLINK_DIR/bupler"
echo " * Create symlink "$BUPLER_MODULE_SYMLINK' -> '$LIB_PATH/bupler
if [[ -e "$BUPLER_MODULE_SYMLINK" || -L "$BUPLER_MODULE_SYMLINK" ]]
then
    echo -n "$BUPLER_MODULE_SYMLINK already exists, delete it? [y/N] "
    read -n1 ans
    echo
    if [[ "$ans" = [yY] ]]
    then
        rm $BUPLER_MODULE_SYMLINK_DIR/bupler
    else
        exit 1
    fi
fi

ln -s $LIB_PATH/bupler "$BUPLER_MODULE_SYMLINK_DIR/bupler"

cat <<EOF
Install Complete
================

Bupler lib was successfully installed.
EOF
