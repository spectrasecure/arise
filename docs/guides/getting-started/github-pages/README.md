# Deploying to GitHub Pages

This guide assumes that you have completed steps 1-3 from [Getting Started](../README.md) and have a successfully build website in your `html` branch.

This guide will also assume that you don't already have a GitHub Pages site and are using Arise to host your User Site. For Project Sites, please review [GitHub's documentation](https://docs.github.com/en/pages/getting-started-with-github-pages/about-github-pages#types-of-github-pages-sites).

Frankly, the configuration annoyance of GitHub Pages with multiple hosted sites is a pretty good reason to use a provider like [Cloudflare Pages](../cloudflare/README.md) or [DigitalOcean](../digitalocean/README.md) instead.

1. Name your repo to **yourusername.github.io**. 
2. Navigate to your repo and click **Settings** in the navbar.
3. Click **Pages** in the sidebar.
4. Under the dropdown for **Source**, click **Deploy from a branch**.
5. Select the `html` branch. Leave `/ (root)` as the folder and click **Save**.

Congrats! Your Arise website is now live on GitHub Pages. If you'd like to use a custom domain, please review GitHub's [custom domains guide](https://docs.github.com/articles/using-a-custom-domain-with-github-pages/) as that is outside of the scope of this documentation.
