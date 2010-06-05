#!/bin/bash

. ../modules/bupler

bupler.import test

test.true $'test.true \'true\''
test.false $'test.true \'false\''

test.true $'test.false \'false\''
test.false $'test.false \'true\''

test.true $'test.stdout \'echo -n 1\' 1'
test.false $'test.stdout \'echo -n 1\' 2'

test.true $'test.exit_status \'true\' 0'
test.true $'test.exit_status \'false\' 1'
test.false $'test.exit_status \'true\' 1'
test.false $'test.exit_status \'false\' 0'

test.true $'test.equal 1 1 1'
test.false $'test.equal 0 1 0'
test.true $'test.not_equal 1 0'
test.true $'test.not_equal 0 1'
test.false $'test.not_equal 0 0'
test.false $'test.not_equal 1 1'
test.true $'test.not_equal 1 0 2'
test.true $'test.not_equal 0 1 2'
test.false $'test.not_equal 1 0 0'
test.false $'test.not_equal 1 1 2'
test.false $'test.not_equal 1 1 0'
test.false $'test.not_equal 0 1 0'
test.false $'test.not_equal 0 0 2'
test.false $'test.not_equal 0 0 0'
