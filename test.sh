#!/bin/sh

>&2 echo "Update database..."
#STATUS=`service nginx status | awk -F " " '{ print $0 }'`
#STATUS=`service nginx status`
STATUS=`service nginx status service nginx status | awk -F " " '{ print $3 }' | awk -F "." '{ print $1 }'`
while [ $STATUS != "running" ]; do
    >&2 echo "Waiting server is running..."
    sleep 1
done
