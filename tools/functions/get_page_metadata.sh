#!/bin/bash
get_page_metadata() {
        metadata=$(sed -e '/END WMCMS/,$d' < $1)
        title=$(grep "Title::" <<< $metadata | cut -d '"' -f2)
        author=$(grep "Author::" <<< $metadata | cut -d '"' -f2)
        description=$(grep "Description::" <<< $metadata | cut -d '"' -f2)
        thumbnail=$(grep "Thumbnail::" <<< $metadata | cut -d '"' -f2)
        published_date=$(grep "Published Date::" <<< $metadata | cut -d '"' -f2)
        modified_date=$(grep "Modified Date::" <<< $metadata | cut -d '"' -f2)
        relative_url=$(dirname $1 | sed 's@.*site/html@@g')
        canonical_url="$base_url""$relative_url"
} 
