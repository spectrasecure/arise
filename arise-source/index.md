<!-- BEGIN ARISE ------------------------------
Title:: "Bash Static Site Generator"

Author:: "Spectra Secure"
Description:: "Arise is the most polished cloud-native static site generator written in Bash."
Language:: "en"
Thumbnail:: "arise-icon.png"
Published Date:: "2022-09-17"
Modified Date:: "2022-09-17"

content_header:: "false"
rss_hide:: "true"
---- END ARISE \\ DO NOT MODIFY THIS LINE ---->

# Retro doesn't have to be regressive

Arise is a static site generator written in Bash, designed to be a fusion of ultra-stable 90s technology and modern DevOps paradigms. Arise is designed around use cases like individual blogs and personal websites.

Let me tell you why Arise exists. You ever seen one of those nineties zombie websites that hasn't been updated in like thirty years but is still somehow running today? [Stuff like this](http://home.mcom.com/home/welcome.html). Can you imagine a modern website lasting that long without becoming a completely broken mess?

We live in a world where the mindset of "move fast, break things" has trained web developers to keep stacking more and more overdesigned trash onto their websites, one node framework or polyfill at a time. Over time, we've collectively lost the plot and forgotten that websites are ultimately a tool to share information with other people.

Arise was built to show that you can take simple technology like Bash that is so set in stone as to be basically indestructible and use it to create modern web tools.

## Simplify deployment

90s websites may have been robust in their simplicity, but no one likes setting up a janky webserver on a computer in their closet. Arise is a modern cloud-native application that supports easy deployment to your cloud static site host of choice.

Simply fork [Arise on Github](https://github.com/spectrasecure/arise), edit your site, and point your cloud vendor to your repository. The included CI workflow does all the hard work of building and deploying your site straight from the cloud.

## Timeless tech built for the modern web

Arise websites may be spartan on the surface, but they are designed to take advantage of modern web conventions for rich content presence and SEO.

- Rich metadata for cross-site embeds with support for [OpenGraph](https://ogp.me/) and [TwitterCard](https://developer.twitter.com/en/docs/twitter-for-websites/cards/overview/abouts-cards)
- Dynamic sitemap generation for SEO
- Dynamic RSS feed generation

## Practical pages for real-world use

Most projects like this are one-off tech demos. While many of them "work", they often lack critical CMS-style features that are important for actually organising stuff on your website. Real websites don't have just one page, but rather are built on top of hierarchies of linked pages. 

Arise solves this problem by building websites that are designed to be modular, hierarchical, and traversable. Arise supports the creation of dynamic index pages based on individual page metadata— just tell Arise where you need an index, and it will build it for you all on its own.

For an example of what index pages created by Arise look like, check out the [Sample Posts](posts) on this website.

## Get started with Arise

Arise is free open-source software, available on [GitHub](https://github.com/spectrasecure/arise) under the [GNU AGPL License](https://www.gnu.org/licenses/agpl-3.0.en.html).
