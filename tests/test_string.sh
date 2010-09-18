#!/bin/bash

. ../modules/bupler

bupler.import string 
bupler.import test

string.String daniel "daniel"
string.String a "a"

# test bupler.type
test.equal $(bupler.type a) 'String'

# test len
test.stdout 'daniel.len' 6

# test repeat
a=$(a.repeat 2)
test.stdout a.len 2
test.equal "$a" "aa"
