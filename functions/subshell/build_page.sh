#!/bin/bash
#############
# DESCRIPTION
#############
# Builds a page from a source .md file and outputs the built version to 'index.html' in the same directory
#
#############
# Usage: 
# build_page source.md

build_page() (

# Switch to page directory
page=$(basename $1)
cd $(dirname $1)

get_page_metadata $page

if [[ $is_toc == "true" ]]; then
        build_toc $page
elif [[ $process_markdown == "false" ]]; then
        build_header index.html
        cat $page | sed -e '1,/END ARISE/d' | cat >> index.html
        build_footer index.html
else
        build_header index.html
        # Grab everything after the Arise metadata block, run it through pandoc to convert to html, and append to our file in progress
        cat $page | sed -e '1,/END ARISE/d' | pandoc -f markdown -t html >> index.html
        build_footer index.html
fi

# Inline Evaluations - DISABLED / BETA
#while grep "<pre>sh#" index.html
#do
#        replacement=$(bash <<< $(sed -n -e s$'\001''<pre>sh#\(.*\)</pre>'$'\001''\1'$'\001''p' < index.html | head -1))
#        awk 'NR==1,/<pre>sh#.*<\/pre>/{sub(/<pre>sh#.*<\/pre>/, "'"$replacement"'")}{print >"index.html"}' index.html || break
#done

)
