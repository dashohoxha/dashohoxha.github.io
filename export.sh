#!/bin/bash
### Convert .org files to .html and make sure
### that they are properly formatted for jekyll.
### Example:
###     ./export.sh _org/_posts/2019-*.org

### if there are no argument, display the usage
if [ $# -eq 0 ]
then
    echo "
Usage: $0 [<file>|<glob>]...

Example:
    ./export.sh _org/_posts/2019-*.org
"
    exit 1
fi

cd $(dirname $0)

### process each file given as an argument
for file in $@
do
    echo "--> Exporting: $file"
    if [[ ${file%.org} == $file ]]; then
        echo "File '$file' does not have extension .org"
	    continue
    fi

    ### export .org files to .html
    emacs $file --batch -f org-html-export-to-html --kill

    ### make sure that the yaml front matter is on top of the file
    file_html="${file%.org}.html"
    (sed -n -e '/^---$/,/^---$/p' $file; cat $file_html) > $file_html.new
    mv $file_html.new $file_html

    ### fix the path (url) of images by adding a slash (/) in front of it
    sed -i $file_html -e 's|="images/|="/images/|g'

    ### move html file to directory _posts/
    mv $file_html _posts/
done
