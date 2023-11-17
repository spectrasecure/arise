![ARISE](./docs/logo/arise-logo_transparent.png)

# Arise // Bash Static Site Generator
*Cyberpunk websites for the modern web.*

---

## Overview

There was a time before React, before Wordpress, and before even javascript and php. And the webmasters who ran the 'net back then made do with what they had. They wrangled their webservers to the fullest and they hacked together sites that could do what they need. 

The web has grown up a lot since then, but the mentality of "move fast and break things" has created a landscape of flaky tools never meant to last more than a few years without constant laborious maintenance. You should be able to run a functional and pleasant website without needing to be a fully staffed corporate webdev team.

The goal of Arise is to take the lessons of yesteryear and make something novel. Arise is a cloud-native static site generator written in Bash, designed to be a fusion of ultra-stable 90s technology and modern DevOps paradigms. Arise is designed around use cases like individual blogs and personal websites.

## Why Use Arise

Arise is written in Bash with very few dependencies outside of the standard GNU toolchain. Arise is designed with long term simplicity and maintainability in mind. Beyond just being a static site generator that doesn't suck, the core development philosphy behind Arise is to minimise the risk of breaking in the near future due to language or dependency updates.

Arise supports modern SEO features that are built into your pages out of the box without any extra effort necessary:
- [OpenGraph](https://ogp.me/) and [TwitterCard](https://developer.twitter.com/en/docs/twitter-for-websites/cards/overview/abouts-cards) support for rich embed details
- Dynamically generated RSS feed
- Dynamically generated search engine sitemap

Arise is built to be practical and let you build a multi-page website that actually has real content on it. Arise uses a modular page architecture with support for dynamically generated metadata-rich index pages to keep your site hierarchy traversable by end users.

## Live Example

A live demo of Arise can be found at https://ari.se.net

The example site is actually deployed straight from this repository, so the contents you see there are exactly what you get if you were to fork this exact repo and host it yourself.

## Getting Started / Documentation

All of the documentation for getting started with Arise can be found within this repository.

- [Getting Started with Arise](docs/guides/getting-started/README.md)
    - [Cloudflare Pages](docs/guides/getting-started/cloudflare/README.md)
    - [DigitalOcean](docs/guides/getting-started/digitalocean/README.md)
    - [GitHub Pages](docs/guides/getting-started/github-pages/README.md)
- [Creating Arise Pages](docs/guides/creating-arise-pages/README.md)
- [Running Arise Locally](docs/guides/running-arise-locally/README.md)

## Dependencies
- Bash 5.1
    - **Used for:** 😐
    - **Why:** Do you see what language this program is written in?
- [pandoc](https://pandoc.org/)
    - **Used for:** `build_page` - Function that builds pages from a `.md` source file
    - **Why:** Arise uses Pandoc for conversion of Markdown to HTML. If your source pages are already in HTML and you don't need Markdown conversion, you can disable Markdown conversion on individual pages with the use of an Arise page option (see above).
- GNU `date`
    - **Used for:** `build_rss` - RSS feed generator function
    - **Why:** You see, RSS is kind of ridiculous because it asks for dates in RFC-822 (stupid) rather than the usual ISO 8601 format used by developers who weren't dropped on their head as a child. GNU's implementation of the date command has a flag to accomodate this, but it's not available on BSD/macOS.
- GNU `find`
    - **Used for:** `build_toc` - Function that builds TOC/index pages
    - **Why:** Only the GNU version supports `-maxdepth`. This flag is used for the TOC indexer function to ensure that only folders in the current directory (and not subfolders of those) get put into your indices.
- GNU `awk`
    - **Used for:** `evaluate_inline` - Function that performs inline bash snippet evaluations. This is disabled by default because this functionality is still WIP.
    - **Why:** Using `awk` in any capacity is the equivalent of staring into a horrific eldrich abyss not meant for mere mortals. Making those commands portable is another story entirely.
- `sed`
    - **Used for:**
        - `get_page_metadata` - Used to pull out the metadata header in Arise markdown files for further processing. Also used for cleaning up relative URLs generated from folder hierarchy.
        - `build_page` - Used to pull out the metadata header in Arise markdown files for further processing.
        - `build_sitemap` - Used to clean up URLs into the tags RSS wants them in.
        - `evaluate_inline` - Yeah, I don't even want to think about the horrors I wrote in this function. It's not currently in use, and I'm pretty sure it will get a full rewrite before it becomes active, IF it becomes active...
    - **Why:** `sed` is useful for parsing data out of blocks of text quickly and easily. However, much dogfooding has revealed that `sed` tends to be pretty unsuited for this application. As such, it is largely on the chopping block for replacement with native Bash pattern matching where possible.

## CI Testing

For development purposes, we use CI testing to ensure that new code changes don't break Arise while in development. CI-related scripts are bundled in `/ci` and CI-related workflows are named with the convention of `/.github/workflows/ci-*`. **As a non-maintainer who is not making modifications to the Arise source code, you can simply delete (or just ignore) the CI tests if you don't need them.**

In order to maximise the amount of [dogfooding](https://en.wikipedia.org/wiki/Eating_your_own_dog_food) we do in testing, CI tests are run against actual pages bundled as part of the default website (https://ari.se.net). This means that once you replace the default site with your own custom website, the CI tests will break because the dummy pages they rely on no longer exist.

## Wishlist / To-Do / Feature Ideas
- Refactor inline bash evaluation function and enable its usage. Right now it only works on very tiny/simple snippets. The main reason I wrote the logic was because I thought it would be funny to implement (it was). Some refactoring is absolutely necessary to make this feature practical/useful and not just a good meme.
   - Allow inline bash evaluations in the site headers and footers
- Add support for metadata tag usage in the site footer.
- Move the hardcoded TOC formatting in `build_toc` into a configurable template within `.config`
- Bundle and implement [Markdown.pl](https://daringfireball.net/projects/markdown/) as a fallback rendering engine for systems that do not have pandoc installed.
- Add support for inline include statements for html snippets saved in the `/config` folder so that it's possible to write reusable little bits for pages.
- Implement better error handling. Right now it's wishy washy and in many ways basically nonexistent-- most stuff will silently error or otherwise not gracefully cause an abort.
    - As far as dependency checks, right now it only checks if your bash version is good. Maybe could consider implementing checks for the other dependencies. It's really hard to determine if something is GNU or not, though.

## License, Disclaimers, and Acknowledgements
All the legal bulldrek relevant to this repository can be found [here](LICENSE/README.md).

A summary\* of the license terms (which is not a substitute for the above-linked licensing information itself) is:
- The example site is MIT License
    - **TL;DR:** You can edit and do whatever with it. Go crazy, choom. You can license your own website built off my example however you damn please.
- The logo is Creative Commons CC-BY-SA 4.0
    - **TL;DR:** You can do what you want with it as long as you let anyone else do the same with any derivatives you redistribute.
- All the Arise code itself is AGPL 3.0
    - **TL;DR:** You have to give people a copy of your version of the source code if you modify and/or redistribute it in any way when you use it to create and deploy your website.
    - If you don't modify the Arise software code itself and don't redistribute it, you don't need to host the source code for other people. But, to be clear, removing the link to this repository from the help function constitutes as modification as far as AGPL is concerned.
    - AGPL scares a lot of people. I'm not a lawyer and this is not legal advice, but check out [this cool article about AGPL](https://writing.kemitchell.com/2021/01/24/Reading-AGPL.html) and maybe it will make it a little less scary for you :)

\*This summary highlights only some of the key features and terms of the actual license. It is not a license and has no legal value. You should carefully review all of the terms and conditions of the actual license before using the licensed material. Also, I am not a lawyer and none of this is legal advice.

---

*Made with 💙 by [Spectra Secure](https://twitter.com/spectrasecure)*

*Inspired by the geniuses over at [motherfuckingwebsite.com](https://motherfuckingwebsite.com/)*
