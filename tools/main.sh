#!/bin/bash
# Imports all functions, set configs, and deploys the site

# Set your base website URL here.
base_url='https://arise.sh'

# Grabs our current pwd in case we're building an individual file and need to go back to it after loading all of our dependencies
origin_pwd=$(pwd)

# Always run this script with the repo root location as pwd
cd '../'"$(dirname $0)"

config=$(realpath arise-source/config)

favicon="/relative/path/to/favicon.ico"

# Check if we're running a current version of bash before potentially causing code that won't run properly on ancient bash versions, like the ones bundled on macOS:
[ "$BASH_VERSINFO" -lt 5 ] && echo -e 'ERROR: Arise requires Bash version 5 or greater to run. Please install a newer version of Bash or ensure that you are using the newest version installed on your computer.\n\nYour current version of Bash is: '"$BASH_VERSINFO"'\n\nYou can verify the current running version of Bash by running the following command: echo "$BASH_VERSINFO"' && exit 1

# Makes sure that our paths have or don't have a '/' as expected regardless of user input.
## Favicon should have a '/' at the start of the path.
[[ $favicon != '' ]] && [[ ${favicon:0:1} != '/' ]] && favicon='/'"$favicon"
## Base URL should not have a '/' at the end.
[[ ${base_url: -1} == '/' ]] && base_url=${base_url::-1}

source tools/functions/arise_logo.sh
source tools/functions/arise_help.sh
source tools/functions/build_header.sh
source tools/functions/build_footer.sh
source tools/functions/build_page.sh
source tools/functions/build_toc.sh
source tools/functions/build_sitemap.sh
source tools/functions/build_rss.sh
source tools/functions/get_page_metadata.sh
source tools/functions/clear_metadata.sh


arise_logo
# Basic errors and warnings
mkdir -p arise-out
[[ -n "$(ls -A arise-out)" ]] && echo -e 'ERROR: The build output directory "/arise-output" is not empty. Program aborted to prevent overwrite of existing data.\nPlease empty the output directory before running Arise again.' && exit 1

# Read our arguments and set the build mode for processing. Display help if an invalid option is made.
if [[ $@ == "build" ]]; then
arise_build="full"

else
        while getopts ":psr" options; do
                case "${options}" in
                        p)
                                [[ -n "$arise_build" ]] && { arise_help; echo -e '\n\nERROR: Multiple exclusive build options detected. Aborting.'; exit 1; }
                                arise_build="pages_only";
                                ;;
                        s)
                                [[ -n "$arise_build" ]] && { arise_help; echo -e '\n\nERROR: Multiple exclusive build options detected. Aborting.'; exit 1; }
                                arise_build="sitemap_only";
                                ;;
                        r)
                                [[ -n "$arise_build" ]] && { arise_help; echo -e '\n\nERROR: Multiple exclusive build options detected. Aborting.'; exit 1; }
                                arise_build="rss_only";
                                ;;
                esac
        done
fi

[[ -z "$arise_build" ]] && { arise_help; exit 1; }

echo "$arise_build"


#get_page_metadata ../arise-source/fiction/the-dreamer/index.md
#echo $relative_url
#echo $canonical_url

#build_header ../site/html/fiction/the-dreamer/index.md index.html

#build_toc $(realpath ../site/html/fiction/shellsite-toc.md)
#ls ../site/html/fiction/

# build_sitemap ../arise-source/sitemap.xml
