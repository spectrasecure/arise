# Getting Started with Arise

Welcome to Arise! Arise is designed to be a cloud-native application. This guide will walk you through the basics of how to build and deploy your website to the cloud using Arise.

It's actually very simple to get a website up and running using Arise.

## Cloud Deployments

1. Fork this repo
2. Edit the global Arise site configuration file at `/arise-source/config/arise.conf`
3. Edit the example site in `/arise-source/` to your liking
    - Check out the page on [creating pages](../creating-arise-pages/README.md) for more information on the specifics of how Arise pages work
4. Configure your `/arise-source/robots.txt` with your site domain and any additional crawler settings you'd like to set.
5. Upon any new commit to the site source files, the GitHub Actions workflow present in `/.github/workflows/` will automatically build your website based on the contents of `/arise-source/` and output the built files to your `html` branch.
6. Configure your cloud web host of choice to automatically deploy a static site from the `html` branch of your repo. Specific instructions for several notable providers can be found below:
    - [Cloudflare Pages](cloudflare/README.md)
    - [DigitalOcean](digitalocean/README.md)
    - [GitHub Pages](github-pages/README.md)

Congrats! Your site is now up and running! If you want to make changes to your website, you can simply make a commit to the `main` branch of your repo source files and it will automatically be deployed to your live website! Pretty wiz, yeah?

## Running Arise Locally (Not Recommended)

You can also clone this repo and run Arise locally. However, this not recommended because you are honestly wasting your time by manually running the build process and managing the build artefacts instead of just sitting back and letting CI/CD do the work for you.

If you REALLY want to run Arise locally, please refer to [this guide](../running-arise-locally/README.md).
