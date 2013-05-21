#!/bin/sh

# Execute bash if the default shell is not bash
BASH=`which bash`
[ -x $BASH ] && exec $BASH -i
