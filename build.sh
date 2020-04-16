#!/bin/bash
####################################################################
# PROJECT: Data Controller Docs                                    #
####################################################################

## Create regular mkdocs docs

echo 'extracting licences'

OUTFILE='docs/licences.md'

cat > $OUTFILE <<'EOL'
<!-- this page is AUTOMATICALLY updated!! -->
# Data Controller for SAS® - Source Licences

## Overview
Data Controller source licences are extracted automatically from our repo using the [license-checker](https://www.npmjs.com/package/license-checker) NPM module

<code>
EOL

license-checker --production --relativeLicensePath --direct --start ../dcfrontend  >> docs/licences.md

echo '</code>' >> docs/licences.md

echo 'building mkdocs'
mkdocs build --clean

#mkdocs serve

rsync -avz --exclude .git/ --del -e "ssh -p 722" ~/git/dcdocs/site/ macropeo@77.72.0.226:/home/macropeo/docs.datacontroller.io
