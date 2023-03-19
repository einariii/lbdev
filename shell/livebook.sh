#! /bin/bash

if [ $# -eq 0 ]; then
    LB=./notebooks
else
    LB=$1
fi

echo "livebook server $LB"
livebook server "$LB"
