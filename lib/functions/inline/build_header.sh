#!/bin/bash
#############                                                                                            
# DESCRIPTION
#############
# Builds the page header
#
# This function assumes that metadata has already been fetched in the current subshell. If no metadata is present, it will do nothing.
# 
#############
# Usage:
# build_header destination.html

build_header() {
        # Verify that metadata variables are populated before running.
        [[ $title != '' ]] && {
                cat $config/header.html > $1
                
                # If enabled (default:true), add a configurable content header after the metadata header. The purpose of this is to enable a standardised header for stuff like post dates that should be on *most* pages, but can be disabled on pages the user considers special and wants to build out completely on their own.
                [[ $content_header == "true" ]] && cat $config/content_header.html >> $1
                
                # Replace all tags with their value. Ampersands are a special character in sed, so we have to clean them up using bash string manipulation before running the sed global replace.
                page_contents="$(cat $1)"
                title=${title//&/\\&}
                page_contents="${page_contents//\{\{title\}\}/"$title"}"

                author=${author//&/\\&}
                page_contents="${page_contents//\{\{author\}\}/"$author"}"
                
                description=${description//&/\\&}
                page_contents="${page_contents//\{\{description\}\}/"$description"}"
                
                language=${language//&/\\&}
                page_contents="${page_contents//\{\{language\}\}/"$language"}"
                
                thumbnail=${thumbnail//&/\\&}
                page_contents="${page_contents//\{\{thumbnail\}\}/"$thumbnail"}"
                
                page_contents="${page_contents//\{\{published_date\}\}/"$published_date"}"
                
                page_contents="${page_contents//\{\{modified_date\}\}/"$modified_date"}"
                
                canonical_url=${canonical_url//&/\\&}
                page_contents="${page_contents//\{\{canonical_url\}\}/"$canonical_url"}"
                
                base_url=${base_url//&/\\&}
                page_contents="${page_contents//\{\{base_url\}\}/"$base_url"}"
                
                global_name=${global_name//&/\\&}
                page_contents="${page_contents//\{\{global_name\}\}/"$global_name"}"

                echo "$page_contents" > $1
                page_contents=""
        }
}
