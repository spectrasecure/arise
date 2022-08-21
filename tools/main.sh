#!/bin/bash
# Imports all functions, set configs, and deploys the site

# Set your base website URL here.
base_url='https://arise.sh'

# Grabs our current pwd in case we're building an individual file and need to go back to it after loading all of our dependencies
origin_pwd=$(pwd)

# Always run this script with its location as pwd
cd $(dirname $0)

config=$(realpath ../arise-source/config)

favicon="/relative/path/to/favicon.ico"

# Makes sure that our paths have or don't have a '/' as expected regardless of user input.
## Favicon should have a '/' at the start of the path.
[[ $favicon != '' ]] && [[ ${favicon:0:1} != '/' ]] && favicon='/'"$favicon"
## Base URL should not have a '/' at the end.
[[ ${base_url: -1} == '/' ]] && base_url=${base_url::-1}

source functions/arise_help.sh
source functions/build_header.sh
source functions/build_footer.sh
source functions/build_toc.sh
source functions/build_sitemap.sh
source functions/build_rss.sh
source functions/get_page_metadata.sh
source functions/clear_metadata.sh


if [[ $@ == "build" ]]; then
#get_page_metadata ../arise-source/fiction/the-dreamer/index.md
#echo $relative_url
#echo $canonical_url

#build_header ../site/html/fiction/the-dreamer/index.md index.html

#build_toc $(realpath ../site/html/fiction/shellsite-toc.md)
#ls ../site/html/fiction/


# Rss Testing
echo "Building site..."
build_sitemap ../arise-source/sitemap.xml

else
        while getopts ":p:s:r:" options; do
                case "${options}" in
                        p)
                                echo "building page "" ${OPTARG}"
                                ;;
                        s)
                                echo "building sitemap"" ${OPTARG}"
                                ;;
                        r)
                                echo "building rss feed"" ${OPTARG}"
                                ;;
                        :)
                                echo "command requires arg"
                                ;;
                        \?)
                                echo "Invalid command"
                                ;;
                        *)
                                echo "everything else"
                                ;;
                esac
        done
fi
