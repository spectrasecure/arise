#!/bin/bash
# Deploys a specific page from markdown to html, using WMCMS site base components.
# Usage: "markdown-pagebuilder.sh /path/to/index.md
#
# Set the absolute filepaths to your site config folder below:

build_page() (
config=/mnt/archive/github/neosynth-shellsite/site/html/config

### Begin script body ###

filename=$(basename $1)
cd $(dirname $1)

# Grab metadata from file and populate our header.

metadata=$(sed -e '/END WMCMS/,$d' < $filename)
title=$(grep "Title::" <<< $metadata | cut -d '"' -f2)
author=$(grep "Author::" <<< $metadata | cut -d '"' -f2)
description=$(grep "Description::" <<< $metadata | cut -d '"' -f2)
thumbnail=$(grep "Thumbnail::" <<< $metadata | cut -d '"' -f2)
published_date=$(grep "Published Date::" <<< $metadata | cut -d '"' -f2)
modified_date=$(grep "Modified Date::" <<< $metadata | cut -d '"' -f2)
canonical_url=$(grep "Web Link::" <<< $metadata | sed -n -e 's/.*\(http.*\)/\1/p')

cat $config/header.html > index.html

sed -i "s^{{title}}^$title^g" index.html
sed -i "s^{{author}}^$author^g" index.html
sed -i "s^{{description}}^$description^g" index.html
sed -i "s^{{thumbnail}}^$thumbnail^g" index.html
sed -i "s^{{published_date}}^$published_date^g" index.html
sed -i "s^{{modified_date}}^$modified_date^g" index.html
sed -i "s^{{canonical_url}}^$canonical_url^g" index.html


# Grab everything after the WMCMS metadata block, run it through pandoc to convert to html, and append to our file in progress
cat index.md | sed -e '1,/END WMCMS/d' | pandoc -f markdown -t html >> index.html

# Add a footer to the end
cat $config/footer.html >> index.html

#https://stackoverflow.com/questions/15965073/return-value-of-sed-for-no-match
#https://stackoverflow.com/questions/4844854/sed-rare-delimiter-other-than
#https://unix.stackexchange.com/questions/188264/how-do-i-substitute-only-first-occurence-with-sed
# Include inline code runs


while grep "<pre>sh#" index.html
do
#        sed -i s$'\020''<pre>sh#.*</pre>'$'\020'"$(bash <<< $(sed -n -e s$'\020''<pre>sh#\(.*\)</pre>'$'\020''\1'$'\020''p' < index.html | head -1))"$'\020''1' index.html || break

replacement=$(bash <<< $(sed -n -e s$'\001''<pre>sh#\(.*\)</pre>'$'\001''\1'$'\001''p' < index.html | head -1))
#sed -i s$'\001''<pre>sh#.*</pre>'$'\001'"$replacement"$'\001''1' index.html || break
awk 'NR==1,/<pre>sh#.*<\/pre>/{sub(/<pre>sh#.*<\/pre>/, "'"$replacement"'")}{print >"index.html"}' index.html || break
done
#grep "<pre>sh#" index.html | while read line
#do 
#        line=${line//*<pre>sh#/}
#        line=${line//<\/pre>*/}
#        bash <<< $line 
#done
)
