#!/bin/bash
# Builds all pages on the site by calling build_page
# Root site directory to recursively build from is specified as an argument.
# Usage: build_page /path/to/arise-out/

build_page_tree() (
cd $1

find . -type f -name "*.md" -not \( -path ./config -prune \) | while read fname; do
build_page $fname

# Add the source file to the list of files to remove in cleanup
echo "$(realpath $fname)" >> $removelist
done
)
