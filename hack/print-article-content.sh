#!/bin/bash

gh-md-toc - | sed 's/\*/-/g' | sed 's/   /  /g' | sed 's/^  //'

