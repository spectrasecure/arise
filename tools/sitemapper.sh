#!/bin/bash
# Edit these three variables and run this script with no arguments to automatically generate a sitemap for your wmfs website.
baseurl='https://neosynth.net/' # Root URL for your site. Make sure to end in a /
localsite='../site/html/' # Location of local files to scan to build the sitemap
sitemap='./sitemap.xml' # Location to output sitemap file to, relative to site root. Generally speaking, you shouldn't need to change this

# Begin script function below
#############################


# Switch to local files directory
cd $localsite

# Wipe out the existing sitemap, if there is one, and declare our new sitemap
echo '<?xml version="1.0" encoding="UTF-8"?>' > $sitemap
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">' >> $sitemap

# List every directory in our sitemap (except config). This makes up our sitemap since wmfs is built to use directory roots as page URLs
find . -type d -not \( -path ./config -prune \) | while read fname; do
        
        # Rewrite the local path from the find command as the live web URL as the <loc> tag for the sitemap standard
        echo -e '<url>\n<loc>'"$baseurl""$(echo $fname | sed -n -e 's|\.\/||p')"'</loc>' >> $sitemap
        
        # If this page contains a wmfs-style date modified SSI tag, include that as a <lastmod> for the sitemap standard
        modified_date=$(grep 'set var="modified_date"' $fname/index.html)
        if [ -n "$modified_date" ]; then
                echo '<lastmod>'"$(echo $modified_date | sed -n -e 's/^.*value=\"\(.*\)\".*$/\1/p')"'</lastmod>' >> $sitemap
        fi

        # Close the <url> tag for the current URL being looped through
        echo '</url>' >> $sitemap
done

# Close up the sitemap
echo '</urlset>' >> $sitemap
