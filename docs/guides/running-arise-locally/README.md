# Running Arise Locally

The following instructions will walk you through how to build an Arise website by running Arise on your local machine. This is primarily intended for development and not regular use. If you just want to throw up an Arise website as easily as possible, please use the cloud native instructions in the [Getting Started](../getting-started/README.md) guide.

1. Ensure you have the [proper dependencies](/README.md#dependencies) installed.
2. Clone this repo and cd into it: `git clone https://github.com/spectrasecure/arise && cd arise`
3. Edit the global Arise site configuration file at `/arise-source/config/arise.conf`
4. Edit the example site in `/arise-source/` to your liking
    - Check out the page on [creating pages](../creating-arise-pages/README.md) for more information on the specifics of how Arise pages work
5. Configure your `robots.txt` in the root of the repository with your site domain and any additional crawler settings you'd like to set.
6. Build Arise by running `bash arise build`
7. Your built site will be output to `arise-out/`. It is up to you to upload these wherever to host your site.

### Command Line Arguments for Arise

The Arise shell script allows for several partial build modes, largely for testing purposes. These options are also displayed to you in the Help prompt which is displayed if you attempt to run Arise without any options or with invalid options.

```
Usage:
------
bash arise build -[k][f]
        # Builds the entire site
        available in all build modes:
                -k: Keeps source files in output
                -f: Force overwrite pre-existing output
bash arise -[p|s|r][k][f]
        # Builds only specific parts of the site
        # Useful for testing purposes
        mutually exclusive options:
                -p: Build pages only mode
                -s: Build sitemap only mode
                -r: Build rss only mode
```

- `bash arise -p` - Running Arise in this manner will only build (p)ages. It will not build the sitemap or the RSS feed.
- `bash arise -s` - Running Arise in this manner will only build the (s)itemap. It won't build anything else.
- `bash arise -r` - Running Arise in this manner will only build the (r)ss feed. It won't build anything else.
- `-k` - Adding this flag to any build mode will (k)eep the source files in the output directory rather than deleting them from the output.
- `-f` - By default, Arise will throw an error if the output folder `arise-out` already has contents in it in order to prevent you from accidentally overwriting your current built output. If you would like to override this safeguard and (f)orce Arise to delete the current contents of `arise-out`, this is the flag to do so.
