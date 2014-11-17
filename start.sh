#!/bin/bash

BUNDLE_PATH=${BUNDLE_PATH:-.}
BUNDLE_MAIN=${BUNDLE_MAIN:-index.py}
FIG_PATH=$(mktemp -d /tmp/bundletest.XXXXXXXX)

echo "BUNDLE_PATH: $BUNDLE_PATH"
echo "BUNDLE_MAIN: $BUNDLE_MAIN"
echo "Working Directory: $FIG_PATH"

cp Dockerfile fig.yml $FIG_PATH
cp -r $BUNDLE_PATH $FIG_PATH/bundle

sed -i "s/\$FIG_PATH/"$(echo $FIG_PATH | sed -e 's/[\/&]/\\&/g')"/g" $FIG_PATH/fig.yml
sed -i "s/\$BUNDLE_PATH/"$(echo $BUNDLE_PATH | sed -e 's/[\/&]/\\&/g')"/g" $FIG_PATH/fig.yml

fig -p bundletest -f $FIG_PATH/fig.yml  up
