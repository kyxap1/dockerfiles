#!/usr/bin/env bash

export LANG=C # must have

# 1-column to tabs-separated multicolumn
cat 1-col.txt | sort | column

# 1-column to spaces-separated multicolumn
cat 1-col.txt | sort | column | expand

# 1-column to string w/delimiter
cat 1-col.txt | sort | paste -sd:

# multicolumn to 1-column
cat multi-col-spaces.txt | xargs -n 1 | sort

# string w/delimiter to 1-column
cat 1-string-delim.txt | tr ':' '\n' | sort

