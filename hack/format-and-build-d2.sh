#!/bin/bash

for i in "$@"; do
    grep -R '^# ! d2' "$i" | awk -F ':# !' '{ print "sh -c \"d2 fmt " $1 "; cd $(dirname " $1 ");" $2 "\"" }' | bash
done
