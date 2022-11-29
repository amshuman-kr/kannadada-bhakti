#!/bin/bash

ls -1t content \
    | grep "\.md$" \
    | sed 's/\(.*\)\.\(.*\)/- [\1](content\/\1.\2)/' \
    | sed 's/\((.*\) \(.*)\)/\1%20\2/g'
