#!/bin/bash
# Creates a table of contents for any directory with a TOC placeholder.

build_toc() (
toc_placeholder='shellsite-toc.md'

source /mnt/archive/github/neosynth-shellsite/tools/functions/get_page_metadata.sh

cd $(dirname $1)
cat /dev/null > index.html

find . -mindepth 2 -maxdepth 2 -type f -name 'index.md' | while read fname; do
get_page_metadata $fname
#title=$(grep "Title::" <<< $(sed -e '/END WMCMS/,$d' < $fname) | cut -d '"' -f2)
echo "$title" >> index.html
done
)

build_toc $1
