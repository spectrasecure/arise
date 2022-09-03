#!/bin/bash
# Builds all pages on the site by calling build_page
# Root site directory to recursively build from is specified as an argument.
# Usage: build_page /path/to/arise-source/

build_page_tree() (
cd $1

find . -type f -name "*.md" -not \( -path ./config -prune \) | while read fname; do
build_page $fname
done
)
