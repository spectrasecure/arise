#!/bin/bash
# Prints help
arise_help() {
cat <<EOF
Welcome to Arise, a static site generator written in Bash

usage: 
        arise build -[k][f] 
                # Builds the entire site
                available in all build modes:
                        -k: Keeps source files in output
                        -f: Force overwrite pre-existing output
        arise -[p|s|r][k][f]
                # Builds only specific parts of the site
                # Useful for testing purposes
                mutually exclusive options:
                        -p: Build pages only mode
                        -s: Build sitemap only mode
                        -r: Build rss only mode

Please visit GitHub for more detailed info: 
https://github.com/neonspectra/arise

EOF
}
