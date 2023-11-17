<!-- BEGIN ARISE ------------------------------
Title:: "CI Test Suite - XML Reserved Characters & < > ' ""

Author:: "Spectra Secure & < > ' ""
Description:: "This post tests if we are properly filtering XML reserved characters in page metadata & < > ' ""
Language:: "en"
Thumbnail:: "kanagawa.jpg"
Published Date:: "2023-11-08"
Modified Date:: "2023011-08"

---- END ARISE \\ DO NOT MODIFY THIS LINE ---->

# CI Test Suite - XML Reserved Characters

This page is part of a test suite to ensure that when a user tries to stick XML reserved characters into page metadata, such characters are properly converted to escape characters. This way we ensure that such characters don't break the monolithic sitemap or RSS feed.

The way we do this is by having a test page in our template site which contains a post whose title, author, and destripction all contain the XML reserved characters (&<>'"). This test suite verifies that this output page has all of the reserved characters properly sanitised to the escape code versions, so that they're safe to handle within the site's XML sitemap and RSS feed.
