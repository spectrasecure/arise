![ARISE](./logo/arise-logo-transparent.png)

# The Bash Static Site Generator
*A step back from [Ghost](https://ghost.org/), in the shell.*

---

## TODO
- Tear apart markdown-page-builder and markdown-sitebuilder into individual functions
- Create new metadata types that are needed for better control:
    - is_toc: Need to check if any given index.md is a TOC so that main() knows whether it should build a normal page or a TOC out of any given page
    - eval_on: Define whether or not main() should run a function to evaluate inline bash snippets on pages
    - process_markdown: Define whether main() should run a given page through pandoc/eval before throwing on a header and footer. Useful to be able to turn this off when porting pages from existing webpages that are already have their body written in HTML and shouldn't thus be converted from markdown, but still need the header+footer appended dynamically at build time.
- Create a function to delete all build source files after everything has been processed
- Build out main() glue code so that it can actually run all the functions and perform a site deploy from start to finish
- Create GitHub actions script for deploying to GitHub Pages from a repo

### Documentation Tasks
- Scrub personal site details out and create a real template website that is better for showcasing the program
- Clean up code comments so that they all use a standardised format in each function
- Add a license file
    - Add licensing documentation for logo fonts. Both are CC-BY-SA so should be pretty simple, but I want to make a readme for attribution nonetheless
- Write a real readme to showcase this project

### Optimisations
- Refactor inline bash evaluation function. Right now it only works on very tiny/simple snippets because my logic for parsing out the command string for eval isn't very good.
- Allow inline bash eval in the site footer
- Move the hardcoded TOC formatting in `build_toc` into a configurable template within `.config`
- Remove the use of a temp file from `build_toc` and make it use arrays instead so that we're not using lazy IO calls for no good reason
