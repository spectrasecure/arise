#!/bin/bash
# Imports all functions, set configs, and deploys the site


# Always run this script with its location as pwd
cd $(dirname $0)

config=$(realpath ../site/html/config)

source functions/build_header.sh
source functions/build_footer.sh
source functions/build_toc.sh
source functions/get_page_metadata.sh
source functions/clear_metadata.sh

# get_page_metadata ../site/html/fiction/the-dreamer/index.md
#build_header ../site/html/fiction/the-dreamer/index.md index.html

build_toc $(realpath ../site/html/fiction/shellsite-toc.md)
ls ../site/html/fiction/
