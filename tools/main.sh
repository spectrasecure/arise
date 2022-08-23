#!/bin/bash
arise_version="1.0.0-alpha"

# Imports all functions, set configs, and deploys the site

# Set your base website URL here.
base_url='https://arise.sh'

# Grabs our current pwd in case we're building an individual file and need to go back to it after loading all of our dependencies
origin_pwd=$(pwd)

# Always run this script with the repo root location as pwd
cd "$(dirname $0)"
cd ../

config=$(realpath arise-out/config)

favicon="/relative/path/to/favicon.ico"

# Check if we're running a current version of bash before potentially causing code that won't run properly on ancient bash versions (such as the ones bundled on macOS):
[ "$BASH_VERSINFO" -lt 5 ] && echo -e 'ERROR: Arise requires Bash version 5 or greater to run. Please install a newer version of Bash or ensure that you are using the newest version installed on your computer.\n\nYour current version of Bash is: '"$BASH_VERSINFO"'\n\nYou can verify the current running version of Bash by running the following command: echo "$BASH_VERSINFO"' && exit 1

# Makes sure that our paths have or don't have a '/' as expected regardless of user input.
## Favicon should have a '/' at the start of the path.
[[ $favicon != '' ]] && [[ ${favicon:0:1} != '/' ]] && favicon='/'"$favicon"
## Base URL should not have a '/' at the end.
[[ ${base_url: -1} == '/' ]] && base_url=${base_url::-1}

# Source functions
for FILE in tools/functions/inline/* ; do [[ $FILE == *.sh ]] && source $FILE ; done
for FILE in tools/functions/subshell/* ; do [[ $FILE == *.sh ]] && source $FILE ; done

# Display our pretty logo no matter what when the program is run :)
arise_logo

# Read our arguments and set the build mode for processing. Display help if an invalid option is made.
if [[ $@ == "build" ]]; then
        arise_build="full"
        echo "Starting site deploy. Building full site."
elif [[ $@ == "build -k" ]]; then
        arise_build="full"
        keep_source=true
        echo "Starting site deploy. Building full site. Source .md files will be retained in the final output."
elif [[ $@ == "build -f" ]]; then
        arise_build="full"
        echo "Starting site deploy. Building full site."
        echo;
        read -p 'WARNING: Specifying "-f" will DELETE the current contents of '"$(realpath arise-out)"'. Proceed? [y/N]: ' -n 1 -r;
        echo;
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                force_overwrite=true;
        else
                echo 'Aborting.';
                exit 1;
        fi;
elif [[ $@ == "build -kf" ]] || [[ $@ == "build -fk" ]]; then
        arise_build="full"
        keep_source=true
        echo "Starting site deploy. Building full site. Source .md files will be retained in the final output."
        echo;
        read -p 'WARNING: Specifying "-f" will DELETE the current contents of '"$(realpath arise-out)"'. Proceed? [y/N]: ' -n 1 -r;
        echo;
        if [[ $REPLY =~ ^[Yy]$ ]]; then
                force_overwrite=true;
        else
                echo 'Aborting.';
                exit 1;
        fi;
else
        while getopts ":psrkf" options; do
                case "${options}" in
                        p)
                                [[ -n "$arise_build" ]] && { arise_help; echo -e '\n\nERROR: Multiple exclusive build options detected. Aborting.'; exit 1; }
                                arise_build="pages_only";
                                echo "Starting site deploy. Building pages only.";
                                ;;
                        s)
                                [[ -n "$arise_build" ]] && { arise_help; echo -e '\n\nERROR: Multiple exclusive build options detected. Aborting.'; exit 1; }
                                arise_build="sitemap_only";
                                echo "Starting site deploy. Building sitemap only.";
                                ;;
                        r)
                                [[ -n "$arise_build" ]] && { arise_help; echo -e '\n\nERROR: Multiple exclusive build options detected. Aborting.'; exit 1; }
                                arise_build="rss_only";
                                echo "Starting site deploy. Building RSS feed only.";
                                ;;
                        k)
                                keep_source=true;
                                echo "Source .md files will be retained in the final output."l
                                ;;
                        f)
                                echo;
                                read -p 'WARNING: Specifying "-f" will DELETE the current contents of '"$(realpath arise-out)"'. Proceed? [y/N]: ' -n 1 -r;
                                echo;
                                if [[ $REPLY =~ ^[Yy]$ ]]; then
                                        force_overwrite=true;
                                else
                                        echo 'Aborting.';
                                        exit 1;
                                fi;
                                ;;
                esac
        done
fi

[[ -z "$arise_build" ]] && { arise_help; exit 1; }
echo

# Make sure "arise_out" is empty and copy the source files over there to work from during the build process.
[[ -d arise-out ]] && [[ "$force_overwrite" == true ]] && rm -rf arise-out
mkdir -p arise-out
[[ -n "$(ls -A arise-out)" ]] && echo -e 'ERROR: The build output directory "/arise-out" is not empty. Program aborted to prevent overwrite of existing data.\nPlease empty the output directory before running Arise againw.' && exit 1
cp -rT arise-source arise-out

# Run the build process depending on whatever options have been set
if [[ "$arise_build" == "full" ]] || [[ "$arise_build" == "pages_only" ]]; then
        echo -n "Building pages..."
        build_page_tree || { echo "ERROR: An error was encountered while building pages. Aborting build cycle."; exit 1; }
        echo " DONE."
fi

if [[ "$arise_build" == "full" ]] || [[ "$arise_build" == "rss_only" ]]; then
        echo -n "Building RSS feed..."
        build_rss arise-out/rss.xml || { echo "ERROR: An error was encountered while building the RSS feed. Aborting build cycle."; exit 1; }
        echo " DONE."
fi

if [[ "$arise_build" == "full" ]] || [[ "$arise_build" == "sitemap_only" ]]; then
        echo -n "Building sitemap..."
        build_sitemap arise-out/sitemap.xml || { echo "ERROR: An error was encountered while building the sitemap. Aborting build cycle."; exit 1; }
        echo " DONE."
fi

if [[ "$keep_source" == false ]]; then
        echo -n "Deleting source files from output..."
        clean_output || { echo "ERROR: An error was encountered while deleting source files. Aborting build cycle."; exit 1; }
        echo " DONE."
fi

echo -e '\nBuild completed! Built artefacts have been generated at:\n'"$(realpath arise-out)"
