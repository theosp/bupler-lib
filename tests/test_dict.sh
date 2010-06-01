#!/bin/bash

BUPLER_LIB_PATH="../src/bupler_lib/"
. ../src/bupler

bupler.import dict
bupler.import test

dict.Dict test.dict

# Test that the test.dict type was set correctly to Dict
test.equal $(bupler.type test.dict) 'Dict'

## Simple one word key, and an one word value
test.true 'test.dict.set word a'
test.true 'test.dict.has_key word'
test.stdout 'test.dict.get word' "a"

# Key name and a value with a spaces: preceding, trailing and between the words
test.true 'test.dict.set " two words " " a b "'
test.true 'test.dict.has_key " two words "'
test.stdout 'test.dict.get " two words "' " a b "

# Test space as a key and a value
test.true 'test.dict.set " " " "'
test.true 'test.dict.has_key " "'
test.stdout 'test.dict.get " "' " "

# Test distinction between one-space key and two-spaces key
test.dict.set "  " "  "
test.not_equal "$(test.dict.get " ")" "$(test.dict.get "  ")"

# Test newline as a key and a value
test.dict.set $'\n' $'\n'
test.true $'test.dict.has_key $\'\n\''
test.stdout $'test.dict.get $\'\n\'' $'\n'

# Test distinction between one-newline key and two-newlines key
test.dict.set $'\n\n' $'\n\n'
# `echo -n x` is there to prevent $() from truncating the newlines (which are
# trailing newlines...).
test.not_equal "$(test.dict.get $'\n'; echo -n x)" "$(test.dict.get $'\n\n'; echo -n x)"

# Test special chars
test.dict.set $'\b\r' $'\b\r'
test.true $'test.dict.has_key $\'\\b\\r\''
test.stdout $'test.dict.get $\'\\b\\r\'' $'\b\r'

# Test distinction between keys with special chars
test.dict.set $'\b\r\b\r' $'\b\r\b\r'
test.not_equal "$(test.dict.get $'\b\r'; echo -n x)" "$(test.dict.get $'\b\r\b\r'; echo -n x)"

# Test len
test.stdout 'test.dict.len' '8'

# Test set of more than one key at once
test.dict.set $'\na\n' $'a  b' '  b' 2 ' c ' 3
test.stdout $'test.dict.get $\'\\na\\n\'' $'a  b'
test.stdout $'test.dict.get \'  b\'' "2"
test.stdout $'test.dict.get \' c \'' "3"

# Test len
test.stdout 'test.dict.len' '11'

# Test reset
test.dict.set $'\na\n' '1' '  b' ' 2' ' c ' '3 '
test.stdout $'test.dict.get $\'\\na\\n\'' $'1'
test.stdout $'test.dict.get \'  b\'' " 2"
test.stdout $'test.dict.get \' c \'' "3 "

# Test that len didn't changed
test.stdout 'test.dict.len' '11'

# Test del
test.true $'test.dict.del \' c \' \'  b\''
# Test has_key for deleted elements
test.false $'test.dict.has_key $\' c \''
test.false $'test.dict.has_key $\'  b\''
# Test del for element that doesn't exist.
test.false $'test.dict.del \' c \'' 
# Test that len updated correctly
test.stdout 'test.dict.len' '9'
