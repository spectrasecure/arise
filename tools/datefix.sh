#!/bin/bash
# This script fixes the date modified timestamp on folders, which is important for fancyindex.
localsite='/usr/share/nginx/html' # Location of local files to scan to build the sitemap

# Begin script function below
#############################


# Switch to local files directory
cd $localsite

# List every directory in our sitemap (except config). This makes up our sitemap since wmfs is built to use directory roots as page URLs
find . -type d -not \( -path ./config -prune \) | while read fname; do
        # If this page contains a wmfs-style date modified SSI tag, sed the folder to have the right timestamp
        modified_date=$(grep 'set var="modified_date"' $fname/index.html)
        if [ -n "$modified_date" ]; then
                touch -a -m -d $(echo $modified_date | sed -n -e 's/^.*value=\"\(.*\)\".*$/\1/p') $fname
        fi
done
