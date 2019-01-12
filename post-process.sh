#!/bin/bash
### Post-process .html files (after being converted from .org)
### to make sure that they are properly formatted for jekyll.
### Example:
###     ./post-process.sh ../_posts/*.html

### if there are no argument, display the usage
if [ $# -eq 0 ]
then
    echo "
Usage: $0 [<file>|<glob>]...

Example:
    ./post-process.sh ../_posts/*.html
"
    exit 1
fi

### process each file given as an argument
for file in $@
do
    echo $file

    ### make sure that the yaml front matter is on top of the file
    file_org="_org/_posts/$(basename ${file%.html}).org"
    (sed -n -e '/^---$/,/^---$/p' $file_org; cat $file) > $file.new
    mv $file.new $file

    ### fix the path (url) of images by adding a slash (/) in front of it
    sed -i $file -e 's|="images/|="/images/|g'
done
