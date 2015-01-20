#!/bin/bash

set -e

CONSOLE=0
if [ $1 == "console" ]; then
	CONSOLE=1
fi
BUNDLE_PATH=${BUNDLE_PATH:-.}
BUNDLE_MAIN=${BUNDLE_MAIN:-index.py}
FIG_PATH=$(mktemp -d /tmp/bundledev.XXXXXXXX)

echo "BUNDLE_PATH: $BUNDLE_PATH"
echo "BUNDLE_MAIN: $BUNDLE_MAIN"
echo "Working Directory: $FIG_PATH"

cp .dockerignore Dockerfile fig.yml $FIG_PATH
cp -r $BUNDLE_PATH $FIG_PATH/bundle

sed -i "s/\$FIG_PATH/"$(echo $FIG_PATH | sed -e 's/[\/&]/\\&/g')"/g" $FIG_PATH/fig.yml
sed -i "s/\$BUNDLE_PATH/"$(echo $BUNDLE_PATH | sed -e 's/[\/&]/\\&/g')"/g" $FIG_PATH/fig.yml
sed -i "s/\$BUNDLE_MAIN/"$(echo $BUNDLE_MAIN | sed -e 's/[\/&]/\\&/g')"/g" $FIG_PATH/fig.yml

if [ $CONSOLE == 1 ]; then
	fig -p bundledev -f $FIG_PATH/fig.yml run bundle /bin/bash -l
else
	fig -p bundledev -f $FIG_PATH/fig.yml up
fi

