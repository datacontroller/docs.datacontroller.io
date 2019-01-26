#!/bin/bash
####################################################################
# PROJECT: Data Controller Docs                                    #
####################################################################

## Create regular mkdocs docs
echo 'building mkdocs'
mkdocs build --clean

#mkdocs serve

rsync -avz --exclude .git/ --del -e "ssh -p 722" ~/git/dcdocs/site/ macropeo@77.72.0.226:/home/macropeo/docs.datacontroller.io
