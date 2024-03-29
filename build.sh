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

```
EOL

license-checker --production --relativeLicensePath --direct --start ../dcfrontend  >> docs/licences.md

echo '```' >> docs/licences.md

echo 'building mkdocs'
pip3 install mkdocs
pip3 install mkdocs-material
pip3 install fontawesome_markdown
python3 -m mkdocs build --clean

#mkdocs serve

# update slides
mkdir site/slides
npx @marp-team/marp-cli slides/innovation/innovation.md -o ./site/slides/innovation/index.html

rsync -avz --exclude .git/ --del -e "ssh -p 722" site/ macropeo@77.72.0.226:/home/macropeo/docs.datacontroller.io
