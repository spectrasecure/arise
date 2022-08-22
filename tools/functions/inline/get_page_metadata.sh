#!/bin/bash
get_page_metadata() {
        if [[ -e $1 ]]; then
                metadata=$(sed -e '/END ARISE/,$d' < $1)
                title=$(grep "Title::" <<< $metadata | cut -d '"' -f2)
                author=$(grep "Author::" <<< $metadata | cut -d '"' -f2)
                description=$(grep "Description::" <<< $metadata | cut -d '"' -f2)
                language=$(grep "Language::" <<< $metadata | cut -d '"' -f2)
                thumbnail=$(grep "Thumbnail::" <<< $metadata | cut -d '"' -f2)
                published_date=$(grep "Published Date::" <<< $metadata | cut -d '"' -f2)
                modified_date=$(grep "Modified Date::" <<< $metadata | cut -d '"' -f2)
                relative_url=$(realpath $(dirname $1) | sed 's@.*arise-source@@g')
                canonical_url="$base_url""$relative_url"
        else
                # Clear out metadata so that anything calling this function expecting to get new data cannot get old values on accident if the requested file does not exist.
                clear_metadata
        fi
} 
