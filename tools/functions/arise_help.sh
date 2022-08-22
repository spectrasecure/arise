#!/bin/bash
# Prints help
arise_help() {
cat <<EOF
Welcome to Arise, a static site generator written in Bash

usage: 
        arise build          
                # Builds the entire site
        arise -[p|s|r]
                # Builds only specific parts of the site
                # Useful for testing purposes
                options:
                        -p: Build pages only mode
                        -s: Build sitemap only mode
                        -r: Build rss only mode

Please visit GitHub for more detailed info: 
https://github.com/neonspectra/arise
EOF
}
