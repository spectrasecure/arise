#/bin/bash
source markdown-pagebuilder.sh

localsite='../site/html/'

cd $localsite

find . -type f -name "*.md" -not \( -path ./config -prune \) | while read fname; do
build_page $fname

#echo "$(date) - $fname"
#echo $(dirname $fname)
#echo $(basename $fname)
done

