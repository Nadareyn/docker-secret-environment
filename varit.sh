#!/bin/sh

file_dir=`dirname $0`

if [ ! -f "/bin/bash" ]
then
    apk --no-cache add bash
    eval "$($file_dir/generate_export.sh)"
    eval "$1"
fi
