#!/bin/bash
testpage='arise-out/posts/ci-xml-reserved-characters/index.html'

echo "Arise CI - XML Reserved Character Sanitisation"
echo "=============================================="
echo "This is a test suite to ensure that when a user tries to stick XML reserved characters into page metadata, such characters are properly converted to escape characters. This ensures that such characters don't break the monolithic sitemap or RSS feed."
echo ""
echo "The way we do this is by having a test page in our template site (""$testpage"") which contains a post whose title, author, and destripction all contain the XML reserved characters (&<>'"'"'"). This test suite verifies that the output page has all of the reserved characters properly sanitised to the escape code versions, so that they're safe to handle within the site's XML sitemap and RSS feed."
echo ""
echo ""

echo "Testing to ensure the Arise site built the test suite page..."
if [ -f $testpage ] 
then
        echo "SUCCESS!"
else
        echo "FAILED. No page was found where the test post is supposed to exist."
        echo " - Check that you haven't moved the test post located in arise-source/posts somewhere else"
        echo " - Check that you haven't broken Arise entirely"
        echo "Good luck, choom!"
        exit 1
fi
echo ""

echo "Testing to ensure that the title is rendering as it should..."
titletest="<title>CI Test Suite - XML Reserved Characters &#38; &#60; &#62; &#39; &#34;"
if [[ $(grep "$titletest" $testpage) ]]
then
        echo "SUCCESS!"
else
        echo "FAILED. The page title we were looking for did not render properly."
        echo ""
        echo "Pattern we were trying to match:"
        echo "$titletest"
        echo "==========="
        echo "Full line that contains a discrepancy:"
        echo "$(grep '<title>' $testpage | head -1)"
        exit 1
fi
echo ""

echo "Testing to ensure that the author is rendering as they should..."
authortest='<meta name="author" content="Spectra Secure &#38; &#60; &#62; &#39; &#34;">'
if [[ $(grep "$authortest" $testpage) ]]
then
        echo "SUCCESS!"
else
        echo "FAILED. The page author line we were looking for did not render properly."
        echo ""
        echo "Pattern we were trying to match:"
        echo "$authortest"
        echo "==========="
        echo "Full line that contains a discrepancy:"
        echo "$(grep '<meta name="author"' $testpage | head -1)"
        exit 1
fi
echo ""

echo "Testing to ensure that the description is rendering as it should..."
descriptiontest='<meta name="description" content="This post tests if we are properly filtering XML reserved characters in page metadata &#38; &#60; &#62; &#39; &#34;">'
if [[ $(grep "$descriptiontest" $testpage) ]]
then
        echo "SUCCESS!"
else
        echo "FAILED. The page description line we were looking for did not render properly."
        echo ""
        echo "Pattern we were trying to match:"
        echo "$descriptiontest"
        echo "==========="
        echo "Full line that contains a discrepancy:"
        echo "$(grep '<meta name="description"' $testpage | head -1)"
        exit 1
fi
