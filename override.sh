#!/bin/bash

varit_key="VARIT_OVERRIDE__"
vars=$(set | grep "=$varit_key" | grep -v "varit_key=$varit_key")
files=$(ls /run/secrets/)
for var in $vars; do
  var_name=$(echo "$var" | sed 's/=.*//')
  var_value=$(echo "$var" | sed 's/[^=]*=//')
  var_value="${var_value//$varit_key/}"
  echo "echo \"Replacing $var_name\""
  for file in $files; do
    secret=$(tail /run/secrets/$file)
    var_value="${var_value//__${file}__/$secret}"
  done

  echo "export $var_name=$var_value"
done
