#!/bin/bash

. ../modules/bupler

bupler.import file
bupler.import test

cat <<EOF >temp
/123
EOF

# file.replace exit_status should always be 0
# test simple replacements
test.true "file.replace temp '1' '2'"
test.true "file.replace temp '1' '2'"

test.equal "$(<temp)" "/223"

test.true "file.replace temp '/' '2'"
test.true "file.replace temp '2' '/'"
test.true "file.replace temp '/' '0'"

test.equal "$(<temp)" "0003"

# test regex replacements
test.true "file.replace temp '^.' '2'"

test.equal "$(<temp)" "2003"

test.true "file.replace temp '[03]' '79'"
test.equal "$(<temp)" "2797979"

test.true "file.replace temp '[7-9]\{1,3\}' '7'"
test.equal "$(<temp)" "277"

# currently file.replace fails for empty matches
test.false "file.replace temp '^' '7'"

rm temp
