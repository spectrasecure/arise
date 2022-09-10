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

                sed -i "s^{{title}}^$title^g" $1
                sed -i "s^{{author}}^$author^g" $1
                sed -i "s^{{description}}^$description^g" $1
                sed -i "s^{{language}}^$language^g" $1
                sed -i "s^{{thumbnail}}^$thumbnail^g" $1
                sed -i "s^{{published_date}}^$published_date^g" $1
                sed -i "s^{{modified_date}}^$modified_date^g" $1
                sed -i "s^{{canonical_url}}^$canonical_url^g" $1
                sed -i "s^{{base_url}}^$base_url^g" $1
                sed -i "s^{{global_name}}^$global_name^g" $1
        }
}
