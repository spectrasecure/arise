#!/bin/bash
#############                                                                                            
# DESCRIPTION
#############
# Pulls all the Arise-specific metadata from the header of a given page.
#
# This function is meant to be run inline before other functions so that it can populate the information other functions need to operate upon.
#
#############
# Usage:
# get_page_metadata source.md

get_page_metadata() {
        if [[ -e $1 ]]; then
                metadata=$(sed -e '/END ARISE/,$d' < $1)

                # Main page metadata
                title=$(grep "Title::" <<< $metadata | cut -d '"' -f2)
                author=$(grep "Author::" <<< $metadata | cut -d '"' -f2)
                description=$(grep "Description::" <<< $metadata | cut -d '"' -f2)
                language=$(grep "Language::" <<< $metadata | cut -d '"' -f2)
                thumbnail=$(grep "Thumbnail::" <<< $metadata | cut -d '"' -f2)
                published_date=$(grep "Published Date::" <<< $metadata | cut -d '"' -f2)
                modified_date=$(grep "Modified Date::" <<< $metadata | cut -d '"' -f2)
                
                # Optional page settings with default settings

                # is_toc default: false
                is_toc=$(grep "toc::" <<< $metadata | cut -d '"' -f2)
                if [[ $is_toc != "true" ]]; then
                        is_toc="false"
                fi
                        
                # process_markdown default: true
                process_markdown=$(grep "process_markdown::" <<< $metadata | cut -d '"' -f2)
                if [[ $process_markdown != "false" ]]; then
                        process_markdown="true"
                fi
                
                # content_header default: true
                content_header=$(grep "content_header::" <<< $metadata | cut -d '"' -f2)
                if [[ $content_header != "false" ]]; then
                        content_header="true"
                fi

                # rss_hide default: false
                rss_hide=$(grep "rss_hide::" <<< $metadata | cut -d '"' -f2)
                if [[ $rss_hide != "true" ]]; then
                        rss_hide="false"
                fi
                
                # URL
                relative_url="$(realpath $(dirname $1) | sed 's@.*arise-out@@g')"'/'
                canonical_url="$base_url""$relative_url"
        else
                # Clear out metadata so that anything calling this function expecting to get new data cannot get old values on accident if the requested file does not exist.
                clear_metadata
        fi

} 
