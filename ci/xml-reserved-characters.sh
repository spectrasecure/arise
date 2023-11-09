#!/bin/bash
echo "Arise CI - XML Reserved Character Sanitisation"
echo "=============================================="
echo "This is a test suite to ensure that when a user tries to stick XML reserved characters into page metadata that such characters are properly converted to escape characters to ensure that they don't break the monolithic sitemap or RSS feed."
echo ""
echo ""
echo "Testing to ensure the Arise site built the test suite page..."
testpage='arise-out/posts/ci-xml-reserved-characters/index.html'
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
titletest="<title>Test Suite - XML Reserved Characters &#38; &#60; &#62; &#39; &#34;"
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
