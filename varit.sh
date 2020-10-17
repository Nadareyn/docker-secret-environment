#!/bin/sh

file_dir=`dirname $0`

if [ ! -f "/bin/bash" ]
then
    apk --no-cache add bash
fi

eval "$($file_dir/generate_exports.sh)"
eval "$@"
