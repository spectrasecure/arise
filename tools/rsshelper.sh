#!/bin/bash
# Command usage: rsshelper https://website.com/article.html
rss='../site/html/rss.xml' # Location of destination RSS file to update goes here

# Begin script function below
#############################



# Creates a temporary file location and downloads the webpage we want to add to RSS
webpage=`mktemp /tmp/XXXXXXXXX.html`
curl $1 -o $webpage

# Extracts metadata from html head
title=$(grep "og:title" $webpage | sed -n -e 's/^.*content=\"\(.*\)\".*$/\1/p')
description=$(grep "og:description" $webpage | sed -n -e 's/^.*content=\"\(.*\)\".*$/\1/p')
url=$(grep "og:url" $webpage | sed -n -e 's/^.*content=\"\(.*\)\".*$/\1/p')
author=$(grep 'meta name="author"' $webpage | sed -n -e 's/^.*content=\"\(.*\)\".*$/\1/p')
pubdate=$(grep 'meta property="article:published_time"' $webpage | sed -n -e 's/^.*content=\"\(.*\)\".*$/\1/p')

# Convert html's ISO8601 date to RSS's RFC-822. Fuck you RSS.
pubdate=$(date -d"$pubdate" --rfc-822)
# Crops off the appended sitename for my website from the page title meta ;)
title=$(sed -n -e 's/\(.*\) \\\\ Neosynth/\1/p' <<< "$title" )

# Updates the last build date of the RSS feed to now and then creates a new RSS item entry in our existing feed using ed
ed $rss << EOF
/<lastBuildDate>
d
a
<lastBuildDate>$(date --rfc-822)</lastBuildDate>
.
$
-
-
a
<item>
<title>$title</title>
<dc:creator>$author</dc:creator>
<description>$description</description>
<link>$url</link>
<pubDate>$pubdate</pubDate>
</item>
.
w
q
EOF

# Deletes our temporary file that we scraped to pull data from
rm $webpage
