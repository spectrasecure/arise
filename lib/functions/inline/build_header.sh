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
                title=${title//&/\\&}
                sed -i "s^{{title}}^$title^g" $1

                author=${author//&/\\&}
                sed -i "s^{{author}}^$author^g" $1
                
                description=${description//&/\\&}
                sed -i "s^{{description}}^$description^g" $1
                
                language=${language//&/\\&}
                sed -i "s^{{language}}^$language^g" $1
                
                thumbnail=${thumbnail//&/\\&}
                sed -i "s^{{thumbnail}}^$thumbnail^g" $1
                
                sed -i "s^{{published_date}}^$published_date^g" $1
                
                sed -i "s^{{modified_date}}^$modified_date^g" $1
                
                canonical_url=${canonical_url//&/\\&}
                sed -i "s^{{canonical_url}}^$canonical_url^g" $1
                
                base_url=${base_url//&/\\&}
                sed -i "s^{{base_url}}^$base_url^g" $1
                
                global_name=${global_name//&/\\&}
                sed -i "s^{{global_name}}^$global_name^g" $1
        }
}
